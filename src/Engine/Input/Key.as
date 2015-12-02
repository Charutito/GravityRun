package Engine.Input
{
	import Engine.Locator;
	
	import flash.events.Event;

	public class Key
	{
		public var isPressing:Boolean;
		public var wasPressed:Boolean;
		public var wasReleased:Boolean;
		
		public function Key()
		{
			
		}
		
		public function press():void
		{
			this.isPressing = true;
			this.wasPressed = true;
			
			Locator.updateManager.addCallback(evCheckKeyPressed);
		}
		
		public function release():void
		{
			this.isPressing = false;
			this.wasReleased = true;
			
			Locator.updateManager.addCallback(evCheckKeyReleased);
		}
		
		public function evCheckKeyPressed(event:Event):void
		{
			this.wasPressed = false;
			
			Locator.updateManager.removeCallback(evCheckKeyPressed);
		}
		
		public function evCheckKeyReleased(event:Event):void
		{
			this.wasReleased = false;
			
			Locator.updateManager.removeCallback(evCheckKeyReleased);
		}

	}
}