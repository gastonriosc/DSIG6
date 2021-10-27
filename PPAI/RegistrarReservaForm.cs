using PPAI_V1.Acceso_a_Datos;
using PPAI_V1.Entidades;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PPAI_V1
    
{
    public partial class PantallaAdmReserva : Form
    {
        List<int> listaExposiciones = new List<int>();
        List<int> listaGuias = new List<int>();
        int cantMaxSede = 0;
        int contadorExpos = 0;
        int contadorSedes = 0;
        int contadorEscuelas = 0;
        int contadorGuias2 = 0;
        int cantGuiasAElegir = 0;
        DateTime fechaReserva = new DateTime();
        DateTime fechaFinReserva = new DateTime();
        
        public PantallaAdmReserva()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            mostrarEscuelas();
            mostrarSedes();
            ObtenerUltIdReserva();     
        }


        // CARGA DE COMBOS.

        private void mostrarEscuelas()
        {
            // carga los datos de las escuelas para seleccionar.

            cmbEscuelas.DataSource = GestorReserva.buscarEscuelas();
            cmbEscuelas.DisplayMember = "nombre";
            cmbEscuelas.ValueMember = "id";
            cmbEscuelas.SelectedIndex = -1;
        }
        private void mostrarSedes()
        {
            // carga los datos de las sedes para seleccionar.

            cmbSedes.DataSource = GestorReserva.buscarSedes();
            cmbSedes.DisplayMember = "nombre";
            cmbSedes.ValueMember = "id";
            cmbSedes.SelectedIndex = -1;
        }
        private void mostrarExpos()
        {
            // carga los datos de las exposiciones correspondientes a partir de la sede seleccionada y el tipo de visita seleccionado.

            cmbExpos.DataSource = GestorReserva.buscarExpTempVig();
            cmbExpos.DisplayMember = "nombre";
            cmbExpos.ValueMember = "id";
            cmbExpos.SelectedIndex = -1;
        }

        private void mostrarGuiasDisponibles(List<Empleado> listaGuias)
        {
            // carga los datos de los guias disponibles para la reserva para seleccionar.

            cmbGuias.DisplayMember = "Text";
            cmbGuias.ValueMember = "Value";
            foreach (Empleado x in listaGuias)
            {
                cmbGuias.Items.Add(new comboItem(x.apellidoEmpleado.ToString(), x.dniEmpleado));
            }
            cmbGuias.SelectedIndex = -1;
        }

        private void ObtenerUltIdReserva()
        {
            // obtiene el numero de reserva correspondiente a la nueva reserva.

            int id = AD_Reserva.ObtenerUltimoIdReserva();
            txtNroReserva.Text = (id + 1).ToString();
        }

        internal class comboItem
        {
            public string Text { get; set; }
            public int Value { get; set; }
            public comboItem(string _Text, int _Value)
            {
                this.Text = _Text;
                this.Value = _Value;
            }
        }



        //EVENTOS DE COMBOS.
        private void cmbEscuelas_SelectedIndexChanged(object sender, EventArgs e) // tomarSeleccionEscuela()
        {
            // se activa cuando se selecciona la escuela.

            contadorEscuelas++;
            if (cmbEscuelas.SelectedIndex >= 0 && contadorEscuelas > 3)
            {
                   
                GestorReserva.tomarSeleccionEscuela((int)cmbEscuelas.SelectedValue); // se pasa el id de la escuela seleccionada como atributo de la nueva reserva.

                txtCantidadVisitantes.Enabled = true;                           // se habilita el ingreso de la cantidad de visitantes.
                txtCantidadVisitantes.Focus();                                  // ubica el raton en el casillero de la cantidad de visitantes.
            }
        }

        private void txtCantidadVisitantes_KeyDown(object sender, KeyEventArgs e)
        {
            // se activa cunado se oprime Enter luego de haber ingresado la cantidad de visitantes.

            if (e.KeyCode == Keys.Enter)
            {
                string validarCantidadVisit = txtCantidadVisitantes.Text.Trim();                // recorta la cantidad de visitantes ingresada eliminando posibles espacios en blanco.
                if (validarCantidadVisit.Length > 0)                                            // valida que la cantidad de visitantes ingresada se haya ingresado correctamente.
                {
                    cmbSedes.Enabled = true;                                                    // habilita la seleccion del a sede.
                    GestorReserva.tomarCantidadVisitantes(int.Parse(validarCantidadVisit));     // se pasa la cantidad de visitantes ingresada como atributo de la nueva reserva.
                    txtCantidadVisitantes.Enabled = false;
                    cmbSedes.Focus();                                                           // centra el raton en el casillero de la seleccion de la sede.
                }
            }
        }

        private void cmbSedes_SelectedIndexChanged(object sender, EventArgs e)
        {
            // se activa cuando se selecciona la sede.

            contadorSedes++;
            if (cmbSedes.SelectedIndex >= 0 && contadorSedes > 3)
            {
                            
                GestorReserva.tomarSeleccionSede((int)cmbSedes.SelectedValue);                  // se pasa la sede seleccionada como atributo de la nueva reserva.
                cantMaxSede = AD_Reserva.ObtenerCapacidadMaxSede((int)cmbSedes.SelectedValue);     // guarda la capacidad maxima de visitantes de la sede en cantMaxSede.
                rbPorExpo.Enabled = true;                                                       // habilita el boton de tipo visita Por Exposicion.
                rbCompleta.Enabled = true;                                                      // habilita el boton de tipo visita Completa.
            }
        }

        private void rbPorExpo_CheckedChanged(object sender, EventArgs e)
        {
            // se activa cuando se selecciona el tipo de visita Por Exposicion.

            groupBoxExpos.Visible = true;               // habilita la seccion de la seleccion de exposiciones para la visita.
            GestorReserva.tomarSeleccionTipoVisita(2);  // se pasa el tipo de visita seleccionado como atributo de la nueva reserva.
            mostrarExpos();
            cmbSedes.Enabled = false;
        }



        private void rbCompleta_CheckedChanged(object sender, EventArgs e)
        {
            // se activa cuando se selecciona el tipo de visita Completa.

            groupBoxExpos.Visible = false;              // no habilita la seccion de la seleccion de exposiciones para la visita.
            GestorReserva.tomarSeleccionTipoVisita(1);  // se pasa el tipo de visita seleccionado como atributo de la nueva reserva.
            txtFechaReserva.Enabled = true;             // habilita el ingreso de la fecha de reserva.
            txtFechaReserva.Focus();                    // ubica el raton en el casillero de la fecha de reserva.
            cmbSedes.Enabled = false;

        }




        private void cmbExpos_SelectedIndexChanged(object sender, EventArgs e) // mostrarDatosExposicionesTempVig()
        {
            contadorExpos++;
            if (cmbExpos.SelectedIndex >= 0 && contadorExpos > 3)
            {
                DataTable tabla = new DataTable();
                tabla = GestorReserva.ObtenerExposPorNumId((int)cmbExpos.SelectedValue);            // obtiene todos los datos de la exposicion seleccionada.
                string publico = GestorReserva.ObtenerTipoPublicoDestino((int)tabla.Rows[0][5]);
                txtPublicoDestino.Text = publico;                                                   // llena el campo Publico Destino de la interfaz.
                txtFechaInicioExpo.Text = tabla.Rows[0][2].ToString();                              // llena el campo Fecha de Inicio de la interfaz.
                txtFechaFinExpo.Text = tabla.Rows[0][3].ToString();                                 // llena el campo Fecha de Cierre de la interfaz.
            }
        }


        private void btnAgregarExpo_Click(object sender, EventArgs e) // tomarSeleccionExposiciones()
        {
            bool yaEsta = false;

            if (gridExpos.Rows.Count == 0)
            {
                listaExposiciones.Add((int)cmbExpos.SelectedValue);                                                          // agrega a listaExposiciones los IDs de las exposiciones que se van seleccionando.
                gridExpos.Rows.Add(cmbExpos.SelectedValue, cmbExpos.Text, txtFechaInicioExpo.Text, txtFechaFinExpo.Text);    // agrega los datos de la exposicion seleccionada a la grilla.
                txtFechaReserva.Enabled = true;                                                                              // habilita el ingreso de la fecha de reserva.
                                                                                                    // ubica el raton en el casillero de la fecha de reserva.
            }
            else
            {
                foreach (int expo in listaExposiciones)
                {
                    if ((int)cmbExpos.SelectedValue == expo)
                    {
                        yaEsta = true;
                    }
                }
                if (yaEsta == false)
                {
                    listaExposiciones.Add((int)cmbExpos.SelectedValue);                                                          
                    gridExpos.Rows.Add(cmbExpos.SelectedValue, cmbExpos.Text, txtFechaInicioExpo.Text, txtFechaFinExpo.Text);                                                                            
                }
            }
        }

        private void txtFechaReserva_Click(object sender, EventArgs e)
        {
            txtFechaReserva.Focus();
            cmbExpos.Enabled = false;
            btnAgregarExpo.Enabled = false;
            GestorReserva.tomarSeleccionExposiciones(listaExposiciones);
        }


        private void txtFechaReserva_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)                                            // si presiona enter luego de haber ingresado la fecha:
            {
                string validarFechaReserva = txtFechaReserva.Text.Trim();           // recorta la fecha ingresada eliminando posibles espacios en blanco.
                if (validarFechaReserva.Length == 10)                               // valida que la fecha ingresada se haya ingresado correctamente, a partir del largo de la fecha.
                {
                    txtHoraReserva.Enabled = true;                                  // habilita el ingreso de la hora de reserva.
                    txtHoraReserva.Focus();                                         // ubica el raton en el casillero de la hora de la reserva.
                }
            }
        }


        private void txtHoraReserva_KeyDown(object sender, KeyEventArgs e)
        {
            // cuando presione Enter despues de ingresar la hora de reserva, llama a la funcion validarFechaEnVigencia.
            // si la fecha de reserva ingresada se encuentra vigente, calcula la duracion estimada de la visita.

            if (e.KeyCode == Keys.Enter)                                            // cuando presione Enter despues de ingresar la hora de reserva.
            {
                //cmbExpos.Enabled = false;                                           // deshabilita el combo para seleccionar una nueva exposicion.
                //btnAgregarExpo.Enabled = false;                                     // deshabilita el boton para agregar exposicion.

                string validarHoraReserva = txtHoraReserva.Text.Trim();             // se valida que haya ingresado una hora.
                if (validarHoraReserva.Length == 5)                                 // si ingresó una hora valida, continua.
                {
                    if (validarFechaEnVigencia())
                    {
                        GestorReserva.tomarFechaHoraReserva(fechaReserva);         // si se encuentra en vigencia, se pasa la fecha de reserva como atributo de la nueva reserva.
                        txtDuracionEstimada.Text = GestorReserva.calcularDuracionEstimadaReserva(listaExposiciones);                                 // se procede a calcular la duracion estimada de la reserva.
                        if (GestorReserva.calcularSoprepasoCapMaxVisitantes(int.Parse(txtDuracionEstimada.Text), cantMaxSede))
                        {
                            cerrarVentana("Se ha sobrepasado la capacidad de la sede.");
                        }
                    }
                    else
                    {
                        // si la fecha de reserva ingresada no se encuentra vigente para las exposiciones de la reserva.
                        cerrarVentana("Se ha ingresado una fecha de reserva que no se encuentra entre las fechas de vigencia de una de las exposiciones.");
                    }
                }
                
                txtFechaReserva.Enabled = false;
                txtHoraReserva.Enabled = false;
                List<Empleado> guiasDisp = GestorReserva.buscarGuiasDisponiblesParaFechaReserva(txtHoraReserva.Text);                                                      // se va a buscar los guias disponibles.
                if (guiasDisp.Count > 0)
                {
                    mostrarGuiasDisponibles(guiasDisp);
                    cmbGuias.Enabled = true;                                            // se habilita el campo para seleccionar los guias.
                    cmbGuias.Focus();
                }
                else
                {
                    cerrarVentana("No hay una cantidad suficiente de guias libres para esta reserva");
                }
                
            }
        }


        private void cmbGuias_SelectedIndexChanged(object sender, EventArgs e)
        {
            // ocurre cuando se selecciona un guia del combo de guias disponibles.

            comboItem obj = (comboItem)cmbGuias.SelectedItem;
            Empleado Guia = GestorReserva.ObtenerDatosGuia(obj.Value);      // busca los datos del guia seleccionado.
            txtApellidoGuia.Text = Guia.apellidoEmpleado;                   // carga el apellido del guia en el campo 'Apellido de Guia' en la interfaz.
            txtDniGuia.Text = Guia.dniEmpleado.ToString();                  // carga el dni del guia en el campo 'DNI del guia' en la interfaz.
        }


        private void btnGuardarReserva_Click(object sender, EventArgs e)
        {
            // ocurre cuando se hace click en el boton de guardar reserva.
            GestorReserva.tomarSeleccionGuias(listaGuias);
            lblEstaSeguro.Visible = true;           // hace visible el campo 'Esta Seguro?'.
            btnSi.Visible = true;                   // hace visible el boton 'si'.
            btnNo.Visible = true;                   // hace visible el boton 'no'.
        }


        private void btnAgregarGuia_Click(object sender, EventArgs e)
        {
            bool yaEsta = false;                                                // yaEsta se usa para chequear que la exposicion que me quiere agregar no la haya agregado antes.
            comboItem obj = (comboItem)cmbGuias.SelectedItem;

            if (gridGuias.Rows.Count == 0)                                      // si la grilla se encuentra vacia.
            {
                contadorGuias2++;                                               // este contador se utiliza para chequear que no me elija mas guias de los permitidos segun la cantidad de visitantes de la reserva.
                listaGuias.Add(obj.Value);                                      // agrega a la lista listaGuias el dni del guia seleccionado.
                gridGuias.Rows.Add(txtDniGuia.Text, txtApellidoGuia.Text);      // agrega a la grilla el guia seleccionado.

                if (contadorGuias2 == GestorReserva.cantGuiasAElegir)           // si llega al maximo de guias permitidos, prohibe que me agregue otro.
                {
                    cmbGuias.Enabled = false;
                    btnAgregarGuia.Enabled = false;
                }
            }
            else
            {
                foreach (int dniGuia in listaGuias)                             // itera por cada guia agregado, preguntando si ya lo agrego antes.
                {
                    if (obj.Value == dniGuia)
                    {
                        yaEsta = true;
                    }
                }
                if (yaEsta == false)                                            // si no lo agrego antes, lo agrega a la grilla y a la lista.
                {
                    listaGuias.Add(obj.Value);
                    gridGuias.Rows.Add(txtDniGuia.Text, txtApellidoGuia.Text);
                }
            }            
        }

        private void btnSi_Click(object sender, EventArgs e) //tomarConfirmacionReservaVisita
        {
            //hace el alta de la nueva reserva, haciendo inserciones en la BD en las tablas correspondientes.

            GestorReserva.buscarUltimoNumeroReserva();
            GestorReserva.buscarEmpleadosDeSesion(lblNombreUsuario.Text);
            GestorReserva.tomarFechaCreacionReserva(DateTime.Now);


            bool resultado = GestorReserva.darDeAltaReserva();
            if (resultado)          // resultado guarda un booleano que me indica si la transaccion se realizo exitosamente. si no logra hacer correctamente la insercion hace un rollback y retorna falso.
            {
                MessageBox.Show("Se ha registrado su reserva correctamente."); 
                this.Close();
            }
            else
            {
                cerrarVentana("Error al dar alta de curso");
            }
        }


        private void btnNo_Click(object sender, EventArgs e)
        {
            cerrarVentana();
        }


        private void btnCancelarReserva_Click(object sender, EventArgs e)
        {
            cerrarVentana("Registro de nueva reserva cancelada.");
        }


        private bool validarFechaEnVigencia()
        {
            // obtiene la fecha de reserva ingresada y arma las listas de fechas de inicio y fin de vigencia de las exposiciones,
            // de acuerdo al tipo de visita que se selecciona. llama a la funcion validarFechas pasando como paramentros la fecha de
            // reserva y las listas. retorna un booleano.

            string fecha = txtFechaReserva.Text + " " + txtHoraReserva.Text;                            // se une la fecha y la hora de la reserva ingresadas.
            fechaReserva = DateTime.Parse(fecha);                                                       // se transforma la fecha de la reserva de string a datetime.

            List<DateTime> listaFechasFin = new List<DateTime>();                                       // se crea una lista que contenga las fechas de cierre de vigencia de las exposiciones de la reserva.
            List<DateTime> listaFechasInicio = new List<DateTime>();                                    // se crea una lista que contenga las fechas de inicio de vigencia de las exposiciones de la reserva.

            if (GestorReserva.nuevaReserva.tipoVisitaReserva == 2)                                                    // si se eligió tipo de visita por exposicion:
            {
                for (int i = 0; i < gridExpos.Rows.Count; i++)                                          // se recorren las exposiciones seleccionadas de la grilla.
                {
                    listaFechasFin.Add(DateTime.Parse(gridExpos.Rows[i].Cells[3].Value.ToString()));    // arma una lista con las fechasFin de las exposiciones seleccionadas.
                    listaFechasInicio.Add(DateTime.Parse(gridExpos.Rows[i].Cells[2].Value.ToString())); // arma una lista con las fechasInicio de las exposiciones seleccionadas.
                }
            }

            else                                                                                        // si se eligió tipo de visita completa:
            {
                DataTable exposCompletas = Acceso_a_Datos.AD_Reserva.ObtenerExpos((int)cmbSedes.SelectedValue, GestorReserva.nuevaReserva.tipoVisitaReserva);
                // exposCompletas es una tabla con todos los datos de las exposiciones tanto permanentes como temporales.
                for (int i = 0; i < exposCompletas.Rows.Count; i++)                                     // se recorren las exposiciones propias del tipo de visita completa.
                {
                    listaFechasFin.Add(DateTime.Parse(exposCompletas.Rows[i][3].ToString()));           // arma una lista con las fechasFin de las exposiciones seleccionadas.
                    listaFechasInicio.Add(DateTime.Parse(exposCompletas.Rows[i][2].ToString()));        // arma una lista con las fechasInicio de las exposiciones seleccionadas.
                }
            }

            bool validacion = validarFechas(fechaReserva, listaFechasFin, listaFechasInicio);           // guarda la validacion de la fecha de reserva ingresada en "validacion".
            return validacion;
        }


        private bool validarFechas(DateTime fechaReserva, List<DateTime> listaFechasFin, List<DateTime> listaFechasInicio)
        {
            // controla que la fecha de reserva ingresada sea mayor a la fecha de inicio de vigencia todas las exposiciones
            // y menor a la fecha de cierre de vigencia de todas las exposiciones. Retorna un booleano.

            listaFechasFin.Sort((x, y) => DateTime.Compare(x, y));                                      // se ordena la lista de fechas de cierre de vigencia cronologicamente.
            listaFechasInicio.Sort((x, y) => DateTime.Compare(x, y));                                   // se ordena la lista de fechas de inicio de vigencia cronologicamente.

            DateTime fechaFinMenor = listaFechasFin.First();                                            //se obtiene la exposicion con FechaFin mas próxima. Lo guarda en fechaFinMenor.
            DateTime fechaInicioMayor = listaFechasInicio.Last();                                       //se obtiene la exposicion con FechaInicio mas tarde en entrar en vigencia. Lo guarda en fechaInicioMayor.

            if (fechaReserva < fechaFinMenor && fechaReserva > fechaInicioMayor)                        // controla que la fecha de reserva ingresada ente dentro de las fechas de vigencia de las expo seleccionadas.
            {
                return true;                                                           // si se encuentra entre las fechas de vigencia de las expo seleccionadas, calcula la duracion estimada de la reserva.
            }
            else
            {
                return false;                                         // si fechaReserva es mayor a la fecha de cierre de vigencia o menor a la fecha de inicio de vigencia de alguna de las exposiciones, se cancela el CU.
            }
        }


        private void cerrarVentana(string mensaje="")
        {
            // avisa por pantalla el error ocurrido y cierra la ventada de la nueva reserva.

            MessageBox.Show(mensaje);
            this.Close();
        }

        
    }
}
