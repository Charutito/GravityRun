package Screens
{
	import General.Collectables;
	import General.Diamond;
	
	import Engine.Locator;
	
	import General.Portal;
	
	import flash.display.MovieClip;

	public class Level
	{
		public var model:MovieClip;
		private var _capa1:MovieClip;
		
		public var allPlatformsDown:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var allPlatformsUp:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		private var _diamond:Collectables;
			
		
		public function Level()
		{
			
		}
		
		public function getPlatforms():void
		{
			for(var i:int=0; i<this.model.numChildren; i++)
			{
				if(this.model.getChildAt(i).name == "hit_platformDOWN")
				{
					allPlatformsDown.push( this.model.getChildAt(i) );
					//this.model.getChildAt(i).alpha = 0;
				}
				
				if(this.model.getChildAt(i).name == "hit_platformUP")
				{
					allPlatformsUp.push( this.model.getChildAt(i) );
					//this.model.getChildAt(i).alpha = 0;
				}
			}
			

		}
		
		public function locateElements():void
		{
			this._diamond = new Diamond();
			this._diamond.spawn(700,500);
			
			var portal_1:Portal = new Portal();
			var portal_2:Portal = new Portal();
			
			portal_1.spawn(1000,600);
			portal_2.spawn(600, 70);
		}
			
		
		public function init():void
		{
			model = Locator.assetsManager.getMovieClip("MC_Level01_model");
			Locator.game.containerLevel.addChild(model);	

		}
		
		public function initCapa1():void
		{
			_capa1 = Locator.assetsManager.getMovieClip("MC_Level01_capa1");
			Locator.game.containerLevel.addChild(_capa1);	
		}
	}
}