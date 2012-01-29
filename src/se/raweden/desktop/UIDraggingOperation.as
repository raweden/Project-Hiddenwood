package se.raweden.desktop
{
	/**
	 * The <code>UIDraggingOperation</code> contains constants to be 
	 * used with the <code>UIDragging.operation</code> property.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @see UIDragging.operation
	 */
	public class UIDraggingOperation{
		
		/**
		 * Determines that no operation is allowed by the destination.
		 */
		public static const NONE:int = 0;
		
		/**
		 * Determines that the destination is allowed to copy the data or the referenced.
		 */
		public static const COPY:int = 1;
		
		/**
		 * Determines that the data or reference is allowed to be shared with the destination.
		 */
		public static const LINK:int = 2;
		
		/**
		 * Determines that the data or reference is allowed to be moved to the destination.
		 */
		public static const MOVE:int = 4;
		
		/**
		 * Determines that the destination is allowed to delete the data or reference.
		 */
		public static const DELETE:int = 8;
		
		/**
		 * Determines that all operations above is allowed.
		 */
		public static const EVERY:int = COPY | LINK | MOVE | DELETE;
		
	}
}