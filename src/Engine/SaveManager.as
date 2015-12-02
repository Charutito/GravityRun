package Engine
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;

	public class SaveManager
	{
		public var saver:FileStream;
		public var file:File;
		public var allData:Dictionary = new Dictionary();
		
		public var PATH:String = "savegames/";
		public var SAVE_NAME:String = "mySave.dat";
		
		public function SaveManager()
		{
			file = File.documentsDirectory.resolvePath(PATH + SAVE_NAME);
		}
		
		//Save y Load by Object...
		public function saveObject():void
		{
			saver = new FileStream();
			saver.open(file, FileMode.WRITE);
			saver.writeObject(allData);
			saver.close();
			allData = new Dictionary();
		}
		
		public function loadObject():void
		{
			saver = new FileStream();
			saver.open(file, FileMode.READ);
			allData = saver.readObject();
			saver.close();
		}
		
		// Save y Load normales?
		public function save():void
		{
			saver = new FileStream();
			saver.open(file, FileMode.WRITE);
			
			for( var varName:String in allData)
			{
				saver.writeUTFBytes(varName + "=" + allData[varName] + ";\n");
			}
			
			saver.close();
		}
		
		
		public function load():void
		{
			saver = new FileStream();
			saver.open(file, FileMode.READ);
			
			var text:String = saver.readUTFBytes( saver.bytesAvailable - 2 );
			var escapedText:String = escape(text);
			var lines:Array = escapedText.split("%3B%0A");
			
			allData = new Dictionary();
			for(var i:int=0; i<lines.length; i++)
			{
				var splittedLine:Array = lines[i].split("%3D");
				var varName:String = splittedLine[0];
				var value:String = unescape(splittedLine[1]);
				
				allData[varName] = value;
			}
			
		}
	}
}