package Mono.Console
{
	import Mono.Mono;
	
	public class CommandData extends Mono
	{
		public var name:String;
		public var command:Function;
		public var description:String;
		
		public function CommandData()
		{
			
		}
		
		/** Convierte en String el comando. Update: 12/06/2014
		 * 
		 * 
		 * @return Devuelve un string con los parámetros. */
		public function toString():String
		{
			return "+Name: " + name + " / Description: " + description; //Devuelve el string con los parámetros
		}
	}
}
