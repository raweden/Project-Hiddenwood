package se.raweden.ui.utils
{
	import flash.events.Event;
	
	import se.raweden.desktop.UIPasteboard;

	/**
	 * The <code>ILocalController</code> is a abstract interface expodes to other application
	 * via the <code>UIWorkspace</code> for application management.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface ILocalController{
		
		/**
		 * A Human-Readable <code>String</code> representing the display name for the application or plugin.
		 */
		function get caption():String;
		
		/**
		 * A <code>Boolean</code> value that determine whether the plugin is currently running.
		 */
		function get isRunning():Boolean;
			
		/**
		 * A <code>String</code> that specifies the application's or plugin's uniqe identifier.
		 */
		function get identifier():String;
		
		/**
		 * 
		 */
		function get types():Array;
			
		/**
		 * Invokes the <code>open()</code> method on the principal class for the application or plugin.
		 */
		function open(resource:UIPasteboard):void;
		
		/**
		 * Determine whether the plugin can interact with one or more types in the resource.
		 * 
		 * @return A <code>Boolean</code> value that determine whether the plugin can interact
		 * with the resource.
		 */
		function canOpen(resource:UIPasteboard):Boolean;
		
		/**
		 * Dispatches a <code>Event</code> on the application's main <code>EventDispatcher</code>;
		 * which offen referes to the shared <code>UIApplication</code> instance or the <code>root</code> of the
		 * application.
		 */
		function dispatch(event:Event):Boolean;
			
	}
} 