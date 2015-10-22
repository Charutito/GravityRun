package General
{
	import Engine.Locator;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;
	
	public class Portal implements IDestroyable
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
			Locator.game.allDestroys.push(this);
			this._model.x = posX;
			this._model.y = posY;
		}
		
		public function getModel():MovieClip
		{
			return this._model;
		}
		
		public function destroy():void
		{
			Locator.game.containerLevel.removeChild(this._model);
			var index:int = Locator.game.allDestroys.indexOf(this);
			Locator.game.allDestroys.splice(index, 1);
		}
	}
}