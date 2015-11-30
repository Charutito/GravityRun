package General
{
	import Engine.Locator;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;

	public class Deathtrap implements IDestroyable
	{
		private var _model:MovieClip = new MovieClip();
		
		public function Deathtrap() 
		{
			this._model = Locator.assetsManager.getMovieClip("MC_deathtrap");
		}
		
		public function getModel():MovieClip
		{
			return this._model;
		}
		
		public function init():void
		{
			Locator.game.containerLevel.addChild(this._model);
			Locator.game.updateables.push(this);
			Locator.game.allDestroys.push(this);
			trace(" Deathtrap Generada...");
		}
		
		public function setPosition():void
		{
			this._model.x = Locator.mainStage.stageWidth/2;
			this._model.y = Locator.mainStage.stageHeight/2;
		}
		
		public function update():void
		{
			setPosition();
		}
		
		public function destroy():void
		{
			
		}
	}
}