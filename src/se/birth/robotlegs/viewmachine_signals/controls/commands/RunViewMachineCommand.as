package se.birth.robotlegs.viewmachine_signals.controls.commands
{
	import org.robotlegs.mvcs.Command;
	
	import se.birth.robotlegs.viewmachine_signals.models.actors.StateActor;
	
	public class RunViewMachineCommand extends Command
	{
		[Inject]
		public var stateActor:StateActor;
		
		override public function execute() : void
		{
			stateActor.register();
		}
	}
}