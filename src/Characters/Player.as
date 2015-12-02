package Characters
{
	import Enemies.Bullet;
	
	import Engine.Locator;
	
	import General.Diamond;
	import General.EndPortal;
	import General.Portal;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Player implements IDestroyable
	{
		
		private var _model:MovieClip
		private var _speedX:Number;
		private var _speedY:Number;
		private var _jumpForce:Number;
		public var _canJump:Boolean;
		private var _gravity:int;
		private var _canChangeGravity:Boolean;
		
		private var _isInGame:Boolean = true;;
		
		public var totalDiamond:int;
		
		private var _changeDir:Number;	
		
		
		
		public function Player()
		{
			this._speedX = 6;
			this._speedY = 0;
			this._jumpForce = -14;
			this._canJump = true;
			this._gravity = 1;
			this._canChangeGravity = true;
			this.totalDiamond = 0;
		}
		
		public function get model():MovieClip
		{
			return this._model;
		}
		
		public function spawn():void
		{
			this._model = Locator.assetsManager.getMovieClip("MC_hero");
			Locator.game.containerLevel.addChild(this._model);	
			Locator.game.allDestroys.push(this);
			Locator.game.updateables.push(this);
			this._model.x = 70;
			this._model.y = 500;	
			
			this._model.mc_hitDown.alpha = 0;
			this._model.mc_hitCenter.alpha = 0;	
			_isInGame = true;
		}
		
		public function update():void
		{		
			this._model.y += this._speedY * this._gravity;
			this._speedY += 0.7;	
			
			checkCollision();
			checkPlatforms();
			checkPositionToDie();
			move(this._changeDir);
			trace("Stage Height = ", Locator.mainStage.stageHeight);
			trace("Model Y = ", this._model.y);
			trace("Es mayor?, ", this._model.y > Locator.mainStage.stageHeight);
			trace("Es menor?, ", this._model.y < 0);
		}
		
		public function checkPositionToDie():void
		{
			if(this._model.y > Locator.mainStage.stageHeight + this._model.height || this._model.y < 0 - this._model.height)
			{
				trace("Me fui del mapa!...");
				var ex:MovieClip = new MovieClip();
				ex = Locator.assetsManager.getMovieClip("MC_Explotion");
				if(this._model.y > Locator.mainStage.stageHeight + this._model.height && _isInGame)
				{
					ex.x = this._model.x;
					ex.y = Locator.mainStage.stageHeight;
					Locator.game.containerLevel.addChild(ex);
					this._model.alpha = 0;
					this._speedX = 0;
					_isInGame = false;
					ex.addEventListener("unlock", evUnlockDestroy);
				}else if(this._model.y < 0 - this._model.height && _isInGame)
				{
					ex.x = this._model.x;
					ex.y = 0;
					Locator.game.containerLevel.addChild(ex);
					this._model.alpha = 0;
					this._speedX = 0;
					_isInGame = false;
					ex.addEventListener("unlock", evUnlockDestroy);
				}
			}
		}
		
		protected function evUnlockDestroy(event:Event):void
		{
			destroy();				
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
					
					this._changeDir = 1;
				}
			}
			
			for(var x:int=0; x<Locator.game.level.allPlatformsUp.length; x++)
			{
				if(this._model.mc_hitDown.hitTestObject(Locator.game.level.allPlatformsUp[x]))
				{
					//Hardcodeo del amor ya que el movie toca constantemente la plataforma y no te deja saltar
					this._model.y = Locator.game.level.allPlatformsUp[x].y + 70; //Locator.game.level.allPlatforms[i].height;  
					
					this._speedY = 0;
					this._canJump = true;
					this._canChangeGravity = true;
					
					this._changeDir = -1;
				}
			}	
		}
		
		public function move(dir:int):void
		{
			this._model.x += this._speedX * dir;
			if(this._canJump)
				changeAnimation("run");
		}
		
		public function addDiamond():void
		{
			totalDiamond++;
		}
		
		public function destroy():void
		{
			//Locator.game.containerLevel.removeChild(this._model);
			this.totalDiamond = 0;
			Locator.game.addResult("MC_Lose");
		}
		
		public function checkCollision():void
		{
			
			for each(var element:IDestroyable in Locator.game.allDestroys)
			{
				if(element is Diamond && this._model.hitTestObject(element.getModel()) )
					element.destroy();					
				else if( element is Bullet && this._model.hitTestObject(element.getModel()) )
				{
					element.destroy();
					var ex:MovieClip = new MovieClip();
					ex = Locator.assetsManager.getMovieClip("MC_Explotion");
					ex.addEventListener("unlock", evUnlockDestroy);
					//destroy();
					ex.x = this._model.x;
					ex.y = this._model.y;
					Locator.game.containerLevel.addChild(ex);
					this._model.alpha = 0;
					this._speedX = 0;
					trace("Colision con bullet...");
				}
			}
			
			// Collision con los portales
			for (var i:int = 0; i < Locator.game.containerLevel.numChildren - 1; i++)
			{
				var temp:MovieClip = Locator.game.containerLevel.getChildAt(i) as MovieClip;
				if(temp != null){
					if(temp.name == ("Portal") && this._model.hitTestObject(temp.hitbox_p) && this._canChangeGravity)
					{
						this._gravity = this._gravity * -1;
						this._model.y = temp.y + (temp.height * this._gravity);
						this._model.x = temp.x;
						this._canChangeGravity = false;
						changeAnimation("gravity");
						temp.gotoAndPlay("change");
						this._model.scaleY *= -1;
						this._model.scaleX *= -1;
						this._changeDir = 0;
						this._canJump = false;
					}else if(temp.name == ("End_Portal") && this._model.hitTestObject(temp.hitbox) && _isInGame)
					{
						temp.gotoAndPlay("end");						
						this._speedX = 0;
						_isInGame = false;
						this._model.alpha = 0;
					}else if(temp.name == ("EnemyShoot") && this._model.hitTestObject(temp.hitbox) && _isInGame)
					{
						
						var ex:MovieClip = new MovieClip();
						ex = Locator.assetsManager.getMovieClip("MC_Explotion");
						ex.addEventListener("unlock", evUnlockDestroy);
						ex.x = this._model.x;
						ex.y = this._model.y;
						Locator.game.containerLevel.addChild(ex);
						this._model.alpha = 0;
						this._speedX = 0;
						_isInGame = false;
					}
				}
			}
		}
		
		public function getModel():MovieClip
		{
			return this._model;	
		}
	}
}