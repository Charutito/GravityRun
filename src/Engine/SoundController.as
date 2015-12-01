package Engine
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundController
	{
		public var snd:Sound;
		public var config:SoundTransform;
		public var channel:SoundChannel;
		
		public function SoundController(snd:Sound)
		{
			this.snd = snd;
			config = new SoundTransform();			
		}
		
		public function play(volume:Number, loops:int):void
		{
			config.volume = volume;
			config.pan = 0;
			channel = snd.play( 0 , loops , config );
		}
		
		public function stop():void
		{
			channel.stop();
		}
	}
}