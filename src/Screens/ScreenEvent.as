package Screens
{
	import flash.events.Event;
	
	public class ScreenEvent extends Event
	{
		public static const ENTER:String = "enter";
		public static const EXIT:String = "exit";
		public static const CHANGE:String = "change";
		
		public var targetScreenName:String;
		public var params:Array = new Array();
		
		public function ScreenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return this;
		}
	}
}