package se.birth.robotlegs.viewmachine_signals.controls.signals
{
	import org.osflash.signals.Signal;
	
	public class RequestStateSignal extends Signal
	{
		public function RequestStateSignal()
		{
			super(String);
		}
	}
}