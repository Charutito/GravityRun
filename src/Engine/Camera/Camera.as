package Engine.Camera
{
	import Engine.Locator;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Camera
	{
		private var _view:Sprite;
		private var _targetZoom:Number;
		private var _zoomAmount:Number;
		private var _delayZoom:Number;
		
		private var _activeSmoothZoom:Boolean;
		
		public function Camera()
		{
			this._view = new Sprite();
			this._zoomAmount = 0.7;
			
		}
		
		
		public function lookAt(target:MovieClip):void
		{
			var targetPosition:Point = new Point(target.x, target.y);
			var globalPosition:Point = target.parent.localToGlobal(targetPosition);
			var camPoint:Point = this._view.globalToLocal(globalPosition);
			
			x = (camPoint.x + target.width / 2) * zoom - Locator.mainStage.stageWidth / 2;
			//y = (camPoint.y + target.height / 2) * zoom - Locator.mainStage.stageHeight / 2;
		}
		
		
		public function on():void
		{
			Locator.mainStage.addChild(this._view);
		}
		
		public function off():void
		{
			Locator.mainStage.removeChild(this._view);
		}
		
		public function addToView(child:Sprite):void
		{
			this._view.addChild(child);	
		}
		
		public function removeFromView(child:Sprite):void
		{
			this._view.removeChild(child);
		}
		
		public function get x():Number
		{
			return -this._view.x;
		}
		
		public function set x(value:Number):void
		{
			this._view.x = -value;
		}
		
		public function get y():Number
		{
			return -this._view.y;
		}
		
		public function set y(value:Number):void
		{
			this._view.y = -value;
		}
		
		public function get zoom():Number
		{
			return this._view.scaleX;
		}
		
		public function set zoom(value:Number):void
		{
			if(value > 0)
				this._view.scaleX = this._view.scaleY = value;
		}
		
		public function set smoothZoom(value:Number):void
		{
			this._targetZoom = value;
			this._activeSmoothZoom = true;
		}
		
		public function zoomIn():void
		{
			smoothZoom = zoom + this._zoomAmount;
		}
		
		public function zoomOut():void
		{
			smoothZoom = zoom - this._zoomAmount;
		}
		
		
		public function smoothLookAt(target:MovieClip):void
		{
			// a chequear en el caso de ser necesaria.
		}
		
	}
}