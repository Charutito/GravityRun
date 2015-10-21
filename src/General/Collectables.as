package General
{
	import Engine.Locator;
	import Interfaces.IDestroyable;
	import flash.display.MovieClip;

	public class Collectables implements IDestroyable
	{
		public var model:MovieClip;
		
		public function Collectables()
		{
			
		}
		
		public function spawn(posX:int, posY:int):void
		{
			Locator.game.containerLevel.addChild(this.model);
			this.model.x = posX;
			this.model.y = posY;			
		}
		
		public function destroy():void
		{
			Locator.game.containerLevel.removeChild(this.model);
			Locator.game.player.addDiamond();
			this.model = null;
		}
	}
}