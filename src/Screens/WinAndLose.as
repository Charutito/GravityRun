package Screens
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	public class WinAndLose
	{
		private var _model:MovieClip;
		
		public function WinAndLose()
		{
			
		}
		
		public function add(name:String):void
		{
			this._model = Locator.assetsManager.getMovieClip(name);
			Locator.mainStage.addChild(this._model);
			this._model.x = Locator.mainStage.stageWidth/2;
			this._model.y = Locator.mainStage.stageHeight/2;
			this._model.btn_restart.addEventListener(MouseEvent.CLICK, Locator.game.restartGame);
			this._model.btn_exit.addEventListener(MouseEvent.CLICK, Locator.game.endGame);
		}
		
		public function remove():void
		{
			Locator.mainStage.removeChild(this._model);
			this._model.btn_restart.removeEventListener(MouseEvent.CLICK, Locator.game.restartGame);
			this._model.btn_exit.removeEventListener(MouseEvent.CLICK, Locator.game.endGame);
			this._model = null;
		}
		
		
	}
}