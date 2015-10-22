package Enemies
{
	import Engine.Locator;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;
	
	public class BaseEnemy implements IDestroyable
	{
		public var model:MovieClip;
		
		public function BaseEnemy()
		{
			
		}
		
		public function spawn(posX:Number, posY:Number):void
		{
			Locator.game.containerLevel.addChild(this.model);
			Locator.game.updateables.push(this);
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
			var index:int = Locator.game.allDestroys.indexOf(this);
			Locator.game.allDestroys.splice(index, 1);
		}
	}
}