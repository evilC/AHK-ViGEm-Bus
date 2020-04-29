using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Nefarius.ViGEm.Client;

namespace ViGEmWrapper
{
    public static class Client
    {
        public static ViGEmClient ViGEmClient { get;} = new ViGEmClient();
    }
}
