using Nefarius.ViGEm.Client;
using Nefarius.ViGEm.Client.Targets;
using Nefarius.ViGEm.Client.Targets.DualShock4;

namespace ViGEmWrapper
{
    public class Ds4
    {
        //private readonly DualShock4Controller _controller;
        //private readonly DualShock4Report _report;
        //private dynamic _feedbackCallback;
        private byte _lastLargeMotor;
        private byte _lastSmallMotor;
        private string _lastLightBarColor = "0x000000";
        private ViGEmClient _client;
        private readonly IVirtualGamepad _controller;
        private dynamic _feedbackCallback;

        public Ds4()
        {
            //_controller = new DualShock4Controller(Client.ViGEmClient);
            //_report = new DualShock4Report();
            //_controller.Connect();
            _client = new ViGEmClient();
            _controller = _client.CreateDualShock4Controller();
            _controller.AutoSubmitReport = false;
            _controller.Connect();

        }

        public string OkCheck()
        {
            return "OK";
        }

        public void SetButtonState(int btn, bool state)
        {
            _controller.SetButtonState(btn, state);
        }

        public void SetAxisState(int axis, short state)
        {
            _controller.SetAxisValue(axis, state);
        }

        public void SetSliderState(int slider, byte state)
        {
            _controller.SetSliderValue(slider, state);
        }

        // New IVirtualController based library does not support setting of DPad directions
        // This branch shelved until there is a fix
        /*
        public void SetDpadState(DualShock4DPadValues direction)
        {
            _report.SetDPad(direction);
        }
        */

        public void SubmitReport()
        {
            _controller.SubmitReport();
        }

        public void SubscribeFeedback(dynamic callback)
        {
            _feedbackCallback = callback;
            var controller = (IDualShock4Controller)_controller;
            controller.FeedbackReceived += OnFeedbackReceived;
        }

        private void OnFeedbackReceived(object sender, DualShock4FeedbackReceivedEventArgs e)
        {
            if (_feedbackCallback == null) return;
            var lightBarColor = $"0x{e.LightbarColor.Red:X2}{e.LightbarColor.Green:X2}{e.LightbarColor.Blue:X2}";
            //if (e.LargeMotor == _lastLargeMotor && e.SmallMotor == _lastSmallMotor &&
            //    lightBarColor == _lastLightBarColor) return;
            //_lastLargeMotor = e.LargeMotor;
            //_lastSmallMotor = e.SmallMotor;
            //_lastLightBarColor = lightBarColor;
            _feedbackCallback(e.LargeMotor, e.SmallMotor, lightBarColor);
        }
    }
}