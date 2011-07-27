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
		
		/*
		 * TODO:
		 * - implement stage like behavior to this class, so the window class manages focus.
		 * - implement the window as the "first responder" when active (key) so that the controllers can listent to events on the window instance instead of the stage(removing bad habits).
		 * - provide a way to manage peer windows.
		 * - automaticly resize the window instances to stage when active (less boilerplate code).
		 * 
		 */
		
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
		// Focus Management.
		//------------------------------------
		
		
	}
}