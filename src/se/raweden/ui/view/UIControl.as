//
//	UIControl.as
//	Core UI Framework
//
//	Created by Raweden on 2011-07-01
//	Copyright 2011 Raweden. Some rights reserved.
//

package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import se.raweden.core.core;
	
	/**
	 * A <code>UIControl</code> base class
	 * 
	 * @copyright Copyright 2011 Raweden. All rights reserved.
	 * @author Raweden
	 */
	public class UIControl extends UIView{
		
		use namespace core;
		
		//
		// TODO: write better documentation for this class.
		//
		
		private var m_enabled:Boolean = true;
		private var m_highlighted:Boolean;
		private var m_selected:Boolean;
		
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
			if (m_highlighted)	state |= UIControlState.Highlighted;
			if (!m_enabled)		state |= UIControlState.Disabled;
			if (m_selected)		state |= UIControlState.Selected;
			return state;
		}
		
		/**
		 * A Boolean value that determine whether this <code>UIControl</code> instance is enabled.
		 * 
		 * @default <code>true</code>
		 */
		public function set enabled(value:Boolean):void{
			if(value != m_enabled){
				mouseEnabled = mouseChildren = value;
				tabEnabled = value;
				alpha = value ? 1.0 : 0.75;	
				m_enabled = value;
				stateDidChange();
			}
		}
		// indicates if the Controll is currently enabled.
		public function get enabled():Boolean{
			return m_enabled;
		}
		
		/**
		 * A Boolean value that determien whether this <code>UIControl/code> instance is selected.
		 */
		public function set selected(value:Boolean):void{
			if(value != m_selected){
				m_selected = value;
				stateDidChange();
			}
		}
		//
		public function get selected():Boolean{
			return m_selected;
		}

		/**
		 * A Boolean value that determine whether this <code>UIControl/code> instance is highlighted.
		 */
		public function set highlighted(value:Boolean):void{
			if(value != m_highlighted){
				m_highlighted = value;	
				stateDidChange();
			}
		}
		// returns of the control is currently highighted.
		public function get highlighted():Boolean{
			return m_highlighted;
		}
		
		/**
		 * This method is invoked internaly when the state changes.
		 */
		private function stateDidChange():void{
			this.setNeedsDisplay();
			this.setNeedsLayout();
		}

		
	}
}