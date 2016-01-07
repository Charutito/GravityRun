package Engine.Screen
{
	import Engine.Locator;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class ScreenIntro extends CustomScreen
	{
		public function ScreenIntro()
		{
			super("MC_Intro");
		}
		
		override public function enter():void
		{
			super.enter();
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_UP, quitIntro);
		}
		
		public function quitIntro(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.ENTER)
			{
				Locator.mainStage.removeEventListener(KeyboardEvent.KEY_UP, quitIntro);
				Locator.screenManager.screenMngrLoadScr("Main Menu");
				//changeScreen("Main Menu");	
			}
		}	
	}
}