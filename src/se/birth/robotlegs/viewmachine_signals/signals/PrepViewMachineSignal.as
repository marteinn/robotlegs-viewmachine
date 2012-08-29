package se.birth.robotlegs.viewmachine_signals.signals
{
	import org.osflash.signals.Signal;
	
	import se.birth.robotlegs.viewmachine_signals.signals.vo.ViewMachinePropertiesVO;
	
	public class PrepViewMachineSignal extends Signal
	{
		public function PrepViewMachineSignal()
		{
			super(ViewMachinePropertiesVO);
		}
	}
}