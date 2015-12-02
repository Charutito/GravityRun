package Enemies
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class EnemyShoot extends BaseEnemy
	{
		private var _timeToShoot:Number;
		private var _currentTimeToShoot:Number;
		private var _isAttacking:Boolean;

		
		public function EnemyShoot()
		{
			super();
			this.model = Locator.assetsManager.getMovieClip("MC_Plant");
			
			this.model.scaleX = 0.5;
			this.model.scaleY = 0.5;
			
			this.model.name = "EnemyShoot";
			
			//Timers...
			this._timeToShoot = 3000;
			this._currentTimeToShoot = this._timeToShoot;
			changeAnimation("idle");
			model.addEventListener("unlock", evUnlock);
			_isAttacking = false;
			
		}
		
		protected function evUnlock(event:Event):void
		{
			_isAttacking = false;			
		}
		
		public function update():void
		{
			this._currentTimeToShoot -= 1000 / Locator.mainStage.frameRate;
			//trace("current time: " + this._currentTimeToShoot);
			if(this._currentTimeToShoot <= 0)
				shoot();
		}
		
		public function shoot():void
		{
			trace("Enemigo disparo...!!!" + _isAttacking);
			_isAttacking = true;
			changeAnimation("attack");
			var bullet:Bullet = new Bullet();
			Bullet._allBullets.push(bullet);
			bullet.add(this.model.x - 20, this.model.y - 40);
			
			this._currentTimeToShoot = this._timeToShoot;
		}
		
		public function changeAnimation(name:String):void
		{
			if(this.model.currentLabel != name)
				this.model.gotoAndPlay(name);
		}
		

	}
}