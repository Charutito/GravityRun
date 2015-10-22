package Characters
{
	import Enemies.Bullet;
	
	import Engine.Locator;
	
	import General.Diamond;
	import General.Portal;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;
	
	public class Player implements IDestroyable
	{
		
		private var _model:MovieClip
		private var _speedX:Number;
		private var _speedY:Number;
		private var _jumpForce:Number;
		public var _canJump:Boolean;
		private var _gravity:int;
		private var _canChangeGravity:Boolean;
		
		public var totalDiamond:int;
		
		private var _changeDir:Number;	
		
		
		public function Player()
		{
			this._speedX = 5;
			this._speedY = 0;
			this._jumpForce = -13;
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
			//Locator.game.updateables.push(this);
			this._model.x = 70;
			this._model.y = 500;	
			
			this._model.mc_hitDown.alpha = 0;
			this._model.mc_hitCenter.alpha = 0;	
		}
		
		public function update():void
		{		
			this._model.y += this._speedY * this._gravity;
			this._speedY += 0.7;	
			
			checkCollision();
			checkPlatforms();
			move(this._changeDir);
			
			if( this._model.mc_hitCenter.hitTestObject(Locator.game.level.deathtrap) )
				die();
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
		
		public function die():void
		{
			Locator.game.containerLevel.removeChild(this._model);
			Locator.game.addResult("MC_Lose");
			
		}
		
		public function checkCollision():void
		{
			/*for (var i:int = Locator.game.containerLevel.numChildren - 1; i >= 0; i--)
			{
				var temp:MovieClip = Locator.game.containerLevel.getChildAt(i) as MovieClip;
				
				if(temp.name == ("Diamond") && this._model.hitTestObject(temp))
					temp.destroy();
				if(temp.name == ("Portal") && this._model.hitTestObject(temp) && this._canChangeGravity)
				{
						trace("Colisione con un portal...");
						this._gravity = this._gravity * -1;
						this._model.y = temp.y + (temp.height * this._gravity);
						this._model.x = temp.x;
						this._canChangeGravity = false;
						changeAnimation("gravity");
						this._model.scaleY *= -1;
						this._model.scaleX *= -1;
						this._changeDir = 0;
						this._canJump = false;
				}
				if(temp is Bullet && this._model.hitTestObject(temp) )
				{
					temp.destroy();
					die();
					trace("ME PEGARON MAMA");
				}
			}*/
			trace("chequeando colisiones...");
			for each(var element in Locator.game.allDestroys)
			{
				if(element is Diamond && this._model.hitTestObject(element.getModel()) )
					element.destroy();
				else if(element is Portal && this._model.hitTestObject(element.getModel()) )
				{
					trace("Colisione con un portal...");
					this._gravity = this._gravity * -1;
					this._model.y = element.getModel().y + (element.getModel().height * this._gravity);
					this._model.x = element.getModel().x;
					this._canChangeGravity = false;
					changeAnimation("gravity");
					this._model.scaleY *= -1;
					this._model.scaleX *= -1;
					this._changeDir = 0;
					this._canJump = false;
				}else if( element is Bullet && this._model.hitTestObject(element.getModel()) )
				{
					element.destroy();
					//die();
					trace("Colision con bullet...");
				}
			}
		}
		
		public function getModel():MovieClip
		{
			return this._model;	
		}
		
		public function destroy():void
		{
			//Patente Pendiente...
		}
	}
}