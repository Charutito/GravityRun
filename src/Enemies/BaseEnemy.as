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
			this.model.x = posX;
			this.model.y = posY;
			
		}
		
		public function destroy():void
		{
			Locator.game.containerLevel.removeChild(this.model);
		}
	}
}