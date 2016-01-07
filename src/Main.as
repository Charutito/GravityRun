package
{
	import Engine.Assets.AssetsManagerEvents;
	import Engine.Locator;
	import Engine.Screen.ScreenCredits;
	import Engine.Screen.ScreenHowToPlay;
	import Engine.Screen.ScreenIntro;
	import Engine.Screen.ScreenMenu;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width="1024", height="768", frameRate="60")]
	public class Main extends Locator
	{
		
		
		public function Main()
		{
			Locator.assetsManager.loadLinks("links01.txt");
			Locator.assetsManager.addEventListener(AssetsManagerEvents.ASSETS_COMPLETE, evStartGame);	
			
			//Locator.mainStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			//Locator.mainStage.scaleMode = StageScaleMode.EXACT_FIT;
			
		}
		
		protected function evStartGame(event:Event):void
		{
			Locator.assetsManager.removeEventListener(AssetsManagerEvents.ASSETS_COMPLETE, evStartGame);	
			trace("INICIANDO JUEGO...");
			
			Locator.screenManager.registerScreen("Intro", ScreenIntro);
			Locator.screenManager.registerScreen("Main Menu", ScreenMenu);
			Locator.screenManager.registerScreen("How To Play", ScreenHowToPlay);
			Locator.screenManager.registerScreen("Credits", ScreenCredits);
			//Locator.screenManager.registerScreen("Level1", ScreenMenu);
			Locator.screenManager.screenMngrLoadScr("Intro");		
		}
		
	}
}