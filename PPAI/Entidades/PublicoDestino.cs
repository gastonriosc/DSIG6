using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class PublicoDestino
    {
        public static string ObtenerPublicoDestino(int idPublico)
        {
            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion);       // establece conexion con la BD.

            try
            {
                SqlCommand cmd = new SqlCommand();

                string consulta = "SELECT nombre FROM PUBLICOS_DESTINO WHERE id_publico = @idPublico";   // devuelve el nombre del publico cuando su id es @idPublico.

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@idPublico", idPublico);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                string nombrePublico = cmd.ExecuteScalar().ToString();
                return nombrePublico;
            }
            catch (Exception)    // si no se puede establecer la conexion con la BD captura el error en Exception.
            {
                throw;
            }
            finally
            {
                cn.Close();      // cierra la conexion con la BD para liberar recursos.
            }
        }
    }
}
