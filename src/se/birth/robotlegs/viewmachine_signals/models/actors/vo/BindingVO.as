package se.birth.robotlegs.viewmachine_signals.models.actors.vo
{
	public class BindingVO
	{
		protected var _view:Class;
		protected var _refreshPattern:PatternVO;
		protected var _rawPattern:Array;
		protected var _patterns:Vector.<PatternVO>;
		
		
		protected var varsPattern:RegExp = /<([^>]*?)>/g; 
		protected var varsReplace:String = "[^/]*?";
		
		public function BindingVO( view:Class, refreshPattern:String, patterns:Array )
		{
			_view = view;
			_refreshPattern = formatPattern( refreshPattern );
			_rawPattern = patterns;
			_patterns = formatPatterns( patterns );
		}
		
		protected function formatPatterns ( patterns:Array ) : Vector.<PatternVO>
		{
			var i:int;
			
			var pattern:String;
			var patternVO:PatternVO;
			var formattedPatterns:Vector.<PatternVO> = new Vector.<PatternVO>();
			
			for( i=0; i<patterns.length; ++i )
			{
				patternVO = formatPattern( patterns[i] )
				formattedPatterns.push( patternVO );
			}
			
			return formattedPatterns;
		}
		
		protected function formatPattern( pattern:String ) : PatternVO
		{
			var foundParams:Array = [];
			var matches:Object;
			var paramName:String;
			var exactParamName:String;
			var formattedPattern:RegExp;
			
			// locate the parameters in the pattern
			while( (matches = varsPattern.exec(pattern)) != null )
			{
				paramName = matches[0];
				exactParamName = matches[1];
				
				foundParams.push( exactParamName );
			}
			
			// format the pattern so it accept values
			formattedPattern = new RegExp( pattern.replace( varsPattern, "([^/]*?)" ) );
			
			// package the pattern 
			return new PatternVO( foundParams, pattern, formattedPattern, this );
		}
		
		
		//

		public function get view():Class
		{
			return _view;
		}

		public function set view(value:Class):void
		{
			_view = value;
		}
		
		//

		public function get rawPattern():Array
		{
			return _rawPattern;
		}

		public function set rawPattern(value:Array):void
		{
			_rawPattern = value;
		}
		
		//

		public function get patterns() : Vector.<PatternVO>
		{
			return _patterns;
		}

		public function set patterns( value:Vector.<PatternVO> ):void
		{
			_patterns = value;
		}

		public function get refreshPattern():PatternVO
		{
			return _refreshPattern;
		}

		public function set refreshPattern(value:PatternVO):void
		{
			_refreshPattern = value;
		}


	}
}