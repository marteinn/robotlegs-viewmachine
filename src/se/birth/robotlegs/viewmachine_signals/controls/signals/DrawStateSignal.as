package se.birth.robotlegs.viewmachine_signals.controls.signals
{
	import org.osflash.signals.Signal;
	
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.StateVO;
	
	public class DrawStateSignal extends Signal
	{
		public function DrawStateSignal()
		{
			super(StateVO);
		}
	}
}