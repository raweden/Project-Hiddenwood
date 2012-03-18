package se.raweden.utils
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	/**
	 * 
	 */
	public interface IExternalizable{
		
		/**
		 * 
		 * @param	input
		 * @param	type
		 * @return	A <code>Boolean</code> value that determine whether the read operation where successful.
		 */
		function readExternal(input:IDataInput,type:String):Boolean;
		
		/**
		 * 
		 * @param	output
		 * @param	type
		 * @return	A <code>Boolean</code> value that determine whether the write operation where successful.
		 */
		function writeExternal(output:IDataOutput,type:String):Boolean;
		
		/**
		 * A <code>Boolean</code> value that determine whether the model have change
		 * since last call to the <code>writeExternal()</code> method.
		 */
		function get isEdited():Boolean;
		
	}
}