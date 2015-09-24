package Screens
{
	import Engine.Locator;	
	import General.Collectables;
	import General.Diamond;
	import General.Portal;
	import flash.display.MovieClip;

	public class Level
	{
		private var _model:MovieClip;
		private var _capa1:MovieClip;
		private var _diamond:Collectables;
		
		public var allPlatformsDown:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var allPlatformsUp:Vector.<MovieClip> = new Vector.<MovieClip>();

		public function Level()
		{
			
		}
		
		public function get model():MovieClip
		{
			return this._model;	
		}
		
		public function getPlatforms():void
		{
			for(var i:int=0; i<this._model.numChildren; i++)
			{
				if(this._model.getChildAt(i).name == "hit_platformDOWN")
				{
					allPlatformsDown.push( this._model.getChildAt(i) );
					this.model.getChildAt(i).alpha = 0;
				}
				
				if(this._model.getChildAt(i).name == "hit_platformUP")
				{
					allPlatformsUp.push( this._model.getChildAt(i) );
					this.model.getChildAt(i).alpha = 0;
				}
			}
		}
		
		public function locateElements():void
		{
			this._diamond = new Diamond();
			this._diamond.spawn(700,500);
			
			var portal_1:Portal = new Portal();
			var portal_2:Portal = new Portal();
			var portal_3:Portal = new Portal();
			
			portal_1.spawn(1000,700);
			portal_2.spawn(430, 70);
			portal_3.spawn(2400, 700);
		}
			
		public function init():void
		{
			this._model = Locator.assetsManager.getMovieClip("MC_Level01_model");
			Locator.game.containerLevel.addChild(this._model);	
		}
		
		public function initCapa1():void
		{
			this._capa1 = Locator.assetsManager.getMovieClip("MC_Level01_capa1");
			Locator.game.containerLevel.addChild(this._capa1);	
		}
	}
}