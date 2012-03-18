package se.raweden.ui.gesture
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;

	public class Gesture{
		
		private var _enabled:Boolean = true;
		private var _target:InteractiveObject
		
		public function Gesture(target:InteractiveObject){
			_target = target;
		}
		
		/**
		 * 
		 * 
		 */		
		public function set enabled(value:Boolean):void{
			_enabled = value;
		}
		
		public function get enabled():Boolean{
			return _enabled;
		}

		/**
		 * 
		 * 
		 */		
		public function get target():InteractiveObject{
			return _target;
		}

		
	}
}