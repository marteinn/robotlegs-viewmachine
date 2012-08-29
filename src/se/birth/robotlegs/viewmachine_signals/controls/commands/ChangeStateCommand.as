package se.birth.robotlegs.viewmachine_signals.controls.commands
{
	import org.robotlegs.mvcs.Command;
	
	import se.birth.robotlegs.viewmachine_signals.models.actors.BindingActor;
	import se.birth.robotlegs.viewmachine_signals.models.actors.StateActor;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.ChangeStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.DrawStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.RefreshStateSignal;
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.StateVO;
	
	public class ChangeStateCommand extends Command
	{
		[Inject]
		public var stateVO:StateVO;
		
		[Inject]
		public var stateActor:StateActor;
		
		[Inject]
		public var bindings:BindingActor;
		
		[Inject]
		public var drawState:DrawStateSignal;
		
		[Inject]
		public var refreshState:RefreshStateSignal;
		
		override public function execute() : void
		{
			var draw:Boolean = false;
			var refresh:Boolean = false;
			
			var currentStateVO:StateVO = stateActor.currentStateVO;
			
			// decide change type
			changeType:
			{
				if( currentStateVO == null ) // if we have no currentState, draw a new one
				{
					draw = true;
					break changeType;
				}
				
				if( currentStateVO.patternVO.bindingVO != stateVO.patternVO.bindingVO ) // does the view type match?
				{
					draw = true;
					break changeType;
				}
				
				if( bindings.doRefreshMatch( stateVO, currentStateVO ) ) // the state is the same, redraw?
				{
					refresh = true;
					break changeType;
				}
				
				draw = true;
			};
			
			// dispach state change type
			if( draw )
			{
				drawState.dispatch( stateVO );
			}
			
			if( refresh )
			{	
				refreshState.dispatch( stateVO );
			}
			
			// stateActor.currentStateVO = stateVO;
		}
	}
}