//
//	UIApplicationController.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-07
//	Copyright 2011 Jesper Svensson. All rights reserved.
//

package se.raweden.ui
{
	import flash.net.URLRequest;

	/**
	 * The <code>UIApplicatioController</code> is the abstract interface for <code>UIViewController</code> to implement the common fundational concepts of a application.
	 * 
	 * @author Raweden.
	 */
	public interface UIApplicationController{
		
		// Responding to Application State Change.
		
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
		function onExit():void;
		
		// Opening Resources.
		
		/**
		 * 
		 */
		function open(arguments:Object):Boolean;
		
		/**
		 * Todo:
		 * 1. create a abstract interface for the arguments to be sent to open method.
		 */
		
	}
}