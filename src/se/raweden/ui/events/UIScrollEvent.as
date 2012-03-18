package se.raweden.ui.events
{
	import flash.events.Event;
	
	/**
	 * Description 
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIScrollEvent extends Event{
		
		public static const SCROLL:String = "uiScroll";
		
		private var _deltaX:Number;
		private var _deltaY:Number;
		
		public function UIScrollEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,deltaX:Number = 0,deltaY:Number = 0){
			super(type, bubbles, cancelable);
			_deltaX = deltaX;
			_deltaY = deltaY;
		}
		
		public function get deltaX():Number{
			return _deltaX;
		}
		
		public function get deltaY():Number{
			return _deltaY;	
		}
	}
}