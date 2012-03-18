package se.raweden.ui
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import se.raweden.desktop.UIPasteboard;
	import se.raweden.ui.view.UIWindow;
	
	/**
	 * The <code>UIApplication</code> provides a central point to manage and control a application.
	 *
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIApplication extends EventDispatcher{
		
		private static var _sharedApplication:UIApplication;
		
		/**
		 * Returns the singleton instance of the running application.
		 * If it doesn't exists, it will be created, and then returned.
		 *
		 * @return the application singleton.
		 */
		public static function get sharedApplication():UIApplication
		{
			if (!_sharedApplication){
				_sharedApplication = new UIApplication();
			}
			return _sharedApplication;
		}
		
		//------------------------------------
		// Instance Implemenation.
		//------------------------------------
		
		// Instance impl.
		private var _delegate:IApplicationDelegate;
		private var loaderInfo:LoaderInfo;
		private var _keyWindow:UIWindow;
		private var _windows:Array;
		
		/**
		 * Constructor - Never call the constructor your self. use <code>UIApplication.sharedApplication</code> instead.
		 */
		public function UIApplication()
		{
			_windows = new Array();
		}
				
		//------------------------------------
		// Setting and Getting Deligate.
		//------------------------------------
		
		/**
		 * The delegate for this application. The delegate will receive various notifications
		 * caused by user interaction during the application's life time. The delegate can choose
		 * to react to these events. The <code>UIApplication</code> can only have one delegate at a time.
		 *
		 * @default <code>null</code>
		 */
		public final function set delegate(value:IApplicationDelegate):void
		{
			_delegate = value;
		}
		
		// returs the current delegate object.
		public final function get delegate():IApplicationDelegate
		{
			return _delegate;
		}
				
		//------------------------------------
		// Open Resources.
		//------------------------------------
		
		/**
		 * Opens a resource which the application is to handle.
		 *
		 * @param	pasteboard
		 * @return A <code>Boolean</code> value that determine whether the application successfully could open the resource.
		 */
		public function open(resource:UIPasteboard):Boolean{
			return _delegate ? _delegate.open(resource) : false;
		}
		
		/**
		 * Determine whether the application can handle one or more formats of the pasteboard resource.
		 *
		 * @param  pasteboard
		 * @return A <code>Boolean</code> value that determine whether the application can handle the pasteboard resource.
		 */
		public function canOpen(resource:UIPasteboard):Boolean{
			var delegate:Object = _delegate;
			return delegate && delegate.canOpen is Function ? delegate.canOpen(resource) : false;
		}
		
		//------------------------------------
		// Terminating the Application.
		//------------------------------------
		
		/**
		 *
		 */
		public function unload():void{
			try{
				delegate.dispatchEvent(new Event(Event.UNLOAD));
			}catch (error:*){
				trace("error triggerd when unloading the application", error);
			}
			log("UIApplication will terminate loaderInfo is " + loaderInfo);
			// unloading the application.
			if (loaderInfo){
				loaderInfo.loader.unloadAndStop();
			}
		}
	
	}
}