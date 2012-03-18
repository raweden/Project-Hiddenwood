package se.raweden.ui.gesture
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	
	/**
	 * 
	 * 
	 * @author raweden
	 */	
	public class SwipeGesture extends Gesture{
		
		
		public function SwipeGesture(target:InteractiveObject){
			super(target);
		}
		
		public static function add(target:InteractiveObject):SwipeGesture{
			return new SwipeGesture(target);
		}
		
		
	}
}