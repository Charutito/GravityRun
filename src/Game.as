package
{
	import Characters.Player;
	import Characters.UserController;
	
	import Engine.Camera.Camera;
	import Engine.Locator;
	
	import General.Collectables;
	
	import Interfaces.IDestroyable;
	
	import Screens.GUI;
	import Screens.Level;
	import Screens.Menu;
	import Screens.WinAndLose;
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.dns.AAAARecord;
	import flash.ui.Keyboard;

	public class Game
	{
		private var _char:Player;
		private var _controller:UserController;
		private var _camera:Camera;
		
		private var _menu:Menu;
		
		private var _level:Level;
		private var _res:WinAndLose;
		private var _collectables:Collectables;
		
		public var updateables:Array;
		//Containers...
		public var containerLevel:MovieClip;
		public var containerGUI:GUI;
		
		//Probando probando 1...2...3...
		public var allDestroys:Vector.<IDestroyable> = new Vector.<IDestroyable>();
		
		public function Game()
		{
			this._menu = new Menu();
			this._camera = new Camera();
			this.containerLevel = new MovieClip();
			this._level = new Level();
			this._char = new Player();
			this._collectables = new Collectables();
			this.containerGUI = new GUI();
			this.updateables = new Array();
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
		
		
		public function loadMenu(e:Event):void
		{
			this._menu.addMenu();
		}
		
		public function startGame(event:Event):void
		{
			//remuevo el menu
			//if(Locator.mainStage.contains(this._menu.menuModel))
			this._menu.removeMenu();
			
			Locator.mainStage.addChild(this.containerLevel);
			this._camera.addToView(this.containerLevel);
			this._camera.on();
			
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
			
			//Capas exteriores
			this._level.initCapa1();
			this._level.initCapaInicio();


			this._controller = new UserController(this._char, Keyboard.SPACE);

			Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
			
			this._level.locateElements();
			
			containerGUI.init(900,40);
			containerGUI.model.counter.text = "0"
		}
		
		public function addResult(name:String):void
		{
			this._res.add(name);
		}
		
		public function restartGame(e:MouseEvent):void
		{
			Locator.mainStage.removeEventListener(Event.ENTER_FRAME, evUpdate);
			//this.containerLevel.removeChildren();
			//Locator.mainStage.removeChildren();
			for each(var elem in IDestroyable)
				elem.destroy();
			if(this._res != null)	
				this._res.remove();
			
			loadMenu(e);
		}
		
		public function endGame(e:MouseEvent):void
		{
			NativeApplication.nativeApplication.exit(0);
		}
		
		protected function evUpdate(event:Event):void
		{
			for(var i:int=0; i<updateables.length; i++)
			{
				updateables[i].update();
			}
			this._char.update();
			this._camera.lookAt(this._char.model.mc_hitCenter);
			this._controller.update();
			this.containerGUI.model.counter.text = this._char.totalDiamond;	
		}		
	}
}