package se.birth.robotlegs.viewmachine_signals.controls.commands
{
	import org.robotlegs.mvcs.SignalCommand;
	
	import se.birth.robotlegs.viewmachine_signals.models.actors.StateActor;
	
	public class DefineErrorStateCommand extends SignalCommand
	{
		[Inject]
		public var actor:StateActor;
		
		[Inject]
		public var errorState:String;
		
		override public function execute() : void
		{
			actor.setErrorState( errorState );
		}
	}
}