package se.birth.robotlegs.viewmachine_signals.controls.commands
{
	import flash.display.Sprite;
	
	import org.robotlegs.mvcs.Command;
	
	import se.birth.robotlegs.viewmachine_signals.controls.signals.RemoveStateSignal;
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.StateVO;
	
	public class DrawStateCommand extends Command
	{
		[Inject]
		public var stateVO:StateVO;
		
		[Inject]
		public var removeState:RemoveStateSignal;
		
		override public function execute() : void
		{
			//
		}
	}
}