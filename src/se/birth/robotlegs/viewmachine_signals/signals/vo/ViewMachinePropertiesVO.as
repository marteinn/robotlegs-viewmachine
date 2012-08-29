package se.birth.robotlegs.viewmachine_signals.signals.vo
{
	public class ViewMachinePropertiesVO
	{
		public var defaultState:String = "";
		public var errorState:String = "";
		
		public function ViewMachinePropertiesVO( defaultState:String = "", errorState:String = "")
		{
			this.defaultState = defaultState;
			this.errorState = errorState;
		}
	}
}