package Enemies
{
	import Engine.Locator;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.dns.AAAARecord;
	
	public class Bullet implements IDestroyable
	{
		private var _model:MovieClip;
		private var _bulletSpeed:Number;
		private var _timeToDestroy:Number;
		private var _currentTimeToDestroy:Number;
		public static var _allBullets:Vector.<Bullet> = new Vector.<Bullet>();
		
		public function Bullet()
		{
			this._model = new MovieClip();
			this._model.name = "Bullet";
			this._bulletSpeed = 6;
			this._timeToDestroy = 3000;
			this._currentTimeToDestroy = this._timeToDestroy;		

		}
		
		public function get model():MovieClip
		{
			return this._model;
		}
		
		public function getModel():MovieClip
		{
			return this._model;
		}
		
		public function get bulletSpeed():Number
		{
			return this._bulletSpeed;
		}
		
		public function update(event:Event):void
		{
			move();
			this._currentTimeToDestroy -= 1000 / Locator.mainStage.frameRate;
			if(this._currentTimeToDestroy <= 0)
			{
				destroy();
				trace("Bullet destroyed due to lifetime...");
			}
				
		}
		
		public function move():void
		{
			this._model.x -= bulletSpeed;
			//trace("bullet moving...");
		}
		
		public function add(posX:Number, posY:Number):void
		{	
			this._model = Locator.assetsManager.getMovieClip("MC_Bullet");
			Locator.game.containerLevel.addChild(this._model);
			//Locator.game.updateables.push(this);
			Locator.updateManager.addCallback(update);
			Locator.game.allDestroys.push(this);
			this._model.scaleX = 0.5;
			this._model.scaleY = 0.5;
			
			this._model.x = posX;
			this._model.y = posY;
			
		}
		
		public function destroy():void
		{
			trace("holi");
			Locator.game.containerLevel.removeChild(this._model);
			
			/*var index:int = Locator.game.updateables.indexOf(this)
			Locator.game.updateables.splice(index, 1);*/
			Locator.updateManager.removeCallback(update);
			
			var indexBullet:int = _allBullets.indexOf(this);
			_allBullets.splice(indexBullet, 1);
			
			var indexDestroy:int = Locator.game.allDestroys.indexOf(this);
			Locator.game.allDestroys.splice(indexDestroy, 1);
			
			//Seteo el valor del timer en 0 para que vuelva.
			this._currentTimeToDestroy = this._timeToDestroy;
			//trace(index, indexBullet, indexDestroy);
		}
	}
}