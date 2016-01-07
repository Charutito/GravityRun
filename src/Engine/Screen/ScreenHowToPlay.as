package Engine.Screen
{
	import Engine.Locator;
	
	import flash.events.MouseEvent;

	public class ScreenHowToPlay extends CustomScreen
	{
		public function ScreenHowToPlay()
		{
			super("MC_howToPlay");
			this.model.x = -350;
			this.model.y = 100;
			
			this.model.btn_back.addEventListener(MouseEvent.CLICK, removeHTP);
		}
		
		public function removeHTP(e:MouseEvent):void
		{
			Locator.screenManager.screenMngrLoadScr("Main Menu");		
		}
		
	}
}