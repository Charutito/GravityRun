package Characters
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	
	public class Player
	{
		
		private var _model:MovieClip
		private var _speedX:Number;
		private var _speedY:Number;
		private var _jumpForce:Number;
		public var _canJump:Boolean;
		private var _gravity:int;
		private var _canChangeGravity:Boolean;
		
		public var totalDiamond:int;
		
		private var changeDir:Number;	
		
		
		public function Player()
		{
			this._speedX = 5;
			this._speedY = 0;
			this._jumpForce = -12;
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
			
			//this._model.mc_hitDown.alpha = 0;
			this._model.mc_hitCenter.alpha = 0;
			
		}
		
		public function update():void
		{		
			this._model.y += this._speedY * this._gravity;
			this._speedY += 0.7;	
			
			checkCollision();
			checkPlatforms();
			move(changeDir);
			
		}
		
		public function jump():void
		{
			this._canJump = false;
			this._speedY = this._jumpForce;
			changeAnimation("jump");
		}
		
		public function changeAnimation(name:String):void
		{
			if(this._model.currentLabel != name)
				this._model.gotoAndPlay(name);
		}
		
		public function checkPlatforms():void
		{
			for(var i:int=0; i<Locator.game.level.allPlatformsDown.length; i++)
			{
				if(this._model.mc_hitDown.hitTestObject(Locator.game.level.allPlatformsDown[i]))
				{
					//Hardcodeo del amor ya que el movie toca constantemente la plataforma y no te deja saltar
					this._model.y = Locator.game.level.allPlatformsDown[i].y - 65; //Locator.game.level.allPlatforms[i].height;  
					
					this._speedY = 0;
					this._canJump = true;
					this._canChangeGravity = true;
					
					changeDir = 1;
				}
			}	
			
			for(var x:int=0; x<Locator.game.level.allPlatformsUp.length; x++)
			{
				if(this._model.mc_hitDown.hitTestObject(Locator.game.level.allPlatformsUp[x]))
				{
					//Hardcodeo del amor ya que el movie toca constantemente la plataforma y no te deja saltar
					this._model.y = Locator.game.level.allPlatformsUp[x].y + 80; //Locator.game.level.allPlatforms[i].height;  
					
					this._speedY = 0;
					this._canJump = true;
					this._canChangeGravity = true;
					
					changeDir = -1;
				}
			}	
		}
		
		public function move(dir:int):void
		{
			this._model.x += this._speedX * dir;
			if(this._canJump)
				changeAnimation("run");
			
		/*	if( (this._velocityY > 0 ) && this._canChangeGravity)
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
				if(temp.name == ("Portal") && this._model.hitTestObject(temp) && this._canChangeGravity)
				{
						trace("Colisione con un portal...");
						this._gravity = this._gravity * -1;
						this._model.y = temp.y + (temp.height * this._gravity);
						this._model.x = temp.x;
						this._canChangeGravity = false;
						changeAnimation("gravity");
						//this._model.rotation = 180;
				}
			}
		}			
	}
}