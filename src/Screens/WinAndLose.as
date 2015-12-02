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
		
		public function get model():MovieClip
		{
			return this._model;
		}
		
		public function add(name:String):void
		{
			var fon:MovieClip = new MovieClip();
			fon = Locator.assetsManager.getMovieClip("MC_FondoDes");
			Locator.game.containerGUI.addChild(fon);
			fon.alpha = 0.5;
			fon.x = Locator.mainStage.stageWidth/2;
			fon.y = Locator.mainStage.stageHeight/2;
			
			this._model = Locator.assetsManager.getMovieClip(name);
			Locator.game.containerGUI.addChild(this._model);
			this._model.x = -350;
			this._model.y = 90;
			if(this._model.btn_restart != null)
			{
				this._model.btn_restart.addEventListener(MouseEvent.CLICK, Locator.game.restartGame);
				this._model.btn_restart.addEventListener(MouseEvent.CLICK, initGame);
			}
			
			if(this._model.btn_exit != null)
			{
				this._model.btn_exit.addEventListener(MouseEvent.CLICK, Locator.game.endGame);
			}
			
			if(this._model.btn_menu != null)
			{
				this._model.btn_menu.addEventListener(MouseEvent.CLICK, Locator.game.menuWin);
				this._model.btn_menu.addEventListener(MouseEvent.CLICK, Locator.game.restartGame);
			}
			
		}


		
		public function initGame(e:MouseEvent):void
		{
			Locator.game.startGame();
		}
		
		public function remove():void
		{
			if(this._model != null){
				Locator.game.containerGUI.removeChild(this._model);
				this._model.btn_restart.removeEventListener(MouseEvent.CLICK, Locator.game.restartGame);
				this._model.btn_exit.removeEventListener(MouseEvent.CLICK, Locator.game.endGame);
			}
		}
	}
}