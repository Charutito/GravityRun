package Engine.Screen
{
	import Engine.Locator;
	
	import flash.events.MouseEvent;

	public class ScreenCredits extends CustomScreen
	{
		public function ScreenCredits()
		{
			super("MC_credits")
			
			this.model.btn_back.addEventListener(MouseEvent.CLICK, removeCredits);
		}
		
		public function removeCredits(e:MouseEvent):void
		{
			Locator.screenManager.screenMngrLoadScr("Main Menu");	
		}
	}
}