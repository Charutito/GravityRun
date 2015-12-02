package Engine
{
	import Engine.Assets.AssetsManager;
	import Engine.Console.Console;
	import Engine.Input.InputManager;
	
	import flash.display.Sprite;
	import flash.display.Stage;

	public class Locator extends Sprite
	{
		public static var mainStage:Stage;
		public static var console:Console;
		public static var assetsManager:AssetsManager;
		public static var game:Game;
		public static var updateManager:UpdateManager;
		public static var inputManager:InputManager;
		
		public function Locator()
		{
			mainStage = stage;
			console = new Console();
			assetsManager = new AssetsManager();
			game = new Game();
			updateManager =  new UpdateManager();
			inputManager =  new InputManager();
		}
	}
}