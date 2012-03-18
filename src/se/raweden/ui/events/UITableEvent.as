package se.raweden.ui.events
{
	import flash.events.Event;
	
	/**
	 * Event class special for List based classes.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UITableEvent extends Event{
		
		public static const SELECT_INDEX:String = "selectIndex";
		
		public static const DESELECT_INDEX:String = "seslectIndex";
		
		public static const ITEM_CLICK:String = "itemClick";
		public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";
		
		private var _index:int;
		
		public function UITableEvent(type:String,index:int){
			_index = index;
			super(type,false,false);
		}
		
		/**
		 * Indicates the index on which the event occur.
		 */
		public function get index():int{
			return(_index);
		}
		
		override public function clone():Event{
			return new UITableEvent(this.type,this.index);
		}
		
	}
}