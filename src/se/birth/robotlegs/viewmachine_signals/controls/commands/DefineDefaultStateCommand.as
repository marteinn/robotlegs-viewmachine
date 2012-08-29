package se.birth.robotlegs.viewmachine_signals.controls.commands
{
	import org.robotlegs.mvcs.Command;
	
	import se.birth.robotlegs.viewmachine_signals.models.actors.StateActor;
	
	public class DefineDefaultStateCommand extends Command
	{
		[Inject]
		public var actor:StateActor;
		
		[Inject]
		public var defaultState:String;
		
		override public function execute() : void
		{
			actor.setDefaultState( defaultState );
		}
	}
}