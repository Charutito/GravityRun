package Engine.Assets
{
	import flash.events.Event;
	
	public class AssetsManagerEvents extends Event
	{
		public static const ASSETS_COMPLETE:String = "AssetsCompleteEvent";
		
		public function AssetsManagerEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}