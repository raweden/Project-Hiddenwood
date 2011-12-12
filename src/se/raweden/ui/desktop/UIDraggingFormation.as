package se.raweden.ui.desktop
{
	/**
	 * The <code>UIDraggingFormation</code> contains contants to be
	 * used with the UIDragging's <code>formation</code> property.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 *
	 * @author Raweden.
	 */
	public class UIDraggingFormation{
		
		/**
		 * Dragging images maintain their positions relative to each other.
		 */
		public static const NONE:String = "none";
		
		/**
		 * Dragging images are placed on top of each other with random rotation.
		 */
		public static const PILE:String = "pile";
		
		/**
		 * Dragging images are laid verticaly, non-overlapping with their left edges aligned.
		 */
		public static const LIST:String = "list";
		
		/**
		 * Dragging images are laid out overlapping diagonally.
		 */
		public static const STACK:String = "stack";		

	}
}