package se.raweden.ui.desktop
{
	/**
	 * Constants that is to be used with the <code>UIDragging.formation</code> property.
	 * 
	 * @see UIDragging.formation
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