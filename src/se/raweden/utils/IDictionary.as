package se.raweden.utils
{
	
	/**
	 * A <code>Object</code> that implements the <code>IDirectory</code>
	 *
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 *
	 * @author Raweden
	 */
	public interface IDictionary{
		
		/**
		 * Sets a key/value pair.
		 * 
		 * @param key
		 * @param value
		 */
		function setItem(key:String,value:*):void;
		
		/**
		 * Returns the value associated with the given key
		 * 
		 * @param key
		 * @return
		 */
		function getItem(key:String):*;
		
		/**
		 * Removes the item with the specified key.
		 * 
		 * @param key
		 * 
		 * @return A <code>Boolean</code> value that determine whether the value could be removed.
		 */
		function removeItem(key:String):Boolean;
		
		/**
		 * Determine whether the WebStorage has the item with the specified key.
		 * 
		 * @param key
		 * 
		 * @return A <code>Boolean</code> value that determine whether object has a property
		 * with the name.
		 */
		function hasItem(key:String):Boolean;
		
	}
}