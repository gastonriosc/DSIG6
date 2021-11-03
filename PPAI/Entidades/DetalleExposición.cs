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
        public int buscarDuraciónObrasExpuestas(int idObra)
        {
            int duración = 0;
            Obra obra = new Obra();
            duración = obra.buscarDuraciónExtObra(idObra);
            return duración;
        }

        public int buscarDuraciónResumida(int idObra)
        {
            int duración = 0;
            Obra obra = new Obra();
            duración = obra.buscarDuraciónResumidaObra(idObra);
            return duración;
        }




    }
}
