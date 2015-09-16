package Screens
{
	import Engine.Locator;
	
	import flash.display.MovieClip;

	public class Level01
	{
		public var model:MovieClip;
		private var _capa1:MovieClip;
			
		
		public function Level01()
		{
			
		}
		
		public function init():void
		{
			model = Locator.assetsManager.getMovieClip("MC_Level01_model");
			Locator.game.containerLevel.addChild(model);	

		}
		
		public function initCapa1():void
		{
			_capa1 = Locator.assetsManager.getMovieClip("MC_Level01_capa1");
			Locator.game.containerLevel.addChild(_capa1);	
		}

		
	}
}