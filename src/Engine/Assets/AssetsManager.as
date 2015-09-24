package Engine.Assets
{
	import Engine.Locator;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.osmf.media.LoadableElementBase;
	
	public class AssetsManager extends EventDispatcher
	{
		public static const ENGINE_PATH:String = "Assets/";
		
		private var _loaderLinks:URLLoader;
		private var _allAssets:Dictionary = new Dictionary();
		private var _allLinksForLoad:Array = new Array();
		private var _allNamesForLoad:Array = new Array();
		private var _numAssetsLoaded:int = 0;
		private var _numTotalAssets:int = 0;
		public var preloadModel:MovieClip;
		
		public function AssetsManager()
		{
			this.preloadModel = new MC_Preload();
			trace("Starting AssetsManager...");
		}
		
		/** Add the links file... */
		public function loadLinks(path:String):void
		{
			var url:URLRequest = new URLRequest( ENGINE_PATH + path);
			this._loaderLinks = new URLLoader();
			this._loaderLinks.dataFormat = URLLoaderDataFormat.VARIABLES;
			this._loaderLinks.load(url);
			this._loaderLinks.addEventListener(Event.COMPLETE, evLinksComplete);
		}
		
		protected function evLinksComplete(event:Event):void
		{
			for(var varName:String in this._loaderLinks.data)
			{
				var linkCut:String = escape(this._loaderLinks.data[varName]).split("%0D%0A")[0];
				this._allLinksForLoad.push(linkCut);
				this._allNamesForLoad.push(varName);
			}
			
			this._numTotalAssets = this._allLinksForLoad.length;
			loadAsset( this._allLinksForLoad[0] );
			Locator.mainStage.addChild(this.preloadModel);
			this.preloadModel.x = Locator.mainStage.stageWidth/2;
			this.preloadModel.y = Locator.mainStage.stageHeight/2;
			this.preloadModel.gotoAndStop(1);
		}
		
		public function loadAsset(path:String):void
		{
			var folder:String = path.split("/")[0];
			var completeURL:String = ENGINE_PATH + path;

			switch(folder)
			{
				case "images":
				case "movies":
					var newImage:Loader = new Loader();
					newImage.load(new URLRequest( completeURL ) );
					trace("Cargando Archivo de Imagen...");
					
					newImage.contentLoaderInfo.addEventListener(Event.COMPLETE, evAssetComplete);
					newImage.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, evError);
					newImage.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, evProgress);
					
					this._allAssets [this._allNamesForLoad[0] ] = newImage;
					break;
				
				case "sounds":
					var newSound:Sound = new Sound();
					newSound.load( new URLRequest ( completeURL ) ) ;
					newSound.addEventListener(Event.COMPLETE, evAssetComplete);
					this._allAssets[ this._allNamesForLoad[0] ] = newSound;
					break;
				case "txts":
					var newTxt:URLLoader = new URLLoader();
					newTxt.load(new URLRequest( completeURL ) );
					newTxt.addEventListener(Event.COMPLETE, evAssetComplete);
					this._allAssets[ this._allNamesForLoad[0] ];
					break;
			}
		}
		
		protected function evProgress(event:ProgressEvent):void
		{
			var percentLoaded:int = event.bytesLoaded * 100 / event.bytesTotal;
			this.preloadModel.gotoAndStop(percentLoaded);
		}
		
		protected function evError(event:IOErrorEvent):void
		{
			trace("Asset not found... 404");			
		}
		
		protected function evAssetComplete(event:Event):void
		{	
			this._numAssetsLoaded++;
			var percentTotal:int = this._numAssetsLoaded * 100 / this._numTotalAssets;
			this.preloadModel.gotoAndStop(percentTotal);
			
			//Remove asset Event
			event.currentTarget.removeEventListener(Event.COMPLETE, evAssetComplete);
			this._allLinksForLoad.shift();
			this._allNamesForLoad.shift();
			if(this._allLinksForLoad.length > 0)
			{
				loadAsset(this._allLinksForLoad[0]);
			}
			else
			{
				Locator.mainStage.removeChild(this.preloadModel);
				dispatchEvent( new AssetsManagerEvents(AssetsManagerEvents.ASSETS_COMPLETE) ) ;
			}
		}
		
		public function getText(name:String):String
		{
			return this._allAssets [ name ] != null ? this._allAssets[name].data : null;
		}
		
		public function getSound(name:String):Sound
		{
			return this._allAssets[ name ];
		}
		
		public function getImage(name:String):Bitmap
		{
			var myLoader:Loader = this._allAssets[name];
			if(myLoader != null)
			{
				var bmpData:BitmapData = new BitmapData(myLoader.width, myLoader.height, true, 0x000000);
				bmpData.draw(myLoader);
				var bmpCopy:Bitmap = new Bitmap(bmpData);
				return bmpCopy;
			}
			return null;
		}
		
		public function getMovieClip(className:String):MovieClip
		{
			
			for(var varName:String in this._allAssets)
			{
				if(this._allAssets[varName] is Loader)
				{
					var myLoader:Loader = this._allAssets[varName];
					try
					{
						var myClass:Class = myLoader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
						return new myClass();
					}catch(e1:ReferenceError)
					{
						trace("Aca no esta el asset... Segui buscando...")
					}
				}
			}
			return null;
		}
	}
}