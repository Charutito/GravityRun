package Characters
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	
	public class Player
	{
		
		private var _model:MovieClip
		private var _speedX:Number;
		private var _speedY:Number;
		private var _gravity:Number; //= 9.8 / Locator.mainStage.frameRate;
		//private var _weight:Number = 4;
		private var _forceJump:Number = 2.5;
		private var _canJump:Boolean;
		//private var _movementSpeed:Number = 5;
		//private var _gravityStatus:Boolean = true;
		private var _canChangeGravity:Boolean = true;
		public var totalDiamond:int;
		
		public function Player()
		{
			this._speedX = 5;
			this._speedY = 0;
			this._forceJump = -12;
			this._canJump = true;
			this._gravity = 1;
			this._canChangeGravity = true;
		}
		
		public function get model():MovieClip
		{
			return this._model;
		}
		
		public function spawn():void
		{
			this._model = Locator.assetsManager.getMovieClip("MC_hero");
			Locator.game.containerLevel.addChild(this._model);	
			
			this._model.x = 70;
			this._model.y = 500;	
			
			this._model.mc_hitDown.alpha = 0;
			this._model.mc_hitCenter.alpha = 0;
			
		}
		
		public function update():void
		{		
			this._model.y += this._speedY * this._gravity;
			this._speedY += 0.8;	
			
			checkCollision();
			checkPlatforms();
			
			trace(this._gravity);
			
		}
		
		public function jump():void
		{
			this._canJump = false;
			this._speedY = this._forceJump;
			trace("saltoo");
		}
		
		public function changeAnimation(name:String):void
		{
			if(this._model.currentLabel != name)
				this._model.gotoAndPlay(name);
		}
		
		public function checkPlatforms():void
		{
			for(var i:int=0; i<Locator.game.level.allPlatforms.length; i++)
			{
				if(this._model.mc_hitDown.hitTestObject(Locator.game.level.allPlatforms[i]))
				{
					this._model.y = Locator.game.level.allPlatforms[i].y - Locator.game.level.allPlatforms[i].height;
					this._speedY = 0;
					this._canJump = true;
					this._canChangeGravity = true;
				}
			}
			
		}
		
		public function move(dir:int):void
		{
			this._model.x += this._speedX * dir;
			if(this._canJump)
				changeAnimation("run");
		/*	
			if(!_isJumping)
				changeAnimation("run");
			
			if( (this._velocityY > 0 ) && this._canChangeGravity)
				changeAnimation("fall");*/
		}
		
		public function addDiamond():void
		{
			totalDiamond++
		}
		
		public function checkCollision():void
		{
			for (var i:int = Locator.game.containerLevel.numChildren - 1; i >= 0; i--)
			{
				var temp:MovieClip = Locator.game.containerLevel.getChildAt(i) as MovieClip;
				
				if(temp.name == ("Diamond") && this._model.hitTestObject(temp))
					Locator.game.collectables.destroy(temp);
				if(temp.name == ("Portal") && this._model.hitTestObject(temp) )
				{
					if( this._canChangeGravity )
					{
						trace("Colisione con un portal...");
						this._gravity = this._gravity * -1;
						//Acá está la magia: acomodar el model del PJ para que se levante un poco de la plataforma
						//Idealmente que se alinee con el portal
						//El X no es necesario a menos que quede muy choto
						this._model.y = temp.y - (temp.height/2);
						this._model.x = temp.x;
						this._canChangeGravity = false;
						trace(this._canChangeGravity);
					}

				}
			}
		}			
	}
}