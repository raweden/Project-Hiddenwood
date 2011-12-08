package se.raweden.ui
{
	import flash.events.IEventDispatcher;
	
	import se.raweden.ui.desktop.UIPasteboard;

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
		
		//------------------------------------
		// Responding to Application State Change.
		//------------------------------------
		
		/**
		 * 
		 * @param	options
		 */
		function didLauch(options:Object):void;
		
		/**
		 * This method is invoked when the Flash Player loses focus from the underlying OS.
		 */
		function onActivate():void;
		
		/**
		 * This method is invoked when the Flash Player gains focus from the underlying OS.
		 */
		function onDeativate():void;
		
		/**
		 * This method is invoked when the Application is entering the background and are no
		 * longer on the displaylist.
		 */
		function onEnterBackground():void;

		/**
		 * This method is invoked when the Application is about to be unloaded.
		 */
		function onWillUnload():void;
		
		//------------------------------------
		// Opening Resources.
		//------------------------------------

		/**
		 * Implementation of this method handels the pasteboard resource sent
		 * to the <code>UIApplication.open()</code> method.
		 * 
		 * <p>This method is invoked by the master application, when the user
		 * chose to use the application/module to edit a item.</p>
		 * 
		 * @param	pasteboard 
		 * @return A Boolean value determine whether the application or module could read the pasteboard with success.
		 */
		function open(pasteboard:UIPasteboard):Boolean;
		
		/**
		 * Determine whether one or more types in the pasteboard resource can be handled by the application.
		 * 
		 * Implementation of this method determine whether the the pasteboard
		 * resource sent to the <code>UIApplication.canOpen()</code> method.
		 * 
		 * @param	pasteboard
		 * @return A Boolean value determine whether the application or module can open any of the resources in the pasteboard.
		 */
		function canOpen(pasteboard:UIPasteboard):Boolean;
		
	}
}