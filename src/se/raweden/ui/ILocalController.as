package se.raweden.ui
{
	import flash.events.Event;

	/**
	 * The Abstaract interface expodes to other Application via the UIWorspace applications management.
	 */
	public interface ILocalController{
		
		/**
		 * A human readable String representing the display name of the application.
		 */
		function get caption():String;
		
		/**
		 * 
		 */
		function open(arguments:Object):void;
			
		/**
		 * A Boolean value indicating if the application is currently running.
		 */
		function get isRunning():Boolean;
			
		/**
		 * A string indicating the uniqe Identifier for the application.
		 */
		function get uid():String;
			
		/**
		 * Dispatches a Event on the UIApplication instance for the application.
		 */
		function dispatch(event:Event):Boolean;
			
	}
} 