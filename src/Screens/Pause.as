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
		
		public function get model():MovieClip
		{
			return this._model;
		}

	}
}