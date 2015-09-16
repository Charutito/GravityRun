package
{
	import Engine.Camera.Camera;
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import Characters.UserController;
	import Characters.Player;
	import Screens.Level01;
	import Screens.Menu;

	public class Game
	{
		public var Runner:Player;
		private var _controller:UserController;
		private var _camera:Camera;
		
		private var _menu:Menu;
		
		private var _level:Level01;
		
		public static var allPlatforms:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		//Containers...
		public var containerLevel:MovieClip;
		
		public function Game()
		{
			this._menu = new Menu();
			this._camera = new Camera();
			this.containerLevel = new MovieClip();
		}
		
		public function loadMenu(e:Event):void
		{
			this._menu.addMenu();
		}

		public function startGame(event:Event):void
		{
			//remuevo el menu
			this._menu.removeMenu();
			Locator.mainStage.addChild(this.containerLevel);
			this._camera.addToView(this.containerLevel);
			this._camera.on();

			
			this._level = new Level01();
			this._level.init();
			
			Runner = new Player();
			Runner.spawn();
			Locator.mainStage.focus = Locator.mainStage;
			
			this._level.initCapa1();
			initializeLevel();
			

			this._controller = new UserController(Runner, Keyboard.SPACE);

			Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);

		}
		
		public function initializeLevel():void
		{
			for(var i:int=0; i<this._level.model.numChildren; i++)
			{
				if(this._level.model.getChildAt(i).name == "hit_platform")
				{
					allPlatforms.push( this._level.model.getChildAt(i) );
					this._level.model.getChildAt(i).alpha = 0;
				}
			}
		}
		
		
		protected function evUpdate(event:Event):void
		{
			Runner.update();
			Runner.move();
			this._camera.lookAt(this.Runner.model.mc_hitCenter);
			
			this._controller.Update();

		}		
	}
}