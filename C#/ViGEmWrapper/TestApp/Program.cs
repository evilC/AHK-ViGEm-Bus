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
            //xb.SubscribeFeedback(new Action<byte, byte, byte>(OnXbFeedback));

            var ds4 = new Ds4();
            ds4.SetButtonState(DualShock4Buttons.Circle, true);
            ds4.SendReport();
            ds4.SubscribeFeedback(new Action<byte, byte, string>(OnDs4Feedback));

            ds4.SetButtonState(DualShock4Buttons.Circle, false);
            ds4.SendReport();
            Console.ReadLine();
        }

        private static void OnXbFeedback(byte largeMotor, byte smallMotor, byte ledNumber)
        {
            Console.WriteLine($"XB360 Feedback received - LargeMotor: {largeMotor}, SmallMotor: {smallMotor}. LedNumber: {ledNumber}");
        }

        private static void OnDs4Feedback(byte largeMotor, byte smallMotor, string lightbarColor)
        {
            Console.WriteLine($"DS4 Feedback received - LargeMotor: {largeMotor}, SmallMotor: {smallMotor}. LightbarColor: {lightbarColor}");
        }
    }
}
