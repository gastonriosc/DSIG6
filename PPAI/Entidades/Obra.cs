using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class Obra
    {
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
    }
}
