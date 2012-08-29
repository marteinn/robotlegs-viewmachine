package se.birth.robotlegs.viewmachine_signals.models.actors
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	import se.birth.robotlegs.viewmachine_signals.controls.signals.ChangeStateSignal;
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.PatternVO;
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.StateVO;
	
	public class StateActor extends Actor
	{
		[Inject]
		public var changeState:ChangeStateSignal;
		
		[Inject]
		public var bindings:BindingActor;
		
		protected var _errorState:String = "";
		protected var _defaultState:String = "";
		protected var _currentStateVO:StateVO;
		// protected var _currentStateMediator:StateMeditor;
		
		public function register () : void
		{
			SWFAddress.addEventListener( SWFAddressEvent.CHANGE, swfaddress_changeHandler, false, 0, true  );
		}
		
		protected function swfaddress_changeHandler ( event:SWFAddressEvent ) : void
		{
			var state:String = "";
			var pattern:PatternVO;
			var stateVO:StateVO;
			
			// use default value
			if( event.value == "/" )
				state = _defaultState;
			else
				state = event.value;
			
			// can the pattern be found?
			if( bindings.matchPattern( state ) )
			{
				pattern = bindings.locatePattern( state );
				stateVO = new StateVO( state, pattern );
			}
			// show error state
			else if( _errorState != "" )
			{
				pattern = bindings.locatePattern( _errorState );
				stateVO = new StateVO( _errorState, pattern );
			}
			// report error
			else
			{
				throw( new Error( "Invalid state {"+state+"} and no Error state was found." ) );
				return;
			}
			
			// dispatch( new ChangeStateEvent( ChangeStateEvent.CHANGE_STATE, stateVO ) );
			changeState.dispatch( stateVO );
			
			currentStateVO = stateVO;	
		}
		
		
		
		public function setDefaultState( state:String ) : void
		{
			_defaultState = state;
		}
		
		public function setErrorState( state:String ) : void
		{
			_errorState = state;
		}
		
		public function setState( state:String ) : void
		{
			SWFAddress.setValue( state );
		}

		public function get currentStateVO():StateVO
		{
			return _currentStateVO;
		}

		public function set currentStateVO(value:StateVO):void
		{
			_currentStateVO = value;
		}
		
		/*
		public function get currentStateMediator():StateMeditor
		{
			return _currentStateMediator;
		}

		public function set currentStateMediator(value:StateMeditor):void
		{
			_currentStateMediator = value;
		}
		*/


	}
}
