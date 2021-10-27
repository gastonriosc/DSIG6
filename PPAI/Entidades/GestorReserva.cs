using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class GestorReserva
    {
        public static int cantGuiasAElegir = 0;

        public static Reserva nuevaReserva = new Reserva();

        public static List<int> listaExpos = new List<int>();

        public static List<int> listaGuias = new List<int>();

        public static DateTime fechaFinReserva = new DateTime();


        public static void tomarSeleccionEscuela(int idEscuela)
        {
            nuevaReserva.escuelaReserva = idEscuela;
        }
        public static void tomarCantidadVisitantes(int cantVisit)
        {
            nuevaReserva.cantVisitantesReserva = cantVisit;
        }
        public static void tomarSeleccionSede(int sede)
        {
            nuevaReserva.sedeReserva = sede;
        }
        public static void tomarSeleccionTipoVisita(int idTipoVis)
        {
            nuevaReserva.tipoVisitaReserva = idTipoVis;
        }
        public static void tomarSeleccionExposiciones(List<int> expos)
        {
            listaExpos = expos;
        }
        public static void tomarFechaHoraReserva(DateTime fechaReserva)
        {
            nuevaReserva.fechaDeReserva = fechaReserva;
        }
        public static void tomarSeleccionGuias(List<int> guias)
        {
            listaGuias = guias;
        }
        public static void tomarFechaCreacionReserva(DateTime fechaCreacionReserva)
        {
            nuevaReserva.fechaDeCreacion = fechaCreacionReserva;
        }

        public static Empleado ObtenerDatosGuia(int dni)
        {
            Empleado guia = Empleado.ObtenerDatosEmpleadoGuia(dni);
            return guia;
        }






        public static DataTable buscarEscuelas()
        {
            DataTable escuelas = Escuela.mostrarNombreEscuelas();
            return escuelas;
        }

        public static DataTable buscarSedes()
        {
            DataTable sedes = Sede.mostrarNombreSedes();
            return sedes;
        }

        private static DateTime tomarFechaHoraActual()
        {
            DateTime fecha = DateTime.Now;
            return fecha;
        }

        public static DataTable buscarExpTempVig()
        {
            DataTable expos = Exposicion.buscarExposiciones(nuevaReserva.sedeReserva, nuevaReserva.tipoVisitaReserva, tomarFechaHoraActual());
            return expos;
        }

        public static DataTable ObtenerExposPorNumId(int idSede)
        {
            DataTable tabla = Exposicion.ObtenerExposXId(idSede);
            return tabla;
        }

        public static string ObtenerTipoPublicoDestino(int idPublico)
        {
            string publico = PublicoDestino.ObtenerPublicoDestino(idPublico);
            return publico;
        }



        public static List<int> GenerarListaIDsExposiciones()
        {
            // retorna una lista de id_exposiciones por sede seleccionada de acuerdo al tipo de visita elegido.

            DataTable tablaExposDeSede = Acceso_a_Datos.AD_Reserva.ObtenerExpos(nuevaReserva.sedeReserva, nuevaReserva.tipoVisitaReserva);
            // tablaExposPorSede tiene todos los atributos de las exposiciones de la sede seleccionada y el tipo de visita.

            List<int> listaExposDeSede = new List<int>();
            for (int i = 0; i < tablaExposDeSede.Rows.Count; i++)                           // itera por cada fila de la tabla tablaExposDeSede.
            {
                listaExposDeSede.Add(int.Parse(tablaExposDeSede.Rows[i][0].ToString()));    // agrega a la lista unicamente los IDs de las exposiciones.

            }
            return listaExposDeSede;                                                        // retorna la lista de los ids de las exposiciones.
        }

        public static string calcularDuracionEstimadaReserva(List<int> listaExposiciones)
        {
            // calcula la duracion estimada de la reserva y lo asigna en la interfaz.

            int duracionAproxDeExpo = 0;                                                                // este contador va a ir sumando las duraciones parciales de cada exposicion de la reserva.

            if (nuevaReserva.tipoVisitaReserva == 1)                                                    // si se eligió tipo de visita completa:
            {
                listaExposiciones = GenerarListaIDsExposiciones();                                      // busca todos los ids de las exposiciones vigentes.
            }
            for (int i = 0; i < listaExposiciones.Count; i++)
            {
                duracionAproxDeExpo += Acceso_a_Datos.AD_Reserva.BuscarDuracionExposiciones(listaExposiciones[i], nuevaReserva.tipoVisitaReserva);     // obtiene la duracion aprox de cada expo.
            }

            int duracion = duracionAproxDeExpo;                                                       
            nuevaReserva.duracionReserva = duracion;

            return duracion.ToString();
        }

        public static bool calcularSoprepasoCapMaxVisitantes(int duracion, int cantMaxSede)
        {
            // controla que la cantidad de visitantes de la nueva reserva no sobrepase la cantidad maxima permitida
            // de visitantes de la sede correspondiente en base de la cantidad de visitantes de otras reservas a la
            // misma fecha y hora de la nueva reserva.

            fechaFinReserva = nuevaReserva.fechaDeReserva.AddMinutes(duracion); // se obtiene la hora que termina la reserva sumando a la hora de inicio de la reserva la duracion estimada.

            List<DateTime> listaHoras = new List<DateTime>();            // listaHoras va a almacenar el dia y las distintas horas donde comienzan o terminan otras reservas, dentro del tiempo de la nueva reserva.

            listaHoras.Add(nuevaReserva.fechaDeReserva);                                // agregamos hora inicio y hora fin de nuestra reserva para establecer el intervalo a analizar.
            listaHoras.Add(fechaFinReserva);

            DataTable tablaReservasXsede = Reserva.ObtenerReservas(nuevaReserva.sedeReserva);
            for (int i = 0; i < tablaReservasXsede.Rows.Count; i++)     // itera por cada reserva de la tabla tablaReservasXsede.
            {
                DateTime fechaHoraInicio = Convert.ToDateTime(tablaReservasXsede.Rows[i][2].ToString());        // guarda la fecha y hora de inicio y de fin de cada reserva.
                DateTime fechaHoraFin = Convert.ToDateTime(tablaReservasXsede.Rows[i][2].ToString()).AddMinutes(int.Parse(tablaReservasXsede.Rows[i][4].ToString()));

                if (fechaHoraFin > nuevaReserva.fechaDeReserva && fechaHoraFin < fechaFinReserva)               // pregunta si la reserva actual termina en algun momento dentro del intervalo de tiempo de la nueva reserva.
                {
                    listaHoras.Add(fechaHoraFin);                                               // guarda en la lista de horas la fecha y hora de fin de la reserva actual.
                }
                else if (fechaHoraInicio > nuevaReserva.fechaDeReserva && fechaHoraInicio < fechaFinReserva)    // pregunta si la reserva actual empieza en algun momento dentro del intervalo de tiempo de la nueva reserva.
                {
                    listaHoras.Add(fechaHoraInicio);                                            // guarda en la lista de horas la fecha y hora de inicio de la reserva actual.
                }
            }

            listaHoras.Sort((x, y) => DateTime.Compare(x, y));  // ordenamos las horas cronologicamente, porque van a tener todos la misma fecha.

            for (int i = 0; i < listaHoras.Count - 1; i++)
            {
                int cantDeVisitantes = 0;                       // contador que va a ir sumando la cantidad de visitantes actual en cada momento en que hay un comienzo o fin de alguna reserva, dentro del intervalo de tiempo de la nueva reserva.

                DateTime horaEnIntervalo = listaHoras[i].AddMinutes(1);     // se toma un minuto despues del comienzo o fin de alguna reserva.

                for (int j = 0; j < tablaReservasXsede.Rows.Count; j++)     // itera por cada reserva de la tabla tablaReservasXsede.
                {
                    DateTime fechaHoraInicio = Convert.ToDateTime(tablaReservasXsede.Rows[j][2].ToString());
                    DateTime fechaHoraFin = Convert.ToDateTime(tablaReservasXsede.Rows[j][2].ToString()).AddMinutes(int.Parse(tablaReservasXsede.Rows[j][4].ToString()));

                    if (horaEnIntervalo > fechaHoraInicio && horaEnIntervalo < fechaHoraFin)        // pregunta si la hora dentro del intervalo se encuentra dentro de la reserva actual.
                    {
                        cantDeVisitantes += int.Parse(tablaReservasXsede.Rows[j][1].ToString());    // si la reserva actual ocurre en dicha hora, suma su cantidad de visitantes.

                        if (cantDeVisitantes >= cantMaxSede)                                        // valida si la cantidad de visitantes que es encuentra en la sede actualmente supera la cantidad maxima.
                        {
                            return true;
                        }

                    }
                }
            }

            return false;
        }


        public static int calcularCantGuias()
        {
            // calcula la cantidad de guias necesarios para la reserva, en base a la cantidad de visitantes ingresados
            // de la nueva reserva, y la cantidad maxima de visitantes por guia de la sede seleccionada.

            double cantMaxVisitantesXGuia = Sede.ObtenerCantMaxVisitGuia(nuevaReserva.sedeReserva);
            double cantGuiasAElegir = ((double)nuevaReserva.cantVisitantesReserva / cantMaxVisitantesXGuia);
            int cantGuias = Convert.ToInt32(Math.Ceiling(cantGuiasAElegir));                                    // redondea para arriba en caso de que no sea un numero exacto de guias necesarios.
            return cantGuias;
        }


        public static List<Empleado> buscarGuiasDisponiblesParaFechaReserva(string horaInicioReserva)
        {
            // busca todos los guias que son de la sede seleccionada y trabajan el mismo dia de la nueva reserva.
            List<Empleado> listaGuias = new List<Empleado>();               // define una lista vacia que contendra toos los datos de los guias que se enceuntren disponibles para ser asignados a esta reserva.


            string horaFinReserva = fechaFinReserva.ToString("H:mm:ss");        // guarda unicamente la hora de fin de la reserva en formato "HH:MM:SS".

            DataTable tablaGuiasCandidatos = HorarioEmpleado.ObtenerGuiasParaReserva(horaInicioReserva, horaFinReserva, nuevaReserva.sedeReserva, ConversorDia(nuevaReserva.fechaDeReserva));

            List<int> listaDniGuiasLibres = new List<int>();                    // define una lista vacia que va a contener los DNI de los guias que no tengan asignada una reserva en la misma hora que la nueva reserva.

            for (int i = 0; i < tablaGuiasCandidatos.Rows.Count; i++)           // itera por cada fila de la tabla de guias candidatos.
            {
                if (Asignacion.ObtenerGuiasDisponibles(int.Parse(tablaGuiasCandidatos.Rows[i][0].ToString()), nuevaReserva.fechaDeReserva, fechaFinReserva))
                {
                    listaDniGuiasLibres.Add(int.Parse(tablaGuiasCandidatos.Rows[i][0].ToString())); // si no encuentra ninguna asignacion para ese guia a la misma hora que la nueva reserva, agrega a la lista su dni.
                }
            }
            if (listaDniGuiasLibres.Count == 0) // si no hay guias en la lista de guias disponibles, se cancela la nueva reserva.
            {
                return listaGuias;
            }
            else
            {

                for (int i = 0; i < listaDniGuiasLibres.Count; i++)
                {
                    listaGuias.Add(Empleado.ObtenerDatosEmpleadoGuia(listaDniGuiasLibres[i]));
                }

                cantGuiasAElegir = calcularCantGuias();

                if (listaGuias.Count >= cantGuiasAElegir)                       // si hay al menos la misma cantidad de guias disponibles que la cantidad necesaria para la reserva, carga el combo de guias en la interfaz.
                {
                    return listaGuias;
                }
                else
                {
                    listaGuias.Clear();
                    return listaGuias;
                }
            }
        }


        public static int ConversorDia(DateTime fecha)
        {
            // recibe como parametro una fecha en formato "DD/MM/AAAA" y devuelve el dia correspondiente, asignado a un numero.

            DayOfWeek diaFecha = fecha.DayOfWeek;
            switch (diaFecha)
            {
                case DayOfWeek.Monday:          // 1 representa el lunes.
                    return 1;

                case DayOfWeek.Tuesday:         // 2 representa el martes.
                    return 2;

                case DayOfWeek.Wednesday:       // 3 representa el miercoles.
                    return 3;

                case DayOfWeek.Thursday:        // 4 representa el jueves.
                    return 4;

                case DayOfWeek.Friday:          // 5 representa el viernes.
                    return 5;

                case DayOfWeek.Saturday:        // 6 representa el sabado.
                    return 6;

                case DayOfWeek.Sunday:          // 7 representa el domingo.
                    return 7;

                default:
                    return 0;
            }
        }


        public static void buscarUltimoNumeroReserva()
        {
            // obtiene el numero de reserva correspondiente a la nueva reserva.

            int id = Reserva.ObtenerUltimoIdReserva();
            nuevaReserva.numeroReserva = id + 1;
        }

        public static void buscarEmpleadosDeSesion(string usuario)
        {
            
            nuevaReserva.usuarioReserva = usuario;
        }

        public static bool darDeAltaReserva()
        {
            bool resultado = Reserva.AltaNuevaReserva(nuevaReserva, listaExpos, listaGuias, fechaFinReserva);
            return resultado;
        }
        



    }
}
