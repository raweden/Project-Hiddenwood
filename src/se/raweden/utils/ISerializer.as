package se.raweden.utils
{
	import flash.utils.ByteArray;

	/**
	 * interface for serializers. 
	 */
	public interface ISerializer{
		
		/**
		 * Calling this executes the serialization. The return type is noted as a String, but is a binary stream. echo it to the output buffer
		 */
		function serialize(item:Object):ByteArray
		
	}
}