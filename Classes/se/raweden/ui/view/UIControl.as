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
	
	public class UIControl extends UIView{
		
		private var m_enabled:Boolean = true;
		
		public function UIControl(parent:DisplayObjectContainer=null, bounds:Rectangle=null){
			super(parent, bounds);
		}
		
		/**
		 * 
		 */		
		public function get state():String{
			return null;
		}
		
		/**
		 * Specifies if the <code>UIControl/code> instance is enabled.
		 * <p>The default value is <code>true</code></p>
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
		
		public function get selected():Boolean{
			return false;
		}
		
	}
}