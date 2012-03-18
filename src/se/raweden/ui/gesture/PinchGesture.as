package se.raweden.ui.gesture
{
	import flash.display.InteractiveObject;

	public class PinchGesture extends Gesture{
		
		public function PinchGesture(target:InteractiveObject){
			super(target);
		}
		
		public static function add(target:InteractiveObject):PinchGesture{
			return new PinchGesture(target);
		}
		
	}
}