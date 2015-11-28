package Screens
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class Pause
	{
		private var _model:MovieClip;
		
		public function Pause()
		{
			this._model = Locator.assetsManager.getMovieClip("MC_Pause");
		}
		
		public function init():void
		{
			Locator.game.containerLevel.addChild(this._model);
			this._model.x = Locator.mainStage.stageWidth/2;
			this._model.y = Locator.mainStage.stageHeight/2;
		}
		
		public function exit():void
		{
			Locator.game.containerLevel.removeChild(this._model);
		}
	}
}