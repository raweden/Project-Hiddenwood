package se.raweden.ui.desktop
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
	 * The <code>IDraggingDestination</code> is the abstract <code>interface</code> that 
	 * any <code>UIView</code> subclass must implmenent to resive and handle drag-and-drop events.
	 * 
	 * @copyright Copyright 2011 Raweden. All rights reserved.
	 * @author Raweden
	 */
	public interface IDraggingDestination extends IEventDispatcher{
		
		/**
		 * 
		 */
		function acceptsDrop(session:UIDragging):Boolean;
				
	}
}