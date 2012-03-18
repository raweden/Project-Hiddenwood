package se.raweden.managers
{
	/**
	 * A Object that implements the <code>IOperation</code>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface IOperation{
		
		/**
		 * 
		 */
		function get id():int;
		
		/**
		 * 
		 */
		function get name():String;
		
		/**
		 * 
		 */
		function restore():void;
		
		
	}
}