using PPAI_V1.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Entidades
{
    class EstrategiaVisitaCompleta : IEstrategiaDuración
    {
        public int CalcularDuraciónEstimada(List<int> expo)
        {
            int duración = 0;
            foreach (int e in expo)
            {

                Exposicion ex = new Exposicion(e);
                duración += ex.CalcularDuraciónObrasExpuestas();

            }
            return duración;
        }
    }
}
