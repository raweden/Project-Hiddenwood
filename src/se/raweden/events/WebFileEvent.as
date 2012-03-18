package se.raweden.events
{
	import flash.events.Event;
	
	/**
	 * The <code>WebFileEvent</code> 
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class WebFileEvent extends Event{
		
		/**
		 * 
		 */
		public static const CREATED:String = "created";
		
		/**
		 * 
		 */
		public static const LISTING:String = "listing";
		
		/**
		 * 
		 */
		public static const META_DATA:String = "metaData";
		
		/**
		 * 
		 */
		public static const MOVED:String = "moved";
		
		/**
		 * 
		 */
		public static const REMOVED:String = "removed";
		
		/**
		 * 
		 */
		public static const UPDATED:String = "updated";
		
		/**
		 * 
		 */
		public function WebFileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type)
		}
		
		
	}
}