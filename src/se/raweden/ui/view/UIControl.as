//
//	UIControl.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-07
//	Copyright 2011 Jesper Svensson. All rights reserved.
//

package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import se.raweden.core.core;
	
	/**
	 * A <code>UIControl</code> base class
	 * 
	 * @author Raweden
	 */
	public class UIControl extends UIView{
		
		use namespace core;
		
		private var m_enabled:Boolean = true;
		private var m_highlighted:Boolean;
		private var m_selected:Boolean;
		
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
		 * Specifies if the <code>UIControl/code> instance is enabled.
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
		 * Indicates if the <code>UIControl/code> instance is selected.
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
		 * 
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
		
		private function stateDidChange():void{
			this.setNeedsDisplay();
			this.setNeedsLayout();
		}

		
	}
}