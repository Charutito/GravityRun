package Screens
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.MouseCursorData;

	public class Menu
	{
		private var _menuModel:MovieClip;
		private var _htpModel:MovieClip;
		private var _creditsModel:MovieClip;
		
		public function Menu()
		{
			
			

		}
		
		public function get menuModel():MovieClip
		{
			return this._menuModel;
		}
		
		public function addMenu():void
		{	
			trace("Agregando menu...");
			//Agrego y posiciono el movie.
			this._menuModel = Locator.assetsManager.getMovieClip("MC_Menu");
			Locator.mainStage.addChild(this._menuModel);
			this._menuModel.x = Locator.mainStage.stageWidth/2;
			this._menuModel.y = Locator.mainStage.stageHeight/2;
			//Agrego los listeners de los botones...
			this._menuModel.btn_startGame.addEventListener(MouseEvent.CLICK, Locator.game.startGame);
			this._menuModel.btn_HTP.addEventListener(MouseEvent.CLICK, addHowToPlay);
			this._menuModel.btn_credits.addEventListener(MouseEvent.CLICK, addCredits);
		}
		
		public function removeMenu():void
		{
			//Saco los listeners y remuevo el menu...
			this._menuModel.btn_startGame.removeEventListener(MouseEvent.CLICK, Locator.game.startGame);
			this._menuModel.btn_HTP.removeEventListener(MouseEvent.CLICK, addHowToPlay);
			this._menuModel.btn_credits.removeEventListener(MouseEvent.CLICK, addCredits);
			Locator.mainStage.removeChild(this._menuModel);
			trace("sacando el menu");
		}
		
		public function addHowToPlay(e:MouseEvent):void
		{
			//Saco el menu.
			removeMenu();
			//Cargo el que necesito con su listener...
			this._htpModel = Locator.assetsManager.getMovieClip("MC_howToPlay");
			this._htpModel.x = Locator.mainStage.stageWidth/2;
			this._htpModel.y = Locator.mainStage.stageHeight/2;
			Locator.mainStage.addChild(this._htpModel);
			this._htpModel.btn_back.addEventListener(MouseEvent.CLICK, removeHTP);
	
		}
		
		public function removeHTP(e:MouseEvent):void
		{
			this._htpModel.btn_back.removeEventListener(MouseEvent.CLICK, removeHTP);
			Locator.mainStage.removeChild(this._htpModel);
			addMenu();
		}
		
		public function addCredits(e:MouseEvent):void
		{
			trace("poniendo los credits");
			//Saco el menu...
			removeMenu();
			//Cargo los credits...
			this._creditsModel = Locator.assetsManager.getMovieClip("MC_credits");
			this._creditsModel.x = Locator.mainStage.stageWidth/2;
			this._creditsModel.y = Locator.mainStage.stageHeight/2;
			Locator.mainStage.addChild(this._creditsModel);
			this._creditsModel.btn_back.addEventListener(MouseEvent.CLICK, removeCredits);
		}
		
		public function removeCredits(e:MouseEvent):void
		{
			trace("sacando los credits");
			this._creditsModel.btn_back.removeEventListener(MouseEvent.CLICK, removeCredits);
			Locator.mainStage.removeChild(this._creditsModel);
			addMenu();
		}

	}
}