using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class HorarioEmpleado
    {
        public static DataTable ObtenerGuiasParaReserva(string horaReservaInicio, string horaReservaFin, int idSede, int idDiaReserva)
        {
            // busca los empleados guias de la sede seleccionada y si trabajan el mismo dia que el dia de la nueva reserva.
            // tambien chequea que el horario de la nueva reserva este dentro de los horarios de trabajo de los empleados que trabajan el mismo dia de la nueva reserva.
            // recibe como parametros, la hora de inicio de la reserva, la hora de fin, el id de la sede seleccionada y el dia de la semana que cae la reserva.

            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            try
            {
                SqlCommand cmd = new SqlCommand();

                string consulta = "SELECT * FROM HORARIOS_EMP HE WHERE HE.dni_empleado IN(SELECT dni FROM EMPLEADOS WHERE cargo = 2 AND id_sede = @idSede) AND @horaReservaInicio BETWEEN hora_inicio and hora_fin AND @horaReservaFin BETWEEN hora_inicio and hora_fin AND id_dia_semana = @diaReserva";        // consulta a realizar.

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@idSede", idSede);
                cmd.Parameters.AddWithValue("@horaReservaInicio", horaReservaInicio);
                cmd.Parameters.AddWithValue("@horaReservaFin", horaReservaFin);
                cmd.Parameters.AddWithValue("@diaReserva", idDiaReserva);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                DataTable tabla = new DataTable();              // define una tabla vacia.
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(tabla);                                 // llena la tabla con los datos de la consulta.

                return tabla;
            }
            catch (Exception) // si no se puede establecer la conexion con la BD captura el error en Exception.
            {
                throw;
            }
            finally
            {
                cn.Close(); // cierra la conexion con la BD para liberar recursos.
            }
        }
    }
}
