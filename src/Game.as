package
{
	import Characters.Player;
	import Characters.UserController;
	
	import Engine.Camera.Camera;
	import Engine.Locator;
	
	import General.Collectables;
	
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
		
		public function addResult(name:String):void
		{
			var res:WinAndLose = new WinAndLose();
			res.add(name);
		}
		
		public function restartGame(e:MouseEvent):void
		{
			Locator.mainStage.removeEventListener(Event.ENTER_FRAME, evUpdate);
		/*	for(var i:int=0; i<this.containerLevel.numChildren; i++)
			{
				this.containerLevel.removeChildAt(i);
				trace("Removi de containerLevel a: " + this.containerLevel.getChildAt(i).name);
			}
			
			for(var j:int=0; j<Locator.mainStage.numChildren;j++)
			{
				Locator.mainStage.removeChildAt(j);
				trace("Removi de mainStage a: " + Locator.mainStage.getChildAt(j).name);
			}*/
			this.containerLevel.removeChildren();
			Locator.mainStage.removeChildren();
			loadMenu(e);
			
		}
		
		public function endGame(e:MouseEvent):void
		{
			NativeApplication.nativeApplication.exit(0);
		}
		
		protected function evUpdate(event:Event):void
		{
			this._char.update();
			//this._char.move(1);
			this._camera.lookAt(this._char.model.mc_hitCenter);
			this._controller.Update();
			this.containerGUI.model.counter.text = this._char.totalDiamond;	
			trace("Children de mainStage: " + Locator.mainStage.numChildren);
			trace("Children de containerLevel: " + this.containerLevel.numChildren);
		}		
	}
}