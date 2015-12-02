package Screens
{
	import Enemies.EnemyShoot;
	
	import Engine.Locator;
	import Engine.SoundController;
	
	import General.Collectables;
	import General.Diamond;
	import General.EndPortal;
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
		private var _capaFin:MovieClip;
		
		private var _model2:MovieClip;
		private var _capa3_2:MovieClip;
				
		public var allLevelLayers:Vector.<Sprite> = new Vector.<Sprite>();		
		
		public var allPlatformsDown:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var allPlatformsUp:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		private var _level01Music:SoundController;


		public function Level()
		{
			this._level01Music = new SoundController( Locator.assetsManager.getSound( "sndLevel1" ) );
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
			var diamond_13:Diamond = new Diamond();
			var diamond_14:Diamond = new Diamond();
			var diamond_15:Diamond = new Diamond();
			var diamond_16:Diamond = new Diamond();
			var diamond_17:Diamond = new Diamond();
			var diamond_18:Diamond = new Diamond();
			var diamond_19:Diamond = new Diamond();
			
			var diamond_20:Diamond = new Diamond();
			var diamond_21:Diamond = new Diamond();
			var diamond_22:Diamond = new Diamond();
			var diamond_23:Diamond = new Diamond();
			var diamond_24:Diamond = new Diamond();
			var diamond_25:Diamond = new Diamond();
			var diamond_26:Diamond = new Diamond();
			var diamond_27:Diamond = new Diamond();
			var diamond_28:Diamond = new Diamond();
			var diamond_29:Diamond = new Diamond();
			var diamond_30:Diamond = new Diamond();
			var diamond_31:Diamond = new Diamond();
			
			
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
			diamond_12.spawn(4300,430);
			diamond_13.spawn(2150,650);
			diamond_14.spawn(2250,650);
			diamond_15.spawn(2350,650);
			diamond_16.spawn(2450,650);
			diamond_17.spawn(4370,550);
			diamond_18.spawn(4500,550);
			diamond_19.spawn(4600,550);
			
			diamond_20.spawn(4500,160);
			diamond_20.model.rotationX = 180;
			diamond_21.spawn(4600,160);
			diamond_21.model.rotationX = 180;
			diamond_22.spawn(4700,160);
			diamond_22.model.rotationX = 180;
			diamond_23.spawn(4800,160);
			diamond_23.model.rotationX = 180;
			diamond_24.spawn(4900,160);
			diamond_24.model.rotationX = 180;
			diamond_25.spawn(5000,160);
			diamond_25.model.rotationX = 180;
			diamond_26.spawn(6150,100);
			diamond_26.model.rotationX = 180;
			diamond_27.spawn(6430,200);
			diamond_27.model.rotationX = 180;
			diamond_28.spawn(900,160);
			diamond_28.model.rotationX = 180;
			diamond_29.spawn(1000,160);
			diamond_29.model.rotationX = 180;
			diamond_30.spawn(1100,160);
			diamond_30.model.rotationX = 180;
			diamond_31.spawn(1200,160);
			diamond_31.model.rotationX = 180;
			
			
			
			//Portales..
			var portal_1:Portal = new Portal();
			var portal_2:Portal = new Portal();
			var portal_3:Portal = new Portal();
			var portal_4:Portal = new Portal();
			var portal_5:Portal = new Portal();
			var portal_6:Portal = new Portal();
			var portal_7:Portal = new Portal();
			var portal_8:Portal = new Portal();
			var portal_9:Portal = new Portal();
			
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
			portal_9.spawn(7850, 550);
			
			
			//Enemies...
			var en1:EnemyShoot = new EnemyShoot();
			var en2:EnemyShoot = new EnemyShoot();
			var en3:EnemyShoot = new EnemyShoot();
			
			en1.spawn(3700, 680);			
			en2.spawn(1000, 600);
			en3.spawn(7510, 620);
			
			
			//End Portal
			var endPortal:EndPortal = new EndPortal();
			endPortal.spawn(8040,670);		

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
		
		public function initCapaFin():void
		{
			this._capaFin = Locator.assetsManager.getMovieClip("MC_CapaFin");
			Locator.game.containerLevel.addChild(this._capaFin);	
			this.allLevelLayers.push(this._capaFin);
			this._capaFin.x = this._model.width + this._model2.width - 150;
			this._capaFin.y = 0;
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