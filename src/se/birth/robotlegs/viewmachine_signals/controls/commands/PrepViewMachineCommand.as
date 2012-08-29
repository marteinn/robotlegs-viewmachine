package se.birth.robotlegs.viewmachine_signals.controls.commands
{
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.SignalCommand;
	
	import se.birth.robotlegs.viewmachine_signals.controls.signals.BindViewSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.ChangeStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.DefineDefaultStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.DefineErrorStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.DrawStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.RefreshStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.RemoveStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.RequestStateSignal;
	import se.birth.robotlegs.viewmachine_signals.controls.signals.RunViewMachineSignal;
	import se.birth.robotlegs.viewmachine_signals.models.actors.BindingActor;
	import se.birth.robotlegs.viewmachine_signals.models.actors.StateActor;
	import se.birth.robotlegs.viewmachine_signals.signals.vo.ViewMachinePropertiesVO;
	
	public class PrepViewMachineCommand extends SignalCommand
	{
		[Inject]
		public var prepViewMachineVO:ViewMachinePropertiesVO;
		
		override public function execute () :  void
		{
			var defineDefaultState:Signal;
			var defineErrorState:Signal;
			
			signalCommandMap.mapSignalClass( BindViewSignal, BindViewCommand, false );
			signalCommandMap.mapSignalClass( ChangeStateSignal, ChangeStateCommand );
			signalCommandMap.mapSignalClass( DrawStateSignal, DrawStateCommand );
			signalCommandMap.mapSignalClass( RequestStateSignal, RequestStateCommand );
			signalCommandMap.mapSignalClass( RunViewMachineSignal, RunViewMachineCommand );
			
			defineDefaultState = signalCommandMap.mapSignalClass( DefineDefaultStateSignal, DefineDefaultStateCommand ) as Signal;
			defineErrorState = signalCommandMap.mapSignalClass( DefineErrorStateSignal, DefineErrorStateCommand ) as Signal;
			
			injector.mapSingleton( RefreshStateSignal );
			injector.mapSingleton( RemoveStateSignal );
			
			injector.mapSingleton( BindingActor );
			injector.mapSingleton( StateActor );
			
			if( prepViewMachineVO.defaultState.length )
			{
				defineDefaultState.dispatch( prepViewMachineVO.defaultState );
			}

			if( prepViewMachineVO.errorState.length )
			{
				defineDefaultState.dispatch( prepViewMachineVO.errorState );
			}
			
		}
	}
}