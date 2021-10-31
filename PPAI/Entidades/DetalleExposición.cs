using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class DetalleExposición
    {
        public int CalcularDuración(int id)
        {
            int duración = 0;

            DataTable tabla = RecuperarDetalle(id);
            for (int i =0; i < tabla.Rows.Count; i++)
            {
                int idObra = int.Parse(tabla.Rows[i][0].ToString());
                Obra obra = new Obra();
                
                duración += obra.Duración(idObra);
            }

            return duración;
        }

        

        public DataTable RecuperarDetalle(int id)
            {
            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            try
            {
                SqlCommand cmd = new SqlCommand();

                string consulta = "SELECT id_obra FROM dbo.EXPOSICION JOIN dbo.DETALLES_EXP"
                    + " ON(dbo.EXPOSICION.id = dbo.DETALLES_EXP.id_exposicion)"
                    + " JOIN dbo.OBRAS ON(dbo.OBRAS.id = dbo.DETALLES_EXP.id_obra)"
                    + " WHERE dbo.EXPOSICION.id = @id";

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@id", id);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                DataTable tabla = new DataTable();               // define una tabla vacia.
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(tabla);                                  // llena la tabla con los datos de la consulta.

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
