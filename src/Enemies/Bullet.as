package Enemies
{
	import Engine.Locator;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;
	import flash.net.dns.AAAARecord;
	
	public class Bullet implements IDestroyable
	{
		private var _model:MovieClip;
		private var _bulletSpeed:Number;
		public static var _allBullets:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		public function Bullet()
		{
			this._model = new MovieClip();
			this._model.name = "Bullet";
			this._bulletSpeed = 6;
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
		
		public function update():void
		{
			move();
		}
		
		public function move():void
		{
			this._model.x -= bulletSpeed;
			trace("bala moviendose...");
		}
		
		public function add(posX:Number, posY:Number):void
		{	
			this._model = Locator.assetsManager.getMovieClip("MC_Bullet");
			Locator.game.containerLevel.addChild(this._model);
			Locator.game.updateables.push(this);
			_allBullets.push(this._model);
			Locator.game.allDestroys.push(this);
			this._model.x = posX;
			this._model.y = posY;
			
		}
		
		public function destroy():void
		{
			trace("holi");
			Locator.game.containerLevel.removeChild(this._model);
			
			var index:int = Locator.game.updateables.indexOf(this)
			Locator.game.updateables.splice(index, 1);
			
			var indexBullet:int = _allBullets.indexOf(this._model);
			_allBullets.splice(indexBullet, 1);
			
			var indexDestroy:int = Locator.game.allDestroys.indexOf(this);
			Locator.game.allDestroys.splice(indexDestroy, 1);
			
			trace(index, indexBullet, indexDestroy);
		}
	}
}