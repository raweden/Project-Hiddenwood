
package se.raweden.ui
{
	import flash.geom.Rectangle;
	
	import se.raweden.ui.view.UIView;

	/**
	 * The singleton <code>UIMenuController</code> instance presents a menu interface.
	 * 
	 * Copyright 2011, Raweden. All Rights Reserved.
	 * 
	 * @author Raweden
	 */
	public class UIMenuController{
		
		//	UIMenuController.as
		//	Core UI Addition Framework
		//
		//	Created by Raweden on 2011-07-25
		//	Copyright 2011 Raweden. Some rights reserved.

		
		//
		// TODO: implement render form the UISegmentedControl.
		// TODO: add support for icon as well as labels.
		//
		
		private static var _instance:UIMenuController;
		
		/**
		 * Returns the singleton instance of the <code>UIMenuController</code>.
		 */
		public function get sharedMenuController():UIMenuController{
			if(!_instance){
				_instance = new UIMenuController();
			}
			return _instance;
		}
		
		private var _menuItems:Array;
		
		public function UIMenuController(){
			
		}
		
		//------------------------------------
		// Showing and Hiding the Menu
		//------------------------------------
		
		/**
		 * 
		 * @param rect
		 * @param view
		 */
		public final function show(rect:Rectangle,view:UIView):void{
			
		}
		
		//------------------------------------
		// Updating the Menu.
		//------------------------------------
		
		/**
		 * 
		 */
		public final function update():void{
			var len:int = _menuItems.length;
			var item:UIMenuItem;
			for(var i:int = 0;i<len;i++){
				item = _menuItems[i];
			}
		}

		//------------------------------------
		// Cutsomizing Menu Items
		//------------------------------------
		
		/**
		 * 
		 */
		public function set menuItems(value:Array):void{
			_menuItems = value.filter(filterItems);
			this.update();
			// 
			function filterItems(item:*, index:int, array:Array):Boolean{
				return item is UIMenuItem;
			}
		}
		//
		public function get menuItems():Array{
			return _menuItems.concat();
		}
		
		
	}
}