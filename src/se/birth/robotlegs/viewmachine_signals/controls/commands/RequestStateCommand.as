package se.birth.robotlegs.viewmachine_signals.controls.commands
{
	import org.robotlegs.mvcs.Command;
	
	import se.birth.robotlegs.viewmachine_signals.models.actors.StateActor;
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.StateVO;
	
	public class RequestStateCommand extends Command
	{
		[Inject]
		public var stateActor:StateActor;
		
		[Inject]
		public var state:String;
		
		override public function execute() : void
		{
			stateActor.setState( state );
		}
	}
}