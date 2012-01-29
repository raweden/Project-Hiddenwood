package se.raweden.desktop
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Dispatched by the target <code>IDraggingDestination</code> when a dragging object is dropped
	 * and the the operations is validated by implementation of <code>IDraggingDestination.acceptsDrop()</code> method.
	 */
	[Event(name="dragDrop", type="se.raweden.ui.events.UIDragEvent")]
	
	/**
	 * Dispatched by the <code>UIDragging</code> when the dragging location moves.
	 */
	[Event(name="dragUpdate", type="se.raweden.ui.events.UIDragEvent")]
	
	/**
	 * Dispatched by the target <code>IDraggingDestination</code> when a dragging operations enters its boundary.
	 */
	[Event(name="dragEnter", type="se.raweden.ui.events.UIDragEvent")]
	
	/**
	 * Dispatched by the target <code>IDraggingDestination</code> when a dragging operations leaves its boundary.
	 */
	[Event(name="dragExit", type="se.raweden.ui.events.UIDragEvent")]
	
	/**
	 * Dispatched by the <code>UIDragging</code> when the dragging ends.
	 */
	[Event(name="dragEnd", type="se.raweden.ui.events.UIDragEvent")]
	
	/** 
	 * The <code>IDraggingDestination</code> interface declares method that any <code>DisplayObject</code>
	 * must implement to be a possible dragging destination to the <code>UIDragging</code> api.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface IDraggingDestination extends IEventDispatcher{
		
		/**
		 * Determine whether the destionation accepts drop from the session.
		 * 
		 * @param session The current <code>UIDragging</code> session.
		 * @return A <code>A Boolean value indicating whether the destination accepts the session's pasteboard.</code>
		 * 
		 * @see UIDragging
		 */
		function acceptsDrop(session:UIDragging):Boolean;
		
		/**
		 * 
		 * @param  session
		 * @return 
		 * 
		 * @see UIDragging
		 */
		function updateDraggingItems(session:UIDragging):Object;
				
	}
}