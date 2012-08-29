package se.birth.robotlegs.viewmachine_signals.controls.signals
{
	import org.osflash.signals.Signal;
	
	import se.birth.robotlegs.viewmachine_signals.controls.signals.vo.BindViewVO;
	
	public class BindViewSignal extends Signal
	{
		public function BindViewSignal()
		{
			super(BindViewVO);
		}
	}
} 