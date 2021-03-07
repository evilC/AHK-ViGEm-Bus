using System;
using Nefarius.ViGEm.Client.Targets.DualShock4;
using Nefarius.ViGEm.Client.Targets.Xbox360;
using ViGEmWrapper;

namespace TestApp
{
    class Program
    {
        static void Main(string[] args)
        {

            //var xb = new Xb360();
            //xb.SetButtonState(Xbox360Buttons.A, true);
            //xb.SendReport();
            //xb.SetButtonState(Xbox360Buttons.A, false);
            //xb.SendReport();

            var ds4 = new Ds4();
            ds4.SetButtonState(DualShock4Buttons.Circle, true);
            ds4.SendReport();

            ds4.SetButtonState(DualShock4Buttons.Circle, false);
            ds4.SendReport();

            Console.ReadLine();
        }
    }
}
