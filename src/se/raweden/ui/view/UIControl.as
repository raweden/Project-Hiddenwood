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
		
		core var m_enabled:Boolean = true;
		core var m_state:int = -1;
		
		public function UIControl(parent:DisplayObjectContainer = null, frame:Rectangle = null){
			super(parent, frame);
		}
		
		/**
		 * Indicates the current state of the <code>UIControl/code> instance.
		 * 
		 * @default <code>-1</code>
		 */		
		public function get state():int{
			return m_state;
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
			}
		}
		// indicates if the Controll is currently enabled.
		public function get enabled():Boolean{
			return m_enabled;
		}
		
		/**
		 * Indicates if the <code>UIControl/code> instance is selected.
		 */
		public function get selected():Boolean{
			return false;
		}
		
	}
}