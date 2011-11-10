package se.raweden.ui.managers
{
	/**
	 * 
	 * @copyright Copyright 2011 Raweden. All rights reserved.
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