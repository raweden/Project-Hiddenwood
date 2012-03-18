package se.raweden.ui.vo
{
	import flash.display.BitmapData;

	/**
	 * A <code>UITabBarItem</code> is a value object for the items in a UITabBar view.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UITabBarItem extends UIBarItem{
		
		private var _badgeValue:int;
		
		public function UITabBarItem(image:BitmapData,tag:int){
			super();
			// setting properties.
			super.image = image;
			super.tag = tag;
		}
		
		public function set badgeValue(value:int):void{
			_badgeValue = value;
		}
		//
		public function get badgeValue():int{
			return _badgeValue;
		}

	}
}