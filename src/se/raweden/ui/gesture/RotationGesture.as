package se.raweden.ui.gesture
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;

	public class RotationGesture extends Gesture{
		
		public function RotationGesture(target:InteractiveObject){
			super(target);
		}
		
		
		
		public static function add(target:InteractiveObject):RotationGesture{
			return new RotationGesture(target);
		}
		
	}
}