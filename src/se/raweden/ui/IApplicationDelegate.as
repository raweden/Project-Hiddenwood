//
//	UIApplicationController.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-08-05
//	Copyright 2011 Jesper Svensson. All rights reserved.
//

package se.raweden.ui
{
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import se.raweden.ui.desktop.UIPasteboard;

	/**
	 * The <code>IApplicationDelegate</code> is the abstract inferface that your application controller
	 * must implmenet to be a delegate for UIApplication, your implementation for example extend the 
	 * <code>UIViewController</code> and respond to application changes.
	 * 
	 * @copyright Copyright 2011 Raweden. All rights reserved.
	 * @author Raweden
	 */
	public interface IApplicationDelegate extends IEventDispatcher{
		
		//
		// TODO: use a abstract interface for arguments in the open() method.
		//
		
		//------------------------------------
		// Responding to Application State Change.
		//------------------------------------
		
		/**
		 * 
		 */
		function didLauch(options:Object):void;
		
		/**
		 * 
		 */
		function onActivate():void;
		
		/**
		 * 
		 */
		function onDeativate():void;
		
		/**
		 * 
		 */
		function onEnterBackground():void;

		/**
		 * 
		 */
		function onWillUnload():void;
		
		//------------------------------------
		// Opening Resources.
		//------------------------------------
		
		/**
		 * 
		 */
		function open(pasteboard:UIPasteboard):Boolean;

		
	}
}