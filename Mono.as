package Mono
{
	import Mono.Console.Console;
	import Mono.Managers.AssetsManager;
	import Mono.Managers.InputManager;
	import Mono.Managers.ScreenManager;
	import Mono.Managers.UpdateManager;
	import Mono.Math.MathGeometry;
	import Mono.Math.MathMatrix;
	import Mono.Math.MathSimple;
	import Mono.Visual.Artist;
	import Mono.Visual.Camera2D;
	
	import flash.display.Sprite;
	import flash.display.Stage;

	public class Mono
	{
		
		public var mainStage:Stage;
		public var um:UpdateManager;
		public var am:AssetsManager;
		public var artist:Artist;
		
		private var mInformacion:Boolean = false;
		
		public function Mono()
		{
		}
		
		/** Inicia el Framework.
		 * 
		 *  */
		public function iniciar():void
		{
			trace("Framework 'Mono' v2.0.0 // Creado por Facundo Balboa // Última versión: 28/03/2015");
			crearSeparador();
		}
		
		/** Crea un mensaje de error para avisar al usuario por medio de un trace. Update: 13/04/2014
		 * 
		 * @param message Mensaje de error.
		 * @param folder Carpeta dentro del framework en la que se encuentra la clase.
		 * @param clas Clase donde se provocó el error.
		 * @param functio Función en la que se provocó el error.
		 * 
		 * */
		public function reportarError(message:String, folder:String, clas:String, functio:String):void
		{
			trace("ERROR:");
			trace(message);
			trace("Ubicado en // Carpeta: "+folder+" Clase: "+clas+" Función: "+functio);
			crearSeparador();
		}
		
		/** Crea un mensaje para avisar al usuario que puede utilizar una clase, a través de un trace. Update: 13/04/2014
		 * 
		 * @param clas Clase a abrir.
		 * @param folder Carpeta dentro del framework en la que se encuentra la clase.
		 * 
		 * */
		public function reportarAbrir(clas:String, folder:String):void
		{
			trace("Abrió la clase: "+clas+" ubicada en: "+folder);
			crearSeparador();
		}
		
		/** Crea un mensaje para avisar al usuario que ya no puede una clase, a través de un trace. Update: 13/04/2014
		 * 
		 * @param clas Clase a cerrar.
		 * @param folder Carpeta dentro del framework en la que se encuentra la clase.
		 * 
		 * */
		public function reportarCerrar(clas:String, folder:String):void
		{
			trace("Cerró la clase: "+clas+" ubicada en: "+folder);
			crearSeparador();
		}
		
		/** Crea un mensaje de alerta para avisar al usuario por medio de un trace. Update: 15/04/2014
		 * 
		 * @param message Mensaje de alerta.
		 * @param folder Carpeta dentro del framework en la que se encuentra la clase.
		 * @param clas Clase donde se provocó la alerta.
		 * @param functio Función en la que se provocó la alerta.
		 * 
		 * */
		public function reportarAlerta(message:String, folder:String, clas:String, functio:String):void
		{
			trace("Alerta:" + message);
			trace("Ubicado en // Carpeta: "+folder+" Clase: "+clas+" Función: "+functio);
			crearSeparador();
		}
		
		/** Reporta información a través de un trace. Update: 07/03/2015
		 * 
		 * @param message Mensaje de información
		 * @param folder Carpeta dentro del framework en la que se encuentra la clase.
		 * @param clas Clase de donde se envía la información.
		 * @param functio Función de donde se envía la información.
		 * 
		 * */
		public function reportarInformacion(message:String, folder:String, clas:String, functio:String):void
		{
			if(mInformacion)
			{
				trace("Información:" + message);
				trace("Ubicado en // Carpeta: "+folder+" Clase: "+clas+" Función: "+functio);
				crearSeparador();
			}
		}
		
		/** Cambia el estado de mostrar información. Update: 07/03/2015
		 * 
		 * 
		 * */
		public function mostrarInformacion():void
		{
			mInformacion=!mInformacion; //Cambia el estado de mostrar información
			reportarInformacion("A partir de ahora se encuentra activado mostrar información", "Inicio", "Mono", "mostrarInformacion");
		}
		
		/** Crea un separador que envía en el trace para facilitar la lectura. Update: 13/04/2014
		 * 
		 *  */
		public function crearSeparador():void
		{
			trace("**************************************************************");
		}
	}
}
