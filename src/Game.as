package
{
	import Engine.Camera.Camera;
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;

	public class Game
	{
		public var Runner:Player;
		private var _controller:UserController;
		
		
		private var _cam:Camera;
		private var _menu:Menu;
		
		public function Game()
		{
			this._menu = new Menu();
		}
		
		public function loadMenu(e:Event):void
		{
			this._menu.addMenu();
		}

		public function startGame(event:Event):void
		{
			//remuevo el menu
			this._menu.removeMenu();
			
			Runner = new Player();
			Runner.spawn();
			
			_controller = new UserController(Runner, Keyboard.SPACE);

			Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
			
			_cam = new Camera();
			_cam.on();
			//_cam.addToView();
		}
		
		
		protected function evUpdate(event:Event):void
		{
			Runner.update();
			Runner.move();
			_controller.Update();
			
			_cam.lookAt(Runner.model);

		}

		
	}
}