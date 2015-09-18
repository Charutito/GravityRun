package Screens
{
	import Engine.Locator;
	
	import flash.display.MovieClip;

	public class GUI
	{
		public var model:MovieClip;
		
		public function GUI()
		{

		}
		
		public function init(posX:int, posY:int):void
		{
			this.model = Locator.assetsManager.getMovieClip("MC_DiamondHUD");
			Locator.mainStage.addChild(this.model);
			
			this.model.x = posX;
			this.model.y = posY;	
		}
	}
}