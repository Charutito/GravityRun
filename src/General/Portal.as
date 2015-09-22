package General
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	
	public class Portal
	{
		private var _model:MovieClip;
		private var _scaleValue:Number = 0.3;
		
		
		public function Portal()
		{
			this._model = Locator.assetsManager.getMovieClip("MC_Portal");
			this._model.name = "Portal";
			this._model.scaleX = this._model.scaleY = this._scaleValue;
		}
		
		public function get model():MovieClip
		{
			return this._model;
		}
		public function spawn(posX:Number, posY:Number):void
		{
			Locator.game.containerLevel.addChild(this._model);
			this._model.x = posX;
			this._model.y = posY;
			
		}
	}
}