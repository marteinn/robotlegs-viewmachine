package se.birth.robotlegs.viewmachine_signals.controls.signals.vo
{
	public class BindViewVO
	{
		public var view:Class;
		public var refreshPattern:String;
		public var patterns:Array;     
		
		public function BindViewVO(view:Class, refreshPattern:String, ...patterns)
		{	
			this.view = view;
			this.refreshPattern = refreshPattern;
			this.patterns = patterns;
		}   
	}
}