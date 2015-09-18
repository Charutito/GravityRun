package Collectables
{
	import Engine.Locator;

	public class Diamond extends Collectables
	{
		public function Diamond()
		{
			this.model = Locator.assetsManager.getMovieClip("MC_Diamond");
			this.model.scaleX = 0.7;
			this.model.scaleY = 0.7;
			this.model.name = "Diamond";
		}		
	}
}