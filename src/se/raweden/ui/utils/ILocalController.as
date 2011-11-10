//
//	ILocalController.as
//	Core UI Framework
//
//	Created by Raweden on 2011-07-31
//	Copyright 2011 Raweden. Some rights reserved.
//

package se.raweden.ui.utils
{
	import flash.events.Event;
	
	import se.raweden.ui.desktop.UIPasteboard;

	/**
	 * The <code>ILocalController</code> is a abstract interface expodes to other application via the <code>UIWorspace</code> for application management.
	 * 
	 * @copyright Copyright 2011 Raweden. All rights reserved.
	 * @author Raweden
	 */
	public interface ILocalController{
		
		/**
		 * A Human-Readable <code>String</code> representing the display name for the application or plugin.
		 */
		function get caption():String;
		
		/**
		 * A <code>Boolean</code> value determine whether the application or plugin is currently running.
		 */
		function get isRunning():Boolean;
			
		/**
		 * A <code>String</code> that specifies the application's or plugin's uniqe identifier.
		 */
		function get identifier():String;
			
		/**
		 * Invokes the open method on the principal class for the application or plugin.
		 */
		function open(pasteboard:UIPasteboard):void;
		
		/**
		 * validates the the application or plugin can use the pasteboard.
		 */
		function canOpen(pasteboard:UIPasteboard):Boolean;
		
		/**
		 * Dispatches a <code>Event</code> on the application's main <code>EventDispatcher</code>;
		 * which offen referes to the shared <code>UIApplication</code> instance or the <code>root</code> of the
		 * application.
		 */
		function dispatch(event:Event):Boolean;
			
	}
} 