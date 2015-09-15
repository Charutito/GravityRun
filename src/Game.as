package
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;

	public class Game
	{
		public var Runner:Player;
		private var _controller:UserController;
		
		private var _menu:Menu;
		
		private var _level:Level01;		
		public static var allPlatforms:Vector.<MovieClip> = new Vector.<MovieClip>();
		
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

			
			_level = new Level01();
			_level.init();
			
			Runner = new Player();
			Runner.spawn();
			Locator.mainStage.focus = Locator.mainStage;
			
			_level.initCapa1();
			initializeLevel();

			_controller = new UserController(Runner, Keyboard.SPACE);

			Locator.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);

		}
		
		public function initializeLevel():void
		{
			for(var i:int=0; i<_level.model.numChildren; i++)
			{
				if(_level.model.getChildAt(i).name == "hit_platform")
				{
					allPlatforms.push( _level.model.getChildAt(i) );
					_level.model.getChildAt(i).alpha = 0;
				}
			}
		}
		
		
		protected function evUpdate(event:Event):void
		{
			Runner.update();
			Runner.move();
			
			_controller.Update();

		}		
	}
}