//
//	UIListEvent.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-04-30
//	Copyright 2011 Jesper Svensson. All rights reserved.
//

package se.raweden.ui.events
{
	import flash.events.Event;
	
	/**
	 * Event class special for List based classes.
	 */
	public class UIListEvent extends Event{
		
		public static const ITEM_CLICK:String = "itemClick";
		public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";
		
		private var m_index:int;
		
		public function UIListEvent(type:String,index:int){
			m_index = index;
			super(type,false,false);
		}
		
		public function get index():int{
			return(m_index);
		}
		
		override public function clone():Event{
			return new UIListEvent(this.type,this.index);
		}
		
	}
}