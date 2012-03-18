package se.raweden.utils
{
	import flash.utils.ByteArray;
	
	/**
	 * Interface for Deserializers.
	 */
	public interface IDeserializer{
		
		/**
		 * Deserialize the data.
		 */
		function deserialize(data:ByteArray,type:String):*;
		
	}
}