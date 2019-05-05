using Nefarius.ViGEm.Client.Targets;
using Nefarius.ViGEm.Client.Targets.Xbox360;

namespace ViGEmWrapper
{
    public class Xb360
    {
        private readonly Xbox360Controller _controller;
        private readonly Xbox360Report _report;

        public Xb360()
        {
            _controller = new Xbox360Controller(Client.ViGEmClient);
            _report = new Xbox360Report();
            _controller.Connect();
        }

        public string OkCheck()
        {
            return "OK";
        }

        public void SetButtonState(Xbox360Buttons btn, bool state)
        {
            _report.SetButtonState(btn, state);
        }

        public void SetAxisState(ushort axis, short state)
        {
            _report.SetAxis((Xbox360Axes)axis, state);
        }

        public void SendReport()
        {
            _controller.SendReport(_report);
        }
    }
}