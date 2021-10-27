using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class Empleado
    {
        private int dni;
        private string apellido;
        private string nombre;
        private int cargo;
        private string mail;
        private int idSede;

        public Empleado(int dniEmp, string apeEmp, string nomEmp, int cargoEmp, string mailEmp, int sedeEmp)
        {
            dni = dniEmp;
            apellido = apeEmp;
            nombre = nomEmp;
            cargo = cargoEmp;
            mail = mailEmp;
            idSede = sedeEmp;
        }
        public Empleado()
        {

        }
        public int dniEmpleado
        {
            get => dni;
            set => dni = value;
        }
        public string apellidoEmpleado
        {
            get => apellido;
            set => apellido = value;
        }
        public string nombreEmpleado
        {
            get => nombre;
            set => nombre = value;
        }
        public int cargoEmpleado
        {
            get => cargo;
            set => cargo = value;
        }
        public string mailEmpleado
        {
            get => mail;
            set => mail = value;
        }
        public int sedeEmpleado
        {
            get => idSede;
            set => idSede = value;
        }

        public static Empleado ObtenerDatosEmpleadoGuia(int dniGuia)
        {
            // busca todos los datos de un empleado a partir de un dni pasado como parametro.

            string cadenaConexion = System.Configuration.ConfigurationManager.AppSettings["CadenaBD"];
            SqlConnection cn = new SqlConnection(cadenaConexion); // establece conexion con la BD.

            List<Empleado> lista = new List<Empleado>();

            Empleado e;
            try
            {
                SqlDataReader leer;
                SqlCommand cmd = new SqlCommand();
                string consulta = "SELECT * FROM EMPLEADOS WHERE dni = @dni"; // consulta a realizar.
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@dni", dniGuia);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = consulta;
                cn.Open();
                cmd.Connection = cn;
                leer = cmd.ExecuteReader();

                leer.Read();

                e = new Empleado();
                e.dniEmpleado = leer.GetInt32(0);           // guarda los datos de cada columna de la consulta realizada en los atributos correspondientes del objeto empleado.
                e.apellidoEmpleado = leer.GetString(1);
                e.nombreEmpleado = leer.GetString(2);
                e.cargoEmpleado = leer.GetInt32(3);
                e.mailEmpleado = leer.GetString(4);
                e.sedeEmpleado = leer.GetInt32(5);

                return e;
            }
            catch (Exception ex)        // si no se puede establecer la conexion con la BD captura el error en Exception.
            {
                Console.Write(ex);
                return null;
            }
            finally
            {
                cn.Close();             // cierra la conexion con la BD para liberar recursos.
            }
        }
    }
}
