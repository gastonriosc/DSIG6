using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class Asignacion
    {
        public static bool ObtenerGuiasDisponibles(int dniGuia, DateTime fechaInicioReserva, DateTime fechaFinReserva)
        {
            // controla que el dni del guia pasado por parametro no tenga ninguna asignacion de otra reserva que sea el mismo dia y hora de la nueva reserva.
            // recibe como paramentros, el dni del posible guia, la fecha y hora de inicio de la reserva y la fecha y hora de fin.

            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            bool resultado;

            try
            {
                SqlCommand cmd = new SqlCommand();

                string consulta = "SELECT * FROM ASIGNACION WHERE dni_empleado = @dniGuia AND ((@fechaInicioReserva BETWEEN FechaHoraInicio AND FechaHoraFin OR @fechaFinReserva BETWEEN FechaHoraInicio AND FechaHoraFin) OR (@fechaInicioReserva < FechaHoraInicio AND @fechaFinReserva > FechaHoraFin))";        // consulta a realizar.

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@dniGuia", dniGuia);
                cmd.Parameters.AddWithValue("@fechaInicioReserva", fechaInicioReserva);
                cmd.Parameters.AddWithValue("@fechaFinReserva", fechaFinReserva);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                DataTable tabla = new DataTable();              // define una tabla vacia.
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(tabla);                                 // llena la tabla con los datos de la consulta.

                if (tabla.Rows.Count == 0)                      // si la consulta no devuelve nada, es porque ese guia no tiene ninguna asignacion a otra reserva en la misma fecha y hora que la nueva reserva.
                {
                    resultado = true;
                }
                else
                {
                    resultado = false;
                }

            }
            catch (Exception) // si no se puede establecer la conexion con la BD captura el error en Exception.
            {
                throw;
            }
            finally
            {
                cn.Close(); // cierra la conexion con la BD para liberar recursos.
            }

            return resultado;
        }
    }
}
