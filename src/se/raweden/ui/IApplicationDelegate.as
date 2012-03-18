package se.raweden.ui
{
	import flash.events.IEventDispatcher;
	
	import se.raweden.desktop.UIPasteboard;

	/**
	 * The <code>IApplicationDelegate</code> is the abstract inferface that your application controller
	 * must implmenet to be a delegate for UIApplication, with this implementation you can get your 
	 * <code>UIViewController</code> to respond on application changes.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public interface IApplicationDelegate extends IEventDispatcher{
		
		/**
		 * 
		 */
		function get title():String;

		/**
		 * Implementation of this method handels the pasteboard resource sent
		 * to the <code>UIApplication.open()</code> method.
		 * 
		 * <p>This method is invoked by the master application, when the user
		 * chose to use the application/module to edit a item.</p>
		 * 
		 * @param resource
		 * @return A Boolean value determine whether the application or module could read the pasteboard with success.
		 */
		function open(resource:UIPasteboard):Boolean;
		
	}
}