package Screens
{
	import Enemies.EnemyShoot;
	
	import Engine.Locator;
	
	import General.Collectables;
	import General.Diamond;
	import General.Portal;
	
	import Interfaces.IDestroyable;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Level implements IDestroyable
	{
		private var _model:MovieClip;
		private var _capa1:MovieClip;
		private var _capa3:MovieClip;
		private var _capaInicio:MovieClip;
		
		private var _model2:MovieClip;
		private var _capa3_2:MovieClip;
				
		public var allLevelLayers:Vector.<Sprite> = new Vector.<Sprite>();		
		
		public var allPlatformsDown:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var allPlatformsUp:Vector.<MovieClip> = new Vector.<MovieClip>();


		public function Level()
		{

		}
		
		//GETTERS....
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
			
			for(var a:int=0; a<this._model2.numChildren; a++)
			{
				if(this._model2.getChildAt(a).name == "hit_platformDOWN")
				{
					allPlatformsDown.push( this._model2.getChildAt(a) );
					this._model2.getChildAt(a).alpha = 0;
				}
				
				if(this._model2.getChildAt(a).name == "hit_platformUP")
				{
					allPlatformsUp.push( this._model2.getChildAt(a) );
					this._model2.getChildAt(a).alpha = 0;
				}
			}
		}
		
		public function locateElements():void
		{
			Locator.game.allDestroys.push(this);
			
			//Diamonds...
			var diamond_1:Diamond = new Diamond();
			var diamond_2:Diamond = new Diamond();
			var diamond_3:Diamond = new Diamond();
			var diamond_4:Diamond = new Diamond();
			var diamond_5:Diamond = new Diamond();
			var diamond_6:Diamond = new Diamond();
			var diamond_7:Diamond = new Diamond();
			var diamond_8:Diamond = new Diamond();
			var diamond_9:Diamond = new Diamond();
			var diamond_10:Diamond = new Diamond();
			var diamond_11:Diamond = new Diamond();
			var diamond_12:Diamond = new Diamond();
			
			
			
			diamond_1.spawn(550,400);
			diamond_2.spawn(1050,450);
			diamond_3.spawn(1100,550);
			diamond_4.spawn(3150,650);
			diamond_5.spawn(3250,650);
			diamond_6.spawn(3350,650);
			diamond_7.spawn(3450,650);
			diamond_8.spawn(3550,650);
			diamond_9.spawn(4000,450);
			diamond_10.spawn(4100,400);
			diamond_11.spawn(4200,400);
			diamond_12.spawn(4300,450);
			
			//Portales..
			var portal_1:Portal = new Portal();
			var portal_2:Portal = new Portal();
			var portal_3:Portal = new Portal();
			var portal_4:Portal = new Portal();
			var portal_5:Portal = new Portal();
			var portal_6:Portal = new Portal();
			var portal_7:Portal = new Portal();
			var portal_8:Portal = new Portal();
			
			portal_1.spawn(1330,720);
			portal_2.spawn(350, 90);
			portal_2.model.rotationX = 180;
			portal_3.spawn(1650, 600);
			portal_4.spawn(2350, 140);
			portal_4.model.rotationX = 180;
			portal_5.spawn(3050, 700);
			portal_6.spawn(5100, 700);
			portal_7.spawn(3300, 450);
			portal_8.spawn(6300, 550);
			
			
			//Enemies...
			var en1:EnemyShoot = new EnemyShoot();
			en1.spawn(3500, 650);
			

		}
		
		
		//=======================
		//Primera Parte del level
		//=======================
		public function initCapa3():void
		{
			this._capa3 = Locator.assetsManager.getMovieClip("MC_Level01_capa3");
			Locator.game.containerLevel.addChild(this._capa3);
			this.allLevelLayers.push(this._capa3);
		}
		
		public function init():void
		{
			this._model = Locator.assetsManager.getMovieClip("MC_Level01_model");
			Locator.game.containerLevel.addChild(this._model);
			this.allLevelLayers.push(this._model);
		}
		
		public function initCapa1():void
		{
			this._capa1 = Locator.assetsManager.getMovieClip("MC_Level01_capa1");
			Locator.game.containerLevel.addChild(this._capa1);
			this.allLevelLayers.push(this._capa1);
		}
		
		public function initCapaInicio():void
		{
			this._capaInicio = Locator.assetsManager.getMovieClip("MC_CapaInicio");
			Locator.game.containerLevel.addChild(this._capaInicio);	
			this.allLevelLayers.push(this._capaInicio);
			this._capaInicio.x = -800;
			this._capaInicio.y = 0;
		}
		
		// ======================
		//Segunda Parte del Level
		//=======================
		public function init2Capa3():void
		{
			this._capa3_2 = Locator.assetsManager.getMovieClip("MC_Level01_2_capa3");
			Locator.game.containerLevel.addChild(this._capa3_2);
			this.allLevelLayers.push(this._capa3_2);
			this._capa3_2.x = this._model.width;
			this._capa3_2.y = 0;
		}
		
		public function init2():void
		{
			this._model2 = Locator.assetsManager.getMovieClip("MC_Level01_2_model");
			Locator.game.containerLevel.addChild(this._model2);	
			this.allLevelLayers.push(this._model2);
			this._model2.x = this._model.width;
			this._model2.y = 0;
		}
		
		public function getModel():MovieClip
		{
			return this._model;
		}
		
		public function destroy():void
		{
			for each(var elem:Sprite in this.allLevelLayers)
			{
				Locator.game.containerLevel.removeChild(elem);
			}
			var index:int = Locator.game.allDestroys.indexOf(this);
			Locator.game.allDestroys.splice(index, 1);
		}
	}
}