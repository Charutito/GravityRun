package Engine.Screen
{
	import Engine.Locator;
	
	import Screens.ScreenEvent;
	
	import flash.display.MovieClip;
	import flash.display.Screen;
	import flash.events.EventDispatcher;
	
	[Event(name="change", type="ScreenEvent")]
	[Event(name="exit", type="ScreenEvent")]
	[Event(name="enter", type="ScreenEvent")]
	
	public class CustomScreen extends EventDispatcher
	{
		public var model:MovieClip;
		
		public function CustomScreen(name:String)
		{
			this.model = Locator.assetsManager.getMovieClip(name);
		}
		
		public function enter():void
		{
			Locator.screenManager.screenContainer.addChild(this.model);
		}
		
		public function update():void
		{
			
		}
		
		public function exit():void
		{
			Locator.screenManager.screenContainer.removeChild(this.model);
		}
		
		public function changeScreen(name:String, params:Array=null):void
		{
			var e:ScreenEvent =  new ScreenEvent ( ScreenEvent.CHANGE );
			e.params = params;
			e.targetScreenName = name;
			
			dispatchEvent(e);
		}
	}
}