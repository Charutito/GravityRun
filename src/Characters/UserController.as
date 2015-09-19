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
		private var _changeGravity:Boolean;
		
		
		/** Configura los controles de movimiento.
		 * 
		 * @param p Player a controlar.
		 * @param KeyCodeUp Tecla para saltar. */
		public function UserController(p:Player, KeyCodeUp:int, keyGravity:int)
		{
			_objectControlled = p;
			
			this.KeyCodeUp = KeyCodeUp;
			this.keyGravity = keyGravity;

			Locator.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown);
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_UP, evKeyUp);

		}
		
		public function Update():void
		{
			checkKeys();
		}
		
		public function checkKeys():void
		{
			if(_goUp)
			{
				_objectControlled.jump();
			}
		
		}
		
		protected function evKeyUp(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case KeyCodeUp:
					_goUp = false;
					break;
				case keyGravity:
					Locator.game.player.gravityStatus = false;
			}
		}
		
		protected function evKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case KeyCodeUp:
					_goUp = true;
					break;
				case keyGravity:
					Locator.game.player.gravityStatus = true;

			}
		}
	}
}