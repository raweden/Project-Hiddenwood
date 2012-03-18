package se.raweden.ui.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIEvent extends Event{
		
		public static const DISPOSE:String = "dispose";
		
		public function UIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
	}
}