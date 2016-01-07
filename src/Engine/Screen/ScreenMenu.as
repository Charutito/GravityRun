package Engine.Screen
{
	import Engine.Locator;
	import Engine.SoundController;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class ScreenMenu extends CustomScreen
	{		
		
		private var _menuModel:MovieClip;
		private var _htpModel:MovieClip;
		private var _creditsModel:MovieClip;
		private var _menuMusic:SoundController;
		private var _buttonSound:SoundController;
		private var _isPlayingMusic:Boolean = false;
		
		public function ScreenMenu()
		{
			super("MC_Menu");
			this.model.x = 112;
			
			this._menuMusic = new SoundController( Locator.assetsManager.getSound("sndMenu") );
			this._buttonSound = new SoundController( Locator.assetsManager.getSound("button") );

			//Le doy play a la musica...
			if(!this._isPlayingMusic)
			{
				this._menuMusic.play(1, 0);
				this._isPlayingMusic = true;
			}
			
			//Agrego los listeners de los botones...
			this.model.btn_startGame.addEventListener(MouseEvent.CLICK, initGame);
			this.model.btn_HTP.addEventListener(MouseEvent.CLICK, addHowToPlay);
			this.model.btn_credits.addEventListener(MouseEvent.CLICK, addCredits);

		}
		
		public function initGame(e:MouseEvent):void
		{	
			this._menuMusic.stop();
			this._isPlayingMusic = false;
			Locator.game.startGame();
		}
		
		public function addHowToPlay(e:MouseEvent):void
		{
			//Sonido del boton
			this._buttonSound.play(1,0);
			Locator.screenManager.screenMngrLoadScr("How To Play");			
		}
		
		public function addCredits(e:MouseEvent):void
		{
			//Sonido del boton
			this._buttonSound.play(1,0);
			Locator.screenManager.screenMngrLoadScr("Credits");			
		}
	}
}