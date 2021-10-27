﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class Exposicion
    {
        public static DataTable ObtenerExposXId(int id)
        {
            // busca los datos de la exposicion con id = @id.

            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            try
            {
                SqlCommand cmd = new SqlCommand();

                string consulta = "SELECT * FROM EXPOSICION where id = @id";

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
        public static DataTable buscarExposiciones(int idSede, int idTipoVisita, DateTime fechaActual)
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
                cmd.Parameters.AddWithValue("@fecha", fechaActual);
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
    }
}
