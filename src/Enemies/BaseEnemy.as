package Enemies
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	
	public class BaseEnemy
	{
		private var _model:MovieClip;
		
		public function BaseEnemy()
		{
			
		}
		
		public function get model():void
		{
			return this._model;
		}
		
		public function spawn(posX:Number, posY:Number):void
		{
			Locator.game.containerLevel.addChild(this._model)
			this._model.x = posX;
			this._model.y = posY;
			
		}
		
		public function destroy():void
		{
			Locator.game.containerLevel.removeChild(this._model);
		}
	}
}