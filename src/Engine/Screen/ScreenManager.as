package Engine.Screen
{
	import Engine.Locator;
	
	import Screens.ScreenEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class ScreenManager
	{
		public var currentScreen:CustomScreen;
		public var allScreens:Dictionary = new Dictionary();
		public var screenContainer:Sprite = new Sprite();
		public var targetScreen:String;
		
		
		public function ScreenManager()
		{
			Locator.updateManager.addCallback(evUpdate);
			Locator.mainStage.addChild(screenContainer);
		}
		
		public function evUpdate(event:Event):void
		{
			if(currentScreen != null)
				currentScreen.update();
		}		
		
		public function registerScreen(name:String, screenClass:Class):void
		{
			this.allScreens[name] =  screenClass;
		}
		
		public function loadScreen(name:String):void
		{
			currentScreen.addEventListener("load", EvLoadScreen);
			targetScreen = name;
		}
		
		protected function EvLoadScreen(event:Event):void
		{
			currentScreen.removeEventListener("load", EvLoadScreen);
			
			if(currentScreen != null)
			{
				currentScreen.exit();
				currentScreen = null;
			}
			
			var scrClass:Class = allScreens[targetScreen];
			currentScreen = new scrClass();
			currentScreen.addEventListener(ScreenEvent.CHANGE, evChange);
			currentScreen.enter();
		}
		
		protected function evChange(event:ScreenEvent):void
		{
			currentScreen.removeEventListener(ScreenEvent.CHANGE, evChange);
			loadScreen(event.targetScreenName);
		}
		
	}
}