using PPAI_V1.Entidades;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Acceso_a_Datos
{
    class AD_Reserva
    {
        


        


        public static int ObtenerUltimoIdReserva()
        {
            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion);       // establece conexion con la BD.

            try
            {
                SqlCommand cmd = new SqlCommand();

                string consulta = "SELECT MAX(numero) FROM RESERVAS";   // devuelve el un numero de la ultima reserva realizada.

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                int UltimoNumeroReserva = (int)cmd.ExecuteScalar();
                return UltimoNumeroReserva;
            }
            catch (Exception)    // si no se puede establecer la conexion con la BD captura el error en Exception.
            {
                return 0;
            }
            finally
            {
                cn.Close();      // cierra la conexion con la BD para liberar recursos.
            }
        }



        public static DataTable ObtenerExpos(int idSede, int idTipoVisita)
        {
            // retorna una tabla con todos los datos de las exposiciones de una sede 'idSede' de acuerdo al 'idTipoVisita' seleccionado.

            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion);   // establece conexion con la BD.

            string consulta;

            if (idTipoVisita == 2)   // 2 es TipoVisita Por Exposicion.
            {
                consulta = "SELECT * FROM EXPOSICION where id_sede = @idSede AND @fecha BETWEEN fechaInicio AND fechaFin AND id_tipo_exp = @idTipoExpo";
            }
            else    // 'idTipoVisita' es 1, Completa, no filtra exposiciones por tipo de exposicion.
            {
                consulta = "SELECT * FROM EXPOSICION where id_sede = @idSede AND @fecha BETWEEN fechaInicio AND fechaFin";
            }

            try
            {
                SqlCommand cmd = new SqlCommand();

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@idSede", idSede);
                if (idTipoVisita == 2)
                {
                    cmd.Parameters.AddWithValue("@idTipoExpo", 2);         // 2 es tipo de exposicion temporal.
                }
                cmd.Parameters.AddWithValue("@fecha", DateTime.Now);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                DataTable tabla = new DataTable();               // define una tabla vacia.
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(tabla);                                  // llena la tabla con los datos de la consulta.

                return tabla;
            }
            catch (Exception)      // si no se puede establecer la conexion con la BD captura el error en Exception
            {
                throw;
            }
            finally
            {
                cn.Close();        // cierra la conexion con la BD para liberar recursos
            }
        }



        



        public static int BuscarDuracionExposiciones(int idExpo, int idTipoVisita)
        {
            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            string consulta;

            if (idTipoVisita == 2)  // 2 es TipoVisita Por Exposicion y utilizamos la columna de obras duracion extendida.
            {
                consulta = "SELECT SUM(O.duracion_ext) FROM OBRAS O WHERE O.id IN (SELECT id_obra FROM DETALLES_EXP WHERE id_exposicion = @idExpo)";
            }
            else                    //si es 1 es TipoVisita Completa y utilizamos la columna de obras duracion resumida.
            {
                consulta = "SELECT SUM(O.duracion_res) FROM OBRAS O WHERE O.id IN (SELECT id_obra FROM DETALLES_EXP WHERE id_exposicion = @idExpo)";
            }
            try
            {
                SqlCommand cmd = new SqlCommand();

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@idExpo", idExpo);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                int duracionEstimadaXExpo = (int)cmd.ExecuteScalar(); // devuelve la duracion estimada de la exposicion con id 'idExpo'.
                return duracionEstimadaXExpo;
            }
            catch (Exception)   // si no se puede establecer la conexion con la BD captura el error en Exception
            {
                throw;
            }
            finally
            {
                cn.Close();     // cierra la conexion con la BD para liberar recursos
            }
        }



        


        


        public static int ObtenerCapacidadMaxSede(int idSede)
        {
            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            string consulta = "SELECT cantMaxVisit FROM SEDES WHERE id = @idSede";

            try
            {
                SqlCommand cmd = new SqlCommand();

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@idSede", idSede);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                int cantMaxSede = (int)cmd.ExecuteScalar();
                return cantMaxSede;
            }
            catch (Exception) // si no se puede establecer la conexion con la BD captura el error en Exception
            {
                throw;
            }
            finally
            {
                cn.Close(); // cierra la conexion con la BD para liberar recursos
            }
        }


        



       


        

        



        
    }
}
