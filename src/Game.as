package
{
	import Characters.Player;
	import Characters.UserController;
	
	import General.Collectables;
	
	import Engine.Camera.Camera;
	import Engine.Locator;
	
	import Screens.GUI;
	import Screens.Level;
	import Screens.Menu;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;

	public class Game
	{
		private var _char:Player;
		private var _controller:UserController;
		private var _camera:Camera;
		
		private var _menu:Menu;
		
		private var _level:Level;
		
		private var _collectables:Collectables;
		
		//Containers...
		public var containerLevel:MovieClip;
		public var containerGUI:GUI;
		
		public function Game()
		{
			this._menu = new Menu();
			this._camera = new Camera();
			this.containerLevel = new MovieClip();
			this._level = new Level();
			this._char = new Player();
			this._collectables = new Collectables();
			this.containerGUI = new GUI();
		}
		
		public function loadMenu(e:Event):void
		{
			this._menu.addMenu();
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
		
		public function startGame(event:Event):void
		{
			//remuevo el menu
			this._menu.removeMenu();
			Locator.mainStage.addChild(this.containerLevel);
			this._camera.addToView(this.containerLevel);
			this._camera.on();
			
			this._level.init();
			
			this._char.spawn();
			Locator.mainStage.focus = Locator.mainStage;
	
			this._level.initCapa1();
			this._level.getPlatforms();

			this._controller = new UserController(this._char, Keyboard.SPACE);

			Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
			
			this._level.locateElements();
			
			containerGUI.init(900,40);
			containerGUI.model.counter.text = "0"
			
		}
		
		protected function evUpdate(event:Event):void
		{
			this._char.update();
			this._char.move();
			this._camera.lookAt(this._char.model.mc_hitCenter);
			
			this._controller.Update();
			
			containerGUI.model.counter.text = this._char.totalDiamond;	
		}		
	}
}