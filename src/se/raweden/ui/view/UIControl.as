package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	/**
	 * A <code>UIControl</code> base class
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIControl extends UIView{
			
		private var _enabled:Boolean = true;
		private var _highlighted:Boolean;
		private var _selected:Boolean;
		
		/**
		 * Constructor.
		 */
		public function UIControl(parent:DisplayObjectContainer = null, frame:Rectangle = null){
			super(parent, frame);
		}
		
		/**
		 * Indicates the current state of the <code>UIControl/code> instance.
		 * 
		 * @default <code>UIControlState.Normal</code>
		 */		
		public function get state():int{
			var state:int = UIControlState.Normal;
			if (_highlighted)	state |= UIControlState.Highlighted;
			if (!_enabled)		state |= UIControlState.Disabled;
			if (_selected)		state |= UIControlState.Selected;
			return state;
		}
		
		/**
		 * A Boolean value that determine whether this <code>UIControl</code> instance is enabled.
		 * 
		 * @default <code>true</code>
		 */
		public function set enabled(value:Boolean):void{
			if(value != _enabled){
				mouseEnabled = mouseChildren = value;
				tabEnabled = value;
				alpha = value ? 1.0 : 0.75;	
				_enabled = value;
				stateDidChange();
			}
		}
		// returns the current value of the enabled property.
		public function get enabled():Boolean{
			return _enabled;
		}
		
		/**
		 * A Boolean value that determien whether this <code>UIControl/code> instance is selected.
		 */
		public function set selected(value:Boolean):void{
			if(value != _selected){
				_selected = value;
				stateDidChange();
			}
		}
		// returns the current value of the selected property.
		public function get selected():Boolean{
			return _selected;
		}

		/**
		 * A Boolean value that determine whether this <code>UIControl/code> instance is highlighted.
		 */
		public function set highlighted(value:Boolean):void{
			if(value != _highlighted){
				_highlighted = value;	
				stateDidChange();
			}
		}
		// returns the current value of the hightlighted property.
		public function get highlighted():Boolean{
			return _highlighted;
		}
		
		/**
		 * This method is invoked internaly when the state changes.
		 */
		private function stateDidChange():void{
			this.needsDraw();
			this.needsLayout();
		}

		
	}
}