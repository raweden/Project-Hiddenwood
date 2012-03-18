package se.raweden.ui
{
	import se.raweden.ui.view.UITabBar;
	import se.raweden.ui.view.UIView;

	/**
	 * A <code>UITabBarController</code>
	 *
	 * Copyright 2011, Raweden. All Rights Reserved.
	 *
	 * @author Raweden
	 */
	public class UITabBarController extends UIViewController{
		
		// Related Views.
		private var _tabView:UITabView;
		private var _tabBar:UITabBar;
		
		// Related Controllers.
		private var _viewControllers:Array;
		private var _selectedViewController:UIViewController;
		
		/**
		 * Constructor.
		 */
		public function UITabBarController(){
			super();
		}
		
		//------------------------------------
		// Getting Related Views.
		//------------------------------------
		
		/**
		 * 
		 */
		public function get tabBar():UITabBar{
			return _tabView ? _tabView.tabBar : null;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set view(value:UIView):void{
			throw new Error("the view property is read-only");
		}
		// creates if need and returns the view.
		override public function get view():UIView{
			if(!_tabView){
				_tabView = new UITabView();
			}
			return _tabView;
		}
		
		//------------------------------------
		// Managing the View Controllers.
		//------------------------------------
		
		/**
		 * 
		 */
		public function get viewControllers():Array{
			return _viewControllers;
		}
				
		/**
		 * 
		 */
		public function get moreNavigationController():UIViewController{
			return null;
		}
		
		//------------------------------------
		// Managing the selected Tab
		//------------------------------------
		
		/**
		 * 
		 */
		public function get selectedViewController():UIViewController{
			return _selectedViewController;
		}
		
		/**
		 * 
		 */
		public function set selectedIndex(value:int):void{
			
		}
		// returns the current selected index.
		public function get selectedIndex():int{
			return _viewControllers.indexOf(_selectedViewController);
		}
		
		
	}
}
import flash.geom.Rectangle;

import se.raweden.ui.view.UITabBar;
import se.raweden.ui.view.UIView;

/**
 * A <code>UITabView</code>
 *
 * Copyright 2011, Raweden. All Rights Reserved.
 *
 * @author Raweden
 */
class UITabView extends UIView{
	
	private var _tabBar:UITabBar;
	
	public function UITabView(){
		
	}
	
	public function get tabBar():UITabBar{
		if(!_tabBar){
			_tabBar = new UITabBar(this);
			this.needsLayout();
		}
		return _tabBar;
	}
	
	//------------------------------------
	// Updating Content Displayed.
	//------------------------------------
	
	/**
	 * @inheritDoc
	 */
	override protected function layout(rect:Rectangle):void{
		if(_tabBar){
			_tabBar.width = rect.width;
		}
	}
	
	/**
	 * @inheritDoc
	 */
	override protected function draw(rect:Rectangle):void{
		
	}

}