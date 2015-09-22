package General
{
	import Engine.Locator;
	
	import flash.display.MovieClip;

	public class Collectables
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
		
		
		public function destroy(elem:MovieClip):void
		{
			Locator.game.containerLevel.removeChild(elem);
			Locator.game.player.addDiamond();
		}
	}
}