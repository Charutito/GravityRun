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
			var diamond:Diamond = new Diamond();
			diamond.spawn(700,500);
			
			var portal_1:Portal = new Portal();
			var portal_2:Portal = new Portal();
			var portal_3:Portal = new Portal();
			var portal_4:Portal = new Portal();
			
			portal_1.spawn(1000,620);
			portal_2.spawn(350, 90);
			portal_2.model.rotationX = 180;
			portal_3.spawn(2400, 700);
			portal_4.spawn(4300, 620);
			
			//Enemies...
			var en1:EnemyShoot = new EnemyShoot();
			en1.spawn(1300, 700);
			
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
		
		//=======================
		//Primera Parte del level
		//=======================
		public function initCapa3():void
		{
			this._capa3 = Locator.assetsManager.getMovieClip("MC_Level01_capa3");
			Locator.game.containerLevel.addChild(this._capa3);
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
		
		public function initCapaInicio():void
		{
			this._capaInicio = Locator.assetsManager.getMovieClip("MC_CapaInicio");
			Locator.game.containerLevel.addChild(this._capaInicio);	
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
			this._capa3_2.x = this._model.width;
			this._capa3_2.y = 0;
		}
		
		public function init2():void
		{
			this._model2 = Locator.assetsManager.getMovieClip("MC_Level01_2_model");
			Locator.game.containerLevel.addChild(this._model2);	
			this._model2.x = this._model.width;
			this._model2.y = 0;
		}
		
		public function getModel():MovieClip
		{
			return this._model;
		}
		
		public function destroy():void
		{
			var index:int = Locator.game.allDestroys.indexOf(this);
			Locator.game.allDestroys.splice(index, 1);
		}
	}
}