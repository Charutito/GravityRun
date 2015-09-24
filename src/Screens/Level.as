package Screens
{
	import Engine.Locator;
	
	import General.Collectables;
	import General.Diamond;
	import General.Portal;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Level
	{
		private var _model:MovieClip;
		private var _capa1:MovieClip;
		private var _diamond:Collectables;
		private var _deathtrap:Sprite;
		
		public var allPlatformsDown:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var allPlatformsUp:Vector.<MovieClip> = new Vector.<MovieClip>();

		public function Level()
		{
			this._deathtrap = null;
		}
		
		//GETTERS....
		public function get model():MovieClip
		{
			return this._model;	
		}
		
		public function get deathtrap():Sprite
		{
			return this._deathtrap;
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
			
			generateDeathtrap();
		}
		
		//ESTOS METODOS SON PARA EL TESTEO CON EL DEATHTRAP
		public function drawRectangle(x:Number, y:Number, width:Number, height:Number):Sprite
		{
			var tmp:Sprite = new Sprite();
			tmp.graphics.beginFill(0x000000, 1 );
			tmp.graphics.drawRect(x, y, width, height);
			tmp.graphics.endFill();
			return tmp;
		}
		
		public function generateDeathtrap():void
		{
			this._deathtrap = drawRectangle(Locator.mainStage.stageWidth/2, Locator.mainStage.stageHeight +200, Locator.mainStage.stageWidth, 200);
			Locator.mainStage.addChild(this._deathtrap);
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