package se.raweden.managers
{
	/**
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface IOperation{
		
		//
		// TODO: write documentation for this interface.
		//
		
		/**
		 * 
		 */
		function performRedo():void;
		
		/**
		 * 
		 */
		function performUndo():void;
		
	}
}