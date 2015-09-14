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
		
		public function Game()
		{
			
		}

		public function startGame(event:Event):void
		{

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