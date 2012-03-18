package se.raweden.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.geom.Point;
	
	import se.raweden.desktop.UIDragging;
	import se.raweden.desktop.UIPasteboard;
	
	/**
	 * Description
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @see se.raweden.ui.desktop.UIDragging
	 * @see se.raweden.ui.desktop.IDraggingDestination
	 * 
	 * @author Raweden
	 */
	public class UIDragEvent extends Event{
		
		/**
		 * 
		 */
		public static const DRAG_DROP:String = "dragDrop";
		
		/**
		 * 
		 */
		public static const DRAG_UPDATE:String = "dragUpdate";
		
		/**
		 * 
		 */
		public static const DRAG_ENTER:String = "dragEnter";
		
		/**
		 * 
		 */
		public static const DRAG_EXIT:String = "dragExit";

		/**
		 * 
		 */
		public static const DRAG_END:String = "dragEnd";
		
		
		private var _session:UIDragging;
		private var _resource:UIPasteboard;
		private var _location:Point;		// events location in the stage's cordinate space.
		
		public function UIDragEvent(type:String,session:UIDragging,location:Point,resource:UIPasteboard = null){
			super(type, true, false);
			_session = session;
			_location = location;
		}
		
		//------------------------------------
		// Getting Properties.
		//------------------------------------
		
		/**
		 * The dragging session related to the event.
		 */
		public function get resource():UIPasteboard{
			return _resource;
		}
		
		/**
		 * The dragging session related to the event.
		 */
		public function get session():UIDragging{
			return _session;
		}
		
		/**
		 * Determines the location of the event relative to the current target.
		 */		
		public function get location():Point{
			return currentTarget is InteractiveObject ? InteractiveObject(currentTarget).globalToLocal(_location) : null;
		}
		
		public function acceptDrop():void{
			if(type != UIDragEvent.DRAG_DROP){
				return;
			}
			this.preventDefault();
			this.stopImmediatePropagation();
		}
		
		//------------------------------------
		// overrides.
		//------------------------------------
		
		/**
		 * @private
		 */
		override public function clone():Event{
			return new UIDragEvent(type,_session,_location);
		}
		
	}
}