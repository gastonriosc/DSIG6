using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class Escuela
    {
        public static DataTable mostrarNombreEscuelas()
        {
            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            try
            {
                SqlCommand cmd = new SqlCommand();

                string consulta = "SELECT * FROM ESCUELAS";       // consulta a realizar.

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                DataTable tabla = new DataTable();                // define una tabla vacia.
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(tabla);                                   // llena la tabla con los datos de la consulta.

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
