using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class Reserva
    {
        private int numero;
        private int cantVisitantes;
        private DateTime fechaReserva;
        private DateTime fechaCreacion;
        private int duracion;
        private string usuario;
        private int idEscuela;
        private int idSede;
        private int idTipoVisita;

        public Reserva(int num, int cantVisit, DateTime fechaR, DateTime fechaC, int durac, string usu, int escuela, int sede, int tipoVisit)
        {
            numero = num;
            cantVisitantes = cantVisit;
            fechaReserva = fechaR;
            fechaCreacion = fechaC;
            duracion = durac;
            usuario = usu;
            idEscuela = escuela;
            idSede = sede;
            idTipoVisita = tipoVisit;
        }
        public Reserva()
        {

        }

        public int numeroReserva
        {
            get => numero;
            set => numero = value;
        }
        public int cantVisitantesReserva
        {
            get => cantVisitantes;
            set => cantVisitantes = value;
        }

        public DateTime fechaDeReserva
        {
            get => fechaReserva;
            set => fechaReserva = value;
        }

        public DateTime fechaDeCreacion
        {
            get => fechaCreacion;
            set => fechaCreacion = value;
        }

        public int duracionReserva
        {
            get => duracion;
            set => duracion = value;
        }

        public string usuarioReserva
        {
            get => usuario;
            set => usuario = value;
        }

        public int escuelaReserva
        {
            get => idEscuela;
            set => idEscuela = value;
        }

        public int sedeReserva
        {
            get => idSede;
            set => idSede = value;
        }
        public int tipoVisitaReserva
        {
            get => idTipoVisita;
            set => idTipoVisita = value;
        }

        public static bool AltaNuevaReserva(Reserva nuevaReserva, List<int> listaExpos, List<int> listaGuias, DateTime fechaFinReserva)
        {
            // realiza el alta de la nueva reserva en la base de datos.
            // hace insercion en tabla Reserva, tabla ExposicionesXReserva, tabla Asignacion de empleados por reserva, y tabla cambio de estado de la nueva reserva.

            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlTransaction objTransaccion = null;
            SqlConnection cn = new SqlConnection(cadenaConexion);

            try
            {
                SqlCommand cmd = new SqlCommand();

                string consultaReserva = "INSERT INTO RESERVAS VALUES(@numero, @cantVisitantes, @fechaReserva, @fechaCreacion, @duracion, @usuario, @idEscuela, @idSede, @idTipoVisita)";

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@numero", nuevaReserva.numeroReserva);
                cmd.Parameters.AddWithValue("@cantVisitantes", nuevaReserva.cantVisitantesReserva);
                cmd.Parameters.AddWithValue("@fechaReserva", nuevaReserva.fechaDeReserva);
                cmd.Parameters.AddWithValue("@fechaCreacion", nuevaReserva.fechaDeCreacion);
                cmd.Parameters.AddWithValue("@duracion", nuevaReserva.duracionReserva);
                cmd.Parameters.AddWithValue("@usuario", nuevaReserva.usuarioReserva);
                cmd.Parameters.AddWithValue("@idEscuela", nuevaReserva.escuelaReserva);
                cmd.Parameters.AddWithValue("@idSede", nuevaReserva.sedeReserva);
                cmd.Parameters.AddWithValue("@idTipoVisita", nuevaReserva.tipoVisitaReserva);

                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consultaReserva;
                cn.Open();


                objTransaccion = cn.BeginTransaction("AltaDeReserva");
                cmd.Transaction = objTransaccion;

                cmd.Connection = cn;

                cmd.ExecuteNonQuery();

                foreach (var idExpo in listaExpos)
                {
                    string consultaExpoXReserva = "INSERT INTO EXPOXRESER values(@numeroReserva, @idExpo)";

                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@numeroReserva", nuevaReserva.numeroReserva);
                    cmd.Parameters.AddWithValue("@idExpo", idExpo);

                    cmd.CommandText = consultaExpoXReserva;

                    cmd.ExecuteNonQuery();
                }
                foreach (var numGuia in listaGuias)
                {
                    string consultaAsignacion = "INSERT INTO ASIGNACION values(@numeroReserva, @dniEmpleado, @fechaHoraInicio, @fechaHoraFin)";

                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@numeroReserva", nuevaReserva.numeroReserva);
                    cmd.Parameters.AddWithValue("@dniEmpleado", numGuia);
                    cmd.Parameters.AddWithValue("@fechaHoraInicio", nuevaReserva.fechaDeReserva);
                    cmd.Parameters.AddWithValue("@fechaHoraFin", fechaFinReserva);

                    cmd.CommandText = consultaAsignacion;

                    cmd.ExecuteNonQuery();
                }
                string consultaEstadoReserva = "INSERT into CAMBIOS_ESTADO VALUES(@numero, @idEstado, @fechaHoraInicio, @fechaHoraFin)";

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@numero", nuevaReserva.numeroReserva);
                cmd.Parameters.AddWithValue("@idEstado", 3);
                cmd.Parameters.AddWithValue("@fechaHoraInicio", nuevaReserva.fechaDeCreacion);
                cmd.Parameters.AddWithValue("@fechaHoraFin", DBNull.Value);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consultaEstadoReserva;
                cmd.ExecuteNonQuery();

                objTransaccion.Commit();
                return true;


            }
            catch (Exception)
            {
                objTransaccion.Rollback(); // si en alguna insercion hay un problema, hace un rollback y no registra nada.
                return false;
            }
            finally
            {
                cn.Close();
            }
        }


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
        public static DataTable ObtenerReservas(int idSede)
        {
            // retorna una tabla con todos los datos de las exposiciones de una sede 'idSede' de acuerdo al 'idTipoVisita' seleccionado.

            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            string consulta = "SELECT * FROM RESERVAS WHERE id_sede = @idSede";

            try
            {
                SqlCommand cmd = new SqlCommand();

                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@idSede", idSede);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;

                DataTable tabla = new DataTable();               // define una tabla vacia.
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(tabla);                                  // llena la tabla con los datos de la consulta.

                return tabla;
            }
            catch (Exception)   // si no se puede establecer la conexion con la BD captura el error en Exception.
            {
                throw;
            }
            finally
            {
                cn.Close();     // cierra la conexion con la BD para liberar recursos.
            }
        }
    }
}
