package Characters
{
	import Engine.Locator;
	
	import flash.events.KeyboardEvent;

	public class UserController
	{
		private var _objectControlled:Player;
		
		public var KeyCodeUp:int;
		public var keyGravity:int;
		
		private var _goUp:Boolean;
		
		
		/** Configura los controles de movimiento.
		 * 
		 * @param p Player a controlar.
		 * @param KeyCodeUp Tecla para saltar. */
		public function UserController(p:Player, KeyCodeUp:int)
		{
			this._objectControlled = p;
			
			this.KeyCodeUp = KeyCodeUp;

			Locator.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown);
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_UP, evKeyUp);
		}
		
		public function Update():void
		{
			checkKeys();
		}
		
		public function checkKeys():void
		{
			if(this._goUp && this._objectControlled._canJump)
			{
				this._objectControlled._canJump = false;
				this._objectControlled.jump();
				trace("saltoo");
			}
		
		}
		
		protected function evKeyUp(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case KeyCodeUp:
					this._goUp = false;
					break;
			}
		}
		
		protected function evKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case KeyCodeUp:
					this._goUp = true;
					break;
			}
		}
	}
}