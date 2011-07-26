//
//	UIWindow.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-07
//	Copyright 2011 Jesper Svensson. All rights reserved.
//
package se.raweden.ui.view
{
	import flash.display.DisplayObject;
	
	import se.raweden.core.core;
	import se.raweden.ui.UIViewController;
	
	/**
	 * A <code>UIWindow</code> object represents the front-end view of each Application.
	 * 
	 * @author Raweden.
	 */
	public class UIWindow extends UIView{
		
		use namespace core;
		
		core var m_rootViewController:UIViewController;
		
		/**
		 * Constuctor
		 * @param rootViewController The UIViewController instance that will be asigned 
		 * as root controller for this window. 
		 */
		public function UIWindow(rootViewController:UIViewController){
			super();
		}
		
		//------------------------------------
		// Configuring the Window View.
		//------------------------------------
		
		/**
		 * 
		 */
		public function set rootViewController(value:UIViewController):void{
			m_rootViewController = value;
			// clear the view hieraki here.
		}
		
		public function get rootViewController():UIViewController{
			return m_rootViewController;
		}
		
		//------------------------------------
		// Overriding the Flash DisplayList heiraky.
		//------------------------------------
		
		/*

		public override function addChild(child:DisplayObject):DisplayObject{
			// override default implementation to notify UIView instances of the change.
			var view:UIView = child as UIView;
			if(view)
				view.m_window = this;
			// returning the default implementation.
			return super.addChild(child);
		}
		

		public override function addChildAt(child:DisplayObject, index:int):DisplayObject{
			// override default implementation to notify UIView instances of the change.
			var view:UIView = child as UIView;
			if(view)
				view.m_window = this;
			// returning the default implementation.
			return super.addChildAt(child,index);
		}
		

		public override function removeChild(child:DisplayObject):DisplayObject{
			// override default implementation to notify UIView instances of the change.
			var view:UIView = child as UIView;
			if(view)
				view.m_window = null;
			// returning the default implementation.
			return super.removeChild(child);
		}
		

		public override function removeChildAt(index:int):DisplayObject{
			// override default implementation to notify UIView instances of the change.
			var child:DisplayObject = super.removeChildAt(index)
			var view:UIView = child as UIView;
			if(view)
				view.m_window = null;
			// returning the default implementation.
			return child;
		}
		*/
		
	}
}