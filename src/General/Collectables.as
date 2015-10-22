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
			Locator.game.allDestroys.push(this);
			this.model.x = posX;
			this.model.y = posY;			
		}
		
		public function getModel():MovieClip
		{
			return this.model;	
		}
		
		public function destroy():void
		{
			Locator.game.containerLevel.removeChild(this.model);
			Locator.game.player.addDiamond();
			var index:int = Locator.game.allDestroys.indexOf(this);
			Locator.game.allDestroys.splice(index, 1);
		}
	}
}