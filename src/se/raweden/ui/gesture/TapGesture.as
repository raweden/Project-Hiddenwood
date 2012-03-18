package se.raweden.ui.gesture
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	
	
	public class TapGesture extends Gesture{
	
		private var _conter:int;
		
		public function TapGesture(target:InteractiveObject){
			super(target);
		}
	
		public static function add(target:InteractiveObject):TapGesture{
			return new TapGesture(target);
		}
		
	}
}