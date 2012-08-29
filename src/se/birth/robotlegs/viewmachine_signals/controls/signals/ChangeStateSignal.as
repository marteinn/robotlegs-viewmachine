package se.birth.robotlegs.viewmachine_signals.controls.signals
{
	import org.osflash.signals.Signal;
	
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.StateVO;
	
	public class ChangeStateSignal extends Signal
	{
		public function ChangeStateSignal()
		{
			super(StateVO);
		}
	}
}