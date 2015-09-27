package Enemies
{
	import Engine.Locator;
	
	import flash.display.MovieClip;

	public class EnemyShoot extends BaseEnemy
	{
		private var _timeToShoot:Number;
		private var _currentTimeToShoot:Number;

		
		public function EnemyShoot()
		{
			super();
			this.model = Locator.assetsManager.getMovieClip("MC_EnemyShoot");

			
			//Timers...
			this._timeToShoot = 1500;
			this._currentTimeToShoot = this._timeToShoot;
			
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
			trace("Enemigo disparo...!!!");
			var bullet:Bullet = new Bullet();
			bullet.add(this.model.x, this.model.y - 75);
			
			this._currentTimeToShoot = this._timeToShoot;
		}
		

	}
}