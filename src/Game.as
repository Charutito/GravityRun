
package
{
	import Characters.Player;
	import Characters.UserController;
	
	import Enemies.Bullet;
	
	import Engine.Camera.Camera;
	import Engine.Locator;
	
	import General.Collectables;
	
	import Interfaces.IDestroyable;
	
	import Screens.GUI;
	import Screens.Level;
	import Screens.Pause;
	import Screens.WinAndLose;
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.net.dns.AAAARecord;
	import flash.ui.Keyboard;
	
	public class Game
	{
		private var _char:Player;
		private var _controller:UserController;
		private var _camera:Camera;
		
		private var _level:Level;
		private var _res:WinAndLose;
		private var _collectables:Collectables;
		
		//public var updateables:Array;
		//Containers...
		public var containerLevel:Sprite;
		public var containerGUI:Sprite;
		//Gui...
		public var gui:GUI = new GUI();
		
		public var pauseGui:Pause;
		private var _isPaused:Boolean = false;
		
		public var intro:MovieClip; 
		
		//Probando probando 1...2...3...
		public var allDestroys:Vector.<IDestroyable> = new Vector.<IDestroyable>();
		
		public function Game()
		{
			this._camera = new Camera();
			this.containerLevel = new Sprite();
			this._level = new Level();
			this._char = new Player();
			this._collectables = new Collectables();
			this.containerGUI = new Sprite();
			//this.updateables = new Array();
			this._res  = new WinAndLose();
			
		}
		
		//Getters...
		public function get level():Level
		{
			return this._level;
		}
		
		public function get player():Player
		{
			return this._char;
		}
		
		public function get collectables():Collectables
		{
			return this._collectables;
		}

		
/*		public function loadMenu(e:Event):void
		{
			this._menu.addMenu();
		}*/
		
		public function startGame():void
		{
			//remuevo el menu
			//if(Locator.mainStage.contains(this._menu.menuModel))

/*			if(this._menu != null)
			{
				this._menu.removeMenu();
			}*/
			
			
			Locator.mainStage.addChild(this.containerLevel);
			this._camera.addToView(this.containerLevel);

			this._camera.on();
			Locator.mainStage.addChild(containerGUI);
			//Parte 1 del Nivel
			this._level.initCapa3();			
			this._level.init();	
			
			
			//Parte 2 del nivel
			this._level.init2Capa3();
			this._level.init2();
			
			//Plataformas
			this._level.getPlatforms();
			
			this._char.spawn();
			Locator.mainStage.focus = Locator.mainStage;
			
			this._level.locateElements();
			
			//Capas exteriores
			this._level.initCapa1();
			this._level.initCapaInicio();
			this._level.initCapaFin();
			
			
			this._controller = new UserController(this._char, Keyboard.SPACE);
			
			//Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
			Locator.updateManager.addCallback(evUpdate);
			//Locator.mainStage.addEventListener(KeyboardEvent.KEY_UP, pause);
			Locator.inputManager.setRelation("Pause", Keyboard.ENTER);
			
			gui.init(900,40);
			gui.model.counter.text = "0";
		}
		
		public function addResult(name:String):void
		{
			this._res.add(name);
			//Locator.mainStage.removeEventListener(Event.ENTER_FRAME, evUpdate);
			Locator.updateManager.removeCallback(evUpdate);
		}
		
		
		public function restartGame(e:MouseEvent):void
		{			
			if(this._isPaused)
			{
				this.pauseGui.model.btn_reset.removeEventListener(MouseEvent.CLICK, restartGame);
				Locator.mainStage.focus = this.containerLevel;
				Locator.mainStage.focus = null;
				this._isPaused = false;
				Locator.mainStage.removeChild(pauseGui.model);
			}
			for each(var elem in this.allDestroys)
			{
				elem.destroy();
			}
			
			this.allDestroys = new Vector.<IDestroyable>();
			Bullet._allBullets = new Vector.<Bullet>();
			//this.updateables = new Array();
			Locator.updateManager.allCallbacks = new Vector.<Function>();
			Locator.game._level.allLevelLayers = new Vector.<Sprite>();
			this.containerLevel.removeChildren();
			this.containerGUI.removeChildren();
			
			this._camera = new Camera();
			this.containerLevel = new Sprite();
			this._level = new Level();
			this._char = new Player();
			this._collectables = new Collectables();
			this.containerGUI = new Sprite();
			

		}
		
		public function endGame(e:MouseEvent):void
		{
			NativeApplication.nativeApplication.exit(0);
		}
		
		public function pause():void
		{
			//trace("Pause...");
			if( Locator.inputManager.getKeyPressingByName("Pause") && !this._isPaused)
			{
				//Locator.mainStage.removeEventListener(Event.ENTER_FRAME, evUpdate);
				Locator.updateManager.removeCallback(evUpdate);
				this._isPaused = true;
				pauseGui = new Pause();
				Locator.mainStage.addChild(pauseGui.model)		
				pauseGui.model.x = Locator.mainStage.stageWidth/2;
				pauseGui.model.y = Locator.mainStage.stageHeight/2;
				this.pauseGui.model.btn_reanudar.addEventListener(MouseEvent.CLICK, removePause);
				this.pauseGui.model.btn_reset.addEventListener(MouseEvent.CLICK, restartGame);
				this.pauseGui.model.btn_reset.addEventListener(MouseEvent.CLICK, initGame);
				this.pauseGui.model.btn_menu.addEventListener(MouseEvent.CLICK, menu);
				this.pauseGui.model.btn_menu.addEventListener(MouseEvent.CLICK, restartGame);

			}else if(Locator.inputManager.getKeyPressingByName("Pause")&& this._isPaused)
			{
				//Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
				Locator.updateManager.addCallback(evUpdate);
				this._isPaused = false;
				Locator.mainStage.removeChild(pauseGui.model);
			}			
		}
		
		public function initGame(e:MouseEvent):void
		{
			Locator.game.startGame();
		}
		
		public function menu(e:MouseEvent):void
		{
			this.pauseGui.model.btn_menu.removeEventListener(MouseEvent.CLICK, menu);
			Locator.mainStage.focus = this.containerLevel;
			Locator.mainStage.focus = null;

			this._isPaused = false;
			Locator.mainStage.removeChild(pauseGui.model);
			//this._menu = new Menu();
			//this._menu.addMenu();
		}
		
		public function menuWin(e:MouseEvent):void
		{
			
			//this._model.btn_menu.addEventListener(MouseEvent.CLICK, Locator.game.menuWin);
			Locator.mainStage.focus = this.containerLevel;
			Locator.mainStage.focus = null;
			//Locator.mainStage.removeChild(pauseGui.model);
			//this._menu = new Menu();
			//this._menu.addMenu();
			
		}
		
		public function removePause(e:MouseEvent):void
		{
			this.pauseGui.model.btn_reanudar.removeEventListener(MouseEvent.CLICK, removePause);
			Locator.mainStage.focus = this.containerLevel;
			Locator.mainStage.focus = null;
			//Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
			Locator.updateManager.addCallback(evUpdate);
			this._isPaused = false;
			Locator.mainStage.removeChild(pauseGui.model);
		}
		
		protected function evUpdate(event:Event):void
		{
			//trace("Updateando...");
		/*	for(var i:int=0; i<updateables.length; i++)
			{
				updateables[i].update();
			}*/
			//this._char.update();
			pause();
			this._camera.lookAt(this._char.model.mc_hitCenter);
			//this._controller.update();
			this.gui.model.counter.text = this._char.totalDiamond;	
		}		
	}
}