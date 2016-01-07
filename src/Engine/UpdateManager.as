package Engine
{
	import flash.events.Event;

	public class UpdateManager
	{
		public var allCallbacks:Vector.<Function> =  new Vector.<Function>;
		
		public function UpdateManager()
		{
			Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
		}
		
		public function evUpdate(event:Event):void
		{
			for	(var i:int = 0; i < this.allCallbacks.length; i++)
			{
				this.allCallbacks[i](event);
			}
		}
		
		public function addCallback(callback:Function):void
		{
			this.allCallbacks.push(callback);	
		}
		
		public function removeCallback(callback:Function):void
		{
			var index:int = this.allCallbacks.indexOf(callback);
			if(index >= 0)
				this.allCallbacks.splice(index, 1);
		}
	}
}