package Mono.Console
{
	
	import Mono.Mono;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	public class Console extends Mono
	{
		public var consoleText:TextField;
		public var commands:Dictionary;
		public var isOpened:Boolean;
		public var comandosAnteriores:Vector.<TextField> = new Vector.<TextField>;
		
		public function Console()
		{
			
		}
		
		/** Enciende la consola. Update: 12/06/2014
		 * 
		 * @param font Fuente tipográfica de la consola (Por defecto 'Console')
		 * @param size Tamaño de la fuente de la consola (Por defecto 20)
		 * @param colour Color de la fuente de la consola (Por defecto 0xFFFFFF / Blanco)
		 * 
		 *  */
		public function encenderConsole(font:String = "Console", size:int = 20, colour:Number = 0xFFFFFF):void
		{
			commands = new Dictionary(); //Crea el diccionario de comandos para la consola
			isOpened = true; //Avisa que la consola esta abierta
			consoleText = new TextField(); //Crea el textfield para la consola
			consoleText.type = TextFieldType.INPUT; //Vuelve INPUT al texto, para que el usuario pueda ingresar sus valores
			consoleText.defaultTextFormat = new TextFormat(font, size, colour); //Crea el formato para la consola
			consoleText.autoSize = TextFieldAutoSize.LEFT; //Alinea hacia la izquierda el texto y lo vuelve autosize
			Main.mono.mainStage.addChild(consoleText); //Agrega el texto de la consola al stage
			Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); //Agrega un listener para ver que teclas estan presionadas
			agregarHistorial("Bienvenido a la consola"); //Agrega al historial un saludo de bienvenida a la consola
			agregarHistorial("     Escriba 'close' para cerrar la consola"); //Informa como cerrar la consola
			agregarHistorial("     Escriba '?' para ver la lista de comandos"); //Informa como pedir ayuda por consola
			registerCommand("?", help, "Devuelve la lista de comandos"); //Explica como funciona la función help
			registerCommand("cls", cleanConsole, "Limpia el historial de la consola"); //Explica como funciona la función cleanConsole
			registerCommand("close", close, "Cierra la consola"); //Explica como funciona la función close
		}
		
		/** Se fija que teclas estan presionadas y afectan a la consola. Update: 12/06/2014
		 *  */
		private function evKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode) //Se fija que tecla esta presionada
			{
				case Keyboard.F8: //Si la tecla es F8
					if(isOpened) //Pregunta si la consola esta abierta
					{
						close(); //Si esta abierta la cierra
					}
					else
					{
						open(); //Si esta cerrada la abre
					}
					break;
				
				case Keyboard.ENTER:
				{
					executeCommand(); //Ejecuta el comando que este en la consola
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		/** Registra un comando para la consola. Update: 16/05/2014
		 * @param name El nombre del comando
		 * @param com La función que va con el comando
		 * @param description La descripción del comando
		 *  */
		public function registerCommand(name:String, com:Function, description:String):void
		{
			var tempData:CommandData = new CommandData(); //Crea una data temporal para el comando a agregar
			tempData.name = name; //Le asigna el nombre al comando
			tempData.command = com; //Le asigna la función al comando
			tempData.description = description; //Le asigna una descripción al comando
			
			commands[name] = tempData; //Agrega al diccionario el comando
		}
		
		/** Elimina un comando de la consola. Update: 16/05/2014
		 * @param name El nombre del comando.
		 *  */
		public function unregisterCommand(name:String):void
		{
			delete commands[name]; //Elimina al comando del diccionario
		}
		
		/** Ejecuta el comando que se encuentre en la consola. Update: 16/05/2014
		 *  */
		public function executeCommand():void
		{
			var cutResult:Array = consoleText.text.split(" "); //Corta el texto en partes para su lectura
			var commandName:String = cutResult[0]; //Toma el primer indice donde se ubica el nombre del comando
			var tempCommand:CommandData = commands[commandName]; //Busca el comando por su nombre en el código
			cutResult.shift(); //Elimina el primer índice debido a que el nombre ya se almaceno en commandName
			
			if(tempCommand != null) //Busca que el comando este efectivamente en la lista de comandos
			{
				if(cutResult.length > 0)
				{
					tempCommand.command.apply(null, cutResult); //Si tiene más de una parte el comando, los separa por partes
				}
				else if(commandName!="sumarpuntos" && commandName!="dificultad")
				{
					tempCommand.command.apply(); //Si el comando no tiene más partes, aplica directamente
				}
				else
				{
					agregarHistorial("+ERROR: El comando fue mal implementado"); //Avisa que el comando fue mal implementado
				}
			}
			else
			{
				agregarHistorial("+ERROR: El comando no existe"); //Avisa que el comando no existe
			}
		}
		
		/** Abre la consola. Update: 16/05/2014
		 *  */
		private function open():void
		{
			Main.mono.mainStage.addChild(consoleText); //Agrega el INPUT de la consola al stage
			consoleText.text = "+Inserte comando"; //Le da un texto inicial a la zona de INPUT
			isOpened = true; //Avisa que la consola esta abierta
		}
		
		/** Cierra la consola. Update: 12/06/2014
		 *  */
		private function close():void
		{
			Main.mono.mainStage.removeChild(consoleText); //Remueve el INPUT de la consola del stage
			Main.mono.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); //Elimina el listener del key down
			cleanConsole(); //Limpia la consola
			isOpened = false; //Avisa que la consola esta cerrada
		}
		
		/** Función help de la consola. Muestra la lista de comandos. Update: 16/05/2014
		 *  */
		private function help():void
		{
			agregarHistorial(" ? ");
			agregarHistorial("+Se ejecutó la función Help");
			agregarHistorial("HELP: A continuación tiene una lista de los comandos que puede utilizar en la consola");
			for each(var current:CommandData in commands) //Recorre todo el diccionario
			{
				agregarHistorial("     "+current); //Muestra el comando por consola
			}
		}
		
		/** Función clean de la consola. Elimina el historial de la consola. Update: 16/05/2014
		 *  */
		private function cleanConsole():void
		{
			for (var i:int = 0 ; i < comandosAnteriores.length ; i++) //Recorre todos los comandos anteriores
			{
				if(comandosAnteriores[i] != null) //Mira que no sea null
				{
					Main.mono.mainStage.removeChild(comandosAnteriores[i]); //Los remueve
				}
			}
			comandosAnteriores = new Vector.<TextField>(); //Reemplaza el vector
		}
		
		/** Función Agrega al historial el texto. Update: 16/05/2014
		 *  */
		private function agregarHistorial(texto:String):void
		{
			comandosAnteriores.splice(0, 0, new TextField); //Agrega un espacio en el primer lugar del historial
			Main.mono.mainStage.addChild(comandosAnteriores[0]); //Agrega el comando nuevo
			comandosAnteriores[0].defaultTextFormat = new TextFormat("Console", 20, 0xFFFFFF); //Le da formato de texto
			comandosAnteriores[0].wordWrap = true; //Activa el wordWrap
			comandosAnteriores[0].width = 770; //Le setea el ancho
			comandosAnteriores[0].autoSize = TextFieldAutoSize.LEFT; //Lo alinea a la izquierda
			comandosAnteriores[0].text = texto; //Le define el texto a mostrar
			comandosAnteriores[0].y=320; //Lo coloca en la posición de y
			comandosAnteriores[0].x=13; //Lo coloca en la posición de x
			for (var i:int = 0; i< comandosAnteriores.length; i++) //Recorre los comandos anteriores
			{
				comandosAnteriores[i].y -=consoleText.height; //Les modifica la posición para ir trasladandolos
			}
		}
	}
}
