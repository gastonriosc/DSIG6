using PPAI_V1.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPAI_V1.Interface
{
    interface IEstrategiaDuración
    {
        int CalcularDuraciónEstimada(List<int> expo);

    }
}
