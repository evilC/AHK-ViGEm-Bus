using Nefarius.ViGEm.Client;
using Nefarius.ViGEm.Client.Targets;
using Nefarius.ViGEm.Client.Targets.Xbox360;

namespace ViGEmWrapper
{
    public class Xb360
    {
        private ViGEmClient _client;
        private readonly IVirtualGamepad _controller;
        private dynamic _feedbackCallback;

        public Xb360()
        {
            _client = new ViGEmClient();
            _controller = _client.CreateXbox360Controller();
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

        public void SubscribeFeedback(dynamic callback)
        {
            _feedbackCallback = callback;
            var controller = (IXbox360Controller) _controller;
            controller.FeedbackReceived += OnFeedbackReceived;
        }

        public void SubmitReport()
        {
            _controller.SubmitReport();
        }

        private void OnFeedbackReceived(object sender, Xbox360FeedbackReceivedEventArgs e)
        {
            if (_feedbackCallback == null) return;
            _feedbackCallback(e.LargeMotor, e.SmallMotor, e.LedNumber);
        }
    }
}