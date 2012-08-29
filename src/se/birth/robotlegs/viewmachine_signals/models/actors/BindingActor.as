package se.birth.robotlegs.viewmachine_signals.models.actors
{
	import org.robotlegs.mvcs.Actor;
	
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.BindingVO;
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.PatternVO;
	import se.birth.robotlegs.viewmachine_signals.models.actors.vo.StateVO;
	
	public class BindingActor extends Actor
	{
		protected var _bindings:Vector.<BindingVO> = new Vector.<BindingVO>();
		
		public function bindToView( view:Class, refreshPattern:String, patterns:Array ) : void
		{
			_bindings.push( new BindingVO( view, refreshPattern, patterns ) );
		}
		
		public function doRefreshMatch( stateVO:StateVO, currentStateVO:StateVO ) : Boolean
		{
			
			var bindingVO:BindingVO;
			var refreshPatternVO:PatternVO;
			
			var i:int;
			var j:int;
			var varPattern:String;
			
			bindingVO = stateVO.patternVO.bindingVO;
			refreshPatternVO = bindingVO.refreshPattern;
			
			varPattern = refreshPatternVO.varPattern;
			
			// run through all params
			for( i=0; i<refreshPatternVO.parameters.length; ++i )
			{
				// match them agains the state params
				for( j=0; j<stateVO.patternVO.parameters.length; j++ )
				{
					// do we have a match?
					if( refreshPatternVO.parameters[i] == stateVO.patternVO.parameters[j] )
					{
						// replace the param with the actual value
						varPattern = varPattern.replace( "<"+refreshPatternVO.parameters[i]+">", stateVO.valueOrder[j] );
					}
				}
			}
			
			return new RegExp( varPattern ).test( currentStateVO.state );
		}
		
		public function locatePattern( pattern:String ) : PatternVO
		{
			var j:int;
			var l:int;
			var binding:BindingVO;
			
			for each( binding in _bindings )
			{
				l = binding.patterns.length;
				
				for( j=0; j<l; ++j )
				{
					if( binding.patterns[j].pattern.test( pattern ) )
					{
						return binding.patterns[j];
					}
				}
			}
			
			return null;
		}
		
		public function matchPattern ( pattern:String ) : Boolean
		{
			return locatePattern( pattern ) != null;
		}
	}
}