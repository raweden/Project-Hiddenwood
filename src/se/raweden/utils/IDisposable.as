package se.raweden.utils
{
	
	/**
	 * The <code>IDisposable</code> is a abstract interface, for object that can be destroyed
	 * to free up memory and application resources.
	 *
	 * Copyright 2011, Raweden. All Rights Reserved.
	 *
	 * @author Raweden
	 */
	public interface IDisposable{
		
		/**
		 * This method is called by the object owner when the to inform the object
		 * that it is being reclaimed and that it shoudl destory itself, and remove references.
		 */
		function dispose():void;
		
	}
}