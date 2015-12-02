package Characters
{
	import Engine.Locator;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class UserController
	{
		private var _objectControlled:Player;
		
		//public var KeyCodeUp:int;
		public var keyGravity:int;
		
		/** Configura los controles de movimiento.
		 * 
		 * @param p Player a controlar.
		 * @param KeyCodeUp Tecla para saltar. */
		public function UserController(p:Player, KeyCodeUp:int)
		{
			this._objectControlled = p;
			//this.KeyCodeUp = KeyCodeUp;
			Locator.inputManager.setRelation("Jump", KeyCodeUp);
			//agregar el callback al UM...
			Locator.updateManager.addCallback(update);
		}
		
		public function update(event:Event):void 
		{
			checkKeys();
		}
		
		public function checkKeys():void
		{
			if( Locator.inputManager.getKeyPressingByName("Jump") && this._objectControlled._canJump)
			{
				this._objectControlled._canJump = false;
				this._objectControlled.jump();
			}
		}
	}
}