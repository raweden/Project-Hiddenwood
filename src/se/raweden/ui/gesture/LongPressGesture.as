package se.raweden.ui.gesture
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	
	/**
	 * 
	 */
	public class LongPressGesture extends Gesture{
		
		public var duration:Number;
		public var threshold:Number;
		
		
		public function LongPressGesture(target:InteractiveObject){
			super(target);
			duration = 500;
			threshold = 10;
		}
		
		public static function add(target:InteractiveObject):LongPressGesture{
			return new LongPressGesture(target);
		}
		
	}
}

/*
minimumPressDuration  property
numberOfTouchesRequired  property
numberOfTapsRequired  property
allowableMovement  property

*/