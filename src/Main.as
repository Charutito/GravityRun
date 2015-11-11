package
{
	import Engine.Assets.AssetsManagerEvents;
	import Engine.Locator;
	
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
			Locator.assetsManager.addEventListener(AssetsManagerEvents.ASSETS_COMPLETE, Locator.game.loadMenu);	
			
			//Locator.mainStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			//Locator.mainStage.scaleMode = StageScaleMode.EXACT_FIT;
			
		}
	}
}