package se.birth.robotlegs.viewmachine_signals.models.actors.vo
{
	public class PatternVO
	{
		protected var _parameters:Array;
		protected var _varPattern:String;
		protected var _pattern:RegExp;
		protected var _bindingVO:BindingVO;
		
		public function PatternVO( parameters:Array, varPattern:String, pattern:RegExp, bindingVO:BindingVO = null )
		{
			_parameters = parameters;
			_varPattern = varPattern;
			_pattern = pattern;
			
			if( bindingVO != null )
				_bindingVO = bindingVO;
		}

		
		public function get parameters():Array
		{
			return _parameters;
		}
		
		public function set parameters(value:Array):void
		{
			_parameters = value;
		}
		
		public function get pattern():RegExp
		{
			return _pattern;
		}

		public function set pattern(value:RegExp):void
		{
			_pattern = value;
		}

		public function get bindingVO():BindingVO
		{
			return _bindingVO;
		}

		public function get varPattern():String
		{
			return _varPattern;
		}

		public function set varPattern(value:String):void
		{
			_varPattern = value;
		}


	}
}