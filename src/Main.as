package
{
	import Engine.Assets.AssetsManagerEvents;
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="1024", height="768", frameRate="60")]
	public class Main extends Locator
	{
		public var player:MovieClip;
		
		public function Main()
		{
			Locator.assetsManager.loadLinks("links01.txt");
			
			
			Locator.assetsManager.addEventListener(AssetsManagerEvents.ASSETS_COMPLETE, startGame);
			
		}
		
		protected function startGame(event:Event):void
		{
			
			trace("Empieza el juego...");
			player = Locator.assetsManager.getMovieClip("MC_hero")
			Locator.mainStage.addChild(player);	
			
			player.x = Locator.mainStage.stageWidth/2;
			player.y = Locator.mainStage.stageHeight/2;
			
		}
	}
}