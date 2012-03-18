package se.raweden.filesystem
{
	import flash.utils.ByteArray;

	public interface IFileReader{
		
		/**
		 * 
		 * 
		 */		
		function load():void;
		
		/**
		 * 
		 * 
		 */

		function cancel():void;
		
		/**
		 * 
		 * @return 
		 */
		function get data():*
		
		/**
		 * 
		 * @return 
		 */
		function get length():Number;
		
	}
}