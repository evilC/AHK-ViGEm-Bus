using Nefarius.ViGEm.Client.Targets;
using Nefarius.ViGEm.Client.Targets.DualShock4;

namespace ViGEmWrapper
{
    public class Ds4
    {
        private readonly DualShock4Controller _controller;
        private readonly DualShock4Report _report;
        private dynamic _feedbackCallback;
        private byte _lastLargeMotor;
        private byte _lastSmallMotor;
        private string _lastLightBarColor = "0x000000";

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

        public void SetDpadState(DualShock4DPadValues direction)
        {
            _report.SetDPad(direction);
        }

        public void SetSpecialButtonState(DualShock4SpecialButtons btn, bool state)
        {
            _report.SetSpecialButtonState(btn, state);
        }

        public void SendReport()
        {
            _controller.SendReport(_report);
        }

        public void SubscribeFeedback(dynamic callback)
        {
            _feedbackCallback = callback;
            _controller.FeedbackReceived += OnFeedbackReceived;
        }

        private void OnFeedbackReceived(object sender, DualShock4FeedbackReceivedEventArgs e)
        {
            if (_feedbackCallback == null) return;
            var lightBarColor = $"0x{e.LightbarColor.Red:X2}{e.LightbarColor.Green:X2}{e.LightbarColor.Blue:X2}";
            if (e.LargeMotor == _lastLargeMotor && e.SmallMotor == _lastSmallMotor &&
                lightBarColor == _lastLightBarColor) return;
            _lastLargeMotor = e.LargeMotor;
            _lastSmallMotor = e.SmallMotor;
            _lastLightBarColor = lightBarColor;
            _feedbackCallback(e.LargeMotor, e.SmallMotor, lightBarColor);
        }
    }
}