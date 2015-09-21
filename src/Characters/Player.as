package Characters
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	
	public class Player
	{
		
		public var model:MovieClip
		private var _velocityX:Number = 0;
		private var _velocityY:Number = 0;
		private var _gravityX:Number = 0;
		private var _gravityY:Number = 9.8 / Locator.mainStage.frameRate;
		private var _weight:Number = 4;
		private var _forceJump:Number = 2.5;
		private var _isJumping:Boolean;
		private var _movementSpeed:Number = 5;
		public var gravityStatus:Boolean = true;
		private var _canChangeGravity:Boolean = false;
		public var totalDiamond:int = 0;
		
		public function Player()
		{
			
		}
		
		public function spawn():void
		{
			this.model = Locator.assetsManager.getMovieClip("MC_hero");
			Locator.game.containerLevel.addChild(this.model);	
			
			this.model.x = 70;
			this.model.y = 500;	
			
			this.model.mc_hitDown.alpha = 0;
			this.model.mc_hitCenter.alpha = 0;
			
		}
		
		public function update():void
		{		
				if(this.gravityStatus)
					gravity(1);
				else
					gravity(-1);

			checkCollision();
		}
		
		
		public function jump():void
		{
			if(!this._isJumping)
			{
				this._velocityY = -(this._forceJump *this._weight);
				this._isJumping = true;
				changeAnimation("jump");
			}
		}
		
		public function changeAnimation(name:String):void
		{
			if(model.currentLabel != name)
				model.gotoAndPlay(name);
		}
		
		//Le agregue el parametro direccion para cambiar la gravedad, solo se aplica en Y...
		public function gravity(dir:Number):void
		{
			
			//DIVIDE & CONQUER!!!!
			//Muevo el pj en la velocidad multiplacada por su peso.
			this.model.x += this._velocityX;
			this.model.y += this._velocityY * dir;
			this._velocityY += this._gravityY * this._weight;
			trace(this._velocityY);
			
			//Separe el chequeo de plataformas a otro metodo.
			checkPlatforms();
			
			if(this._velocityY > 0)
				changeAnimation("fall");
						
			//Igualo acá la velocidad en X a cero si quiero que el personaje se DEJE de mover al final de cada frame.
			this._velocityX = 0;
		}
		
		// IMPORTANTE: LO QUE DIGO QUE ES PARA PENSAR ES LO SIGUIENTE:
		// ACA NO FUNCIONA BIEN LA GRAVEDAD POR QUE SIEMPRE ESTA TOCANDO LAS PLATFORMS
		// PERO EN LAMANERA QUE DEBERIAMOS HACERLO, NO VA A ESTAR TOCANDO PLATFORMS, SI NO QUE VA A ESTAR
		// TOCANDO EL "PORTAL", ASI QUE PUEDE QUE ANDE.
		// Creo yo! jajaja
		
		public function checkPlatforms():void
		{
			//Recorro todas las plataformas del nivel para chequear
			for(var i:int=0; i<Locator.game.level.allPlatforms.length; i++)
			{
				if(this._velocityY > 0)
				{
					if(this.model.mc_hitDown.hitTestObject( Locator.game.level.allPlatforms[i] ))
					{
						this._velocityY = 0;
						this.model.y = Locator.game.level.allPlatforms[i].y - this.model.mc_hitCenter.height / 2;
						this._isJumping = false;
						//Este boolean _canChangeGravity es una prueba, creo que no esta operativo.
						this._canChangeGravity = true;
						
						if(this._velocityX == 0)
							changeAnimation("idle");	
					}
				}
			}
		}
		
		public function move():void
		{
			this._velocityX = _movementSpeed * 1;
			
			if(!_isJumping)
				changeAnimation("run");
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
				
				if(temp.name == ("Diamond") && this.model.hitTestObject(temp))
					Locator.game.collectables.destroy(temp);
			}
		}			
	}
}