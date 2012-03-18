package se.raweden.ui.gesture
{
	import flash.display.InteractiveObject;

	public class PanGesture extends Gesture{
		
		public function PanGesture(target:InteractiveObject){
			super(target);
		}
		
		public static function add(target:InteractiveObject):PanGesture{
			return new PanGesture(target);
		}
		
	}
}