package se.raweden.ui
{
	/**
	 * The <code>UIPopoverArrowDirection</code> class contains constants to be used
	 * with the <code>UIPopoverController.arrowDirection</code> property.
	 *
	 * <p>Copyright 2011, Raweden. All Rights Reserved.</p>
	 *
	 * @author Raweden
	 */
	public class ArrowDirection{
		
		/**
		 * 
		 */
		public static const UP:int = 1 << 0;
		
		/**
		 * 
		 */
		public static const DOWN:int = 1 << 1;
		
		/**
		 * 
		 */
		public static const LEFT:int = 1 << 2;
		
		/**
		 * 
		 */
		public static const RIGHT:int = 1 << 3;
		
		/**
		 * 
		 */
		public static const ANY:int = UP | DOWN | LEFT | RIGHT;
		
		/**
		 * 
		 */
		public static const NONE:int = int.MAX_VALUE;


	}
}