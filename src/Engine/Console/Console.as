package Engine.Console
{
	import Engine.Locator;
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.engine.Kerning;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	
	import flashx.textLayout.events.ScrollEvent;

	public class Console
	{
		private var _model:MovieClip;
		private var _isOpened:Boolean;
		private var _allCommands:Dictionary = new Dictionary();
		
		
		public function Console()
		{
			this._model = new MCConsole();
			Locator.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown);
			this._model.upArrow.addEventListener(MouseEvent.CLICK, evScrollUp);
			this._model.downArrow.addEventListener(MouseEvent.CLICK, evScrollDown);
			registerCommand("help", showHelp, "Muestra los comandos disponibles.");
			registerCommand("cls", clear, "Limpia el log de la consola.");
			registerCommand("exit", exit, "Cierra la aplicacion.");
			registerCommand("quit", exit, "Cierra la aplicacion.");
		}
		
		public function evScrollUp(e:MouseEvent):void
		{
			this._model.tb_log.scrollV--;
		}
		
		public function evScrollDown(e:MouseEvent):void
		{
			this._model.tb_log.scrollV++;
		}
		
		protected function evKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.F8)
			{
				if(!this._isOpened)
					open();
				else
					close();
			}else if(this._isOpened && event.keyCode == Keyboard.ENTER)
			{
				exec();
			}
			
		}

		public function registerCommand(name:String, command:Function, description:String):void
		{
			var cData:CommandData = new CommandData();
			cData.name = name;
			cData.command = command;
			cData.description = description;
			this._allCommands[name] = cData;
		}
		
		public function unregisterCommand(name:String):void
		{
			delete this._allCommands[name];
		}
		
		public function exec():void
		{
			var consoleText:String = this._model.tb_input.text;
			var splittedText:Array = consoleText.split(" ");
			var commandName:String = splittedText[0];
			splittedText.shift();
			
			
			var cData:CommandData = this._allCommands[commandName];
			trace(cData);
			trace(consoleText);
			if(cData != null)
			{
				try
				{
					cData.command();	
				}catch(e1:ArgumentError)
				{
					if(splittedText.length > 0)
					{
						try
						{
							cData.command.apply(this, splittedText);
						}catch(e3:ArgumentError)
						{
							write("La cantidad de argumentos es invalida...");
						}catch(e4:Error)
						{
							trace( "Error raro: " + "\n" + e4.name + "\n" + e4.getStackTrace() );
						}
					}else
					{
						write("El comando esperaba al menos un parametro...")
					}
				}catch(e2:Error)
				{
					trace( "Error raro: " + "\n" + e2.name + "\n" + e2.getStackTrace() );
				}
			}else
			{
				write("El comando es inexistente...");
			}
			
			this._model.tb_input.text = "";
		}
		
		public function write(message:String):void
		{
			this._model.tb_log.text += message + "\n";
		}
		
		public function clear():void
		{
			this._model.tb_log.text = "";
		}
		
		public function showHelp():void
		{
			trace("Se mostro la ayuda...");
			for each(var myCData:CommandData in _allCommands)
			{
				write(myCData.name + " : " + myCData.description + "\n");
			}
		}
		
		public function exit():void
		{
			NativeApplication.nativeApplication.exit(0);
		}
		
		public function open():void
		{
			trace("Abriendo Consola...");
			this._isOpened = true;
			Locator.mainStage.addChild(this._model);
			
			//Aca tire fruta despues lo arreglamos bien:
			this._model.x = 512;
			this._model.y = 384;
			Locator.mainStage.focus = this._model.tb_input;
		}
		
		public function close():void
		{
			trace("Cerrando Consola...");
			this._isOpened = false;
			Locator.mainStage.removeChild(this._model);
			Locator.mainStage.focus = Locator.mainStage;
			this._model.tb_input.text = "";
		}
		
	}
}