package Engine.Input
{
	import Engine.Locator;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	public class InputManager
	{
		public var keys:Array = new Array();
		public var keysByName:Dictionary = new Dictionary();
		
			
		public function InputManager()
		{
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_UP, evKeyUp);
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown);
		}
	
		protected function evKeyDown(event:KeyboardEvent):void
		{
			var k:Key = keys[event.keyCode];
			if(k == null)
			{
				k = new Key();
				keys[event.keyCode] = k;
				
			}
			
			if(!k.isPressing)
				k.press();
		}
		
		protected function evKeyUp(event:KeyboardEvent):void
		{
			var k:Key = keys[event.keyCode];
			if(k != null)
			{
				k.release();
			}else
			{
				k = new Key();
				keys[event.keyCode] = k;
			}
		}
		
		public function setRelation(name:String, keyCode:int):void
		{
			var k:Key = keys[keyCode];
			
			if(k == null)
			{
				k = new Key();
				keys[keyCode] = k;
			}
			
			keysByName[name] = k;
		}
		
		//Obtengo la tecla que se esta presionando por nombre...
		public function getKeyPressingByName(name:String):Boolean
		{
			return keysByName[name] != null ? keysByName[name].isPressing : false;
		}
	
		
		
	}
}