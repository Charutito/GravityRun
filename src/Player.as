package
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
		
		public var game:Game;
		
		public function Player()
		{
		}
		
		public function spawn():void
		{
			model = Locator.assetsManager.getMovieClip("MC_hero");
			Locator.mainStage.addChild(model);	
			
			model.x = 70;
			model.y = 500;	
			
			model.mc_hitDown.alpha = 0;
			model.mc_hitCenter.alpha = 0;
		}
		
		public function update():void
		{
			model.x += _velocityX;
			model.y += _velocityY;
			_velocityY += _gravityY * _weight;
			
			for(var i:int=0; i<Game.allPlatforms.length; i++)
			{
				if(_velocityY > 0)
				{
					if(model.mc_hitDown.hitTestObject( Game.allPlatforms[i] ))
					{
						_velocityY = 0;
						model.y = Game.allPlatforms[i].y - model.mc_hitCenter.height /2;
						_isJumping = false;
						
						if(_velocityX == 0)
						{
							changeAnimation("idle");
						}
					}
				}
			}
			
			if(_velocityY > 0)
			{
				changeAnimation("fall");
			}
			
			//Igualo acá la velocidad en X a cero si quiero que el personaje se DEJE de mover al final de cada frame.
			_velocityX = 0;
		}
		
		
		public function jump():void
		{
			if(!_isJumping)
			{
				_velocityY = -(_forceJump * _weight);
				_isJumping = true;
				changeAnimation("jump");
			}
		}
		
		public function changeAnimation(name:String):void
		{
			if(model.currentLabel != name)
			{
				model.gotoAndPlay(name);
			}
		}
		
		
		public function move():void
		{
			_velocityX = _movementSpeed * 1;
			
			if(!_isJumping)
			{
				changeAnimation("run");
			}
		}
		
		
	}
}