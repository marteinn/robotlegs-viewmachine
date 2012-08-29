package se.birth.robotlegs.viewmachine_signals.models.actors.vo
{
	public class StateVO
	{
		protected var _state:String;
		protected var _patternVO:PatternVO;
		protected var _valueOrder:Array;
		protected var _values:Object;
		
		
		public function StateVO ( state:String, patternVO:PatternVO )
		{
			_state = state;
			_patternVO = patternVO;
			_valueOrder = locateValues( state, patternVO );
			_values = constructValueObject ();
		}
		
		protected function locateValues ( state:String, patternVO:PatternVO ) : Array
		{	
			var values:Array = [];
			var value:String;
			var matches:Array;			
			
			matches = patternVO.pattern.exec(state);
			
			if( matches != null )
				if( matches.length>1 )
					values = matches.slice( 1, matches.length );
			
			return values;
		}
		
		protected function constructValueObject () : Object
		{
			
			var i:int;
			var l:int = patternVO.parameters.length; 
			var values:Object = {};
			
			for( i=0; i<l; ++i )
			{
				values[ patternVO.parameters[i] ] = _valueOrder[i] ;
			}
			
			return values;
		}
		
		//

		public function get valueOrder():Array
		{
			return _valueOrder;
		}

		public function set valueOrder(value:Array):void
		{
			_valueOrder = value;
		}

		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
		}

		public function get patternVO():PatternVO
		{
			return _patternVO;
		}

		public function set patternVO(value:PatternVO):void
		{
			_patternVO = value;
		}

		public function get values():Object
		{
			return _values;
		}

		public function set values(value:Object):void
		{
			_values = value;
		}


	}
}