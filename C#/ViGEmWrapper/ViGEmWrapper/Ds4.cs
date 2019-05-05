using Nefarius.ViGEm.Client.Targets;
using Nefarius.ViGEm.Client.Targets.DualShock4;

namespace ViGEmWrapper
{
    public class Ds4
    {
        private readonly DualShock4Controller _controller;
        private readonly DualShock4Report _report;

        public Ds4()
        {
            _controller = new DualShock4Controller(Client.ViGEmClient);
            _report = new DualShock4Report();
            _controller.Connect();
        }

        public string OkCheck()
        {
            return "OK";
        }

        public void SetButtonState(DualShock4Buttons btn, bool state)
        {
            _report.SetButtonState(btn, state);
        }

        public void SetAxisState(DualShock4Axes axis, byte state)
        {
            _report.SetAxis(axis, state);
        }

        public void SendReport()
        {
            _controller.SendReport(_report);
        }
    }
}