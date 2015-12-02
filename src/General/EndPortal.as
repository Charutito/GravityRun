package General
{
	import Engine.Locator;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class EndPortal implements IDestroyable
	{
		private var _model:MovieClip;
		
		
		public function EndPortal()
		{
			this._model = Locator.assetsManager.getMovieClip("MC_Portal_Final");
			this._model.name = "End_Portal";
			_model.addEventListener("unlock", evUnlock);
		}
		
		protected function evUnlock(event:Event):void
		{
			trace("GANASTE VIEJA"); 
		}
		
		
		public function getModel():MovieClip
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
		
		public function destroy():void
		{
			Locator.game.containerLevel.removeChild(this._model);
			var index:int = Locator.game.allDestroys.indexOf(this);
			Locator.game.allDestroys.splice(index, 1);
		}
		
	}
}