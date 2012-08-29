package se.birth.robotlegs.viewmachine_signals.controls.commands
{
	import org.robotlegs.mvcs.SignalCommand;
	
	import se.birth.robotlegs.viewmachine_signals.controls.signals.vo.BindViewVO;
	import se.birth.robotlegs.viewmachine_signals.models.actors.BindingActor;
	
	public class BindViewCommand extends SignalCommand
	{
		[Inject]
		public var bindings:BindingActor;
		
		[Inject]
		public var bindViewVO:BindViewVO;
				
		override public function execute() : void
		{
			bindings.bindToView( bindViewVO.view, bindViewVO.refreshPattern, bindViewVO.patterns );
		}
	}
}