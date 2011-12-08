package se.raweden.ui
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import se.raweden.ui.desktop.UIPasteboard;
	import se.raweden.ui.view.UIWindow;
	
	/**
	 * The <code>UIApplication</code> provides a central point to manage and control a application.
	 *
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIApplication implements IEventDispatcher{
		
		//
		// TODO: rather implement so that the UIApplication mirrors the root or sharedEvents as dispatcher (this is a more common approach).
		//
		
		//------------------------------------
		// Class Implemenation.
		//------------------------------------
		
		private static var m_sharedApplication:UIApplication;
		
		/**
		 * Returns the singleton instance of the running application.
		 * If it doesn't exists, it will be created, and then returned.
		 *
		 * @return the application singleton.
		 */
		public static function get sharedApplication():UIApplication
		{
			if (!m_sharedApplication)
			{
				m_sharedApplication = new UIApplication();
			}
			return m_sharedApplication;
		}
		
		//------------------------------------
		// Instance Implemenation.
		//------------------------------------
		
		// Instance impl.
		private var m_delegate:IApplicationDelegate;
		private var m_listerns:Array = [];
		private var loaderInfo:LoaderInfo;
		private var m_keyWindow:UIWindow;
		private var m_windows:Array;
		
		/**
		 * Constructor - Never call the constructor your self. use <code>UIApplication.sharedApplication</code> instead.
		 */
		public function UIApplication()
		{
			m_windows = new Array();
		}
		
		//------------------------------------
		// Responding to Applicaion events
		//------------------------------------
		
		// Invoked as the flash player gains OS focus.
		private final function onActivate(e:Event):void
		{
			if (m_delegate)
				m_delegate.onActivate();
		}
		
		// Invoked as the flash player loses OS focus.
		private final function onDeactivate(e:Event):void
		{
			if (m_delegate)
				m_delegate.onDeativate();
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
			if (m_delegate)
			{
				m_delegate.removeEventListener(Event.ACTIVATE, onActivate);
				m_delegate.removeEventListener(Event.DEACTIVATE, onDeactivate);
			}
			m_delegate = value;
			if (m_delegate)
			{
				m_delegate.addEventListener(Event.ACTIVATE, onActivate);
				m_delegate.addEventListener(Event.DEACTIVATE, onDeactivate);
			}
		}
		
		// returs the current delegate object.
		public final function get delegate():IApplicationDelegate
		{
			return m_delegate;
		}
		
		//------------------------------------
		// Getting Application Windows
		//------------------------------------
		
		/**
		 * The applications key window.
		 *
		 * @return The current UIWindow that most recently invoked the <code>makeKeyWindow()</code> method.
		 */
		public function set keyWindow(value:UIWindow):void
		{
			if (m_keyWindow)
			{
			}
			m_keyWindow = value;
			if (m_keyWindow)
			{
				if (!loaderInfo && value.root == value && value.loaderInfo)
				{
					loaderInfo = value.loaderInfo;
				}
			}
		}
		
		/**
		 *
		 */
		public function get keyWindow():UIWindow
		{
			return m_keyWindow;
		}
		
		/**
		 *
		 */
		public function get windows():Array
		{
			return m_windows;
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
		public function open(pasteboard:UIPasteboard):Boolean
		{
			return m_delegate ? m_delegate.open(pasteboard) : false;
		}
		
		/**
		 * Determine whether the application can handle one or more formats of the pasteboard resource.
		 *
		 * @param  pasteboard
		 * @return A <code>Boolean</code> value that determine whether the application can handle the pasteboard resource.
		 */
		public function canOpen(pasteboard:UIPasteboard):Boolean
		{
			return m_delegate ? m_delegate.canOpen(pasteboard) : false;
		}
		
		//------------------------------------
		// IEventDispatcher Implementation
		//------------------------------------
		
		/**
		 * @copy flash.events.IEventDispatcher#addEventListener()
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			if (m_delegate)
				m_delegate.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#dispatchEvent()
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			return m_delegate ? m_delegate.dispatchEvent(event) : false;
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#hasEventListener()
		 */
		public function hasEventListener(type:String):Boolean
		{
			return m_delegate ? m_delegate.hasEventListener(type) : false;
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#removeEventListener()
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			if (m_delegate)
				m_delegate.removeEventListener(type, listener, useCapture);
		
		}
		
		/**
		 * @copy flash.events.IEventDispatcher#willTrigger()
		 */
		public function willTrigger(type:String):Boolean
		{
			return m_delegate ? m_delegate.willTrigger(type) : false;
		}
		
		//------------------------------------
		// Terminating the Application.
		//------------------------------------
		
		/**
		 *
		 */
		public function unload():void
		{
			try
			{
				delegate.onWillUnload();
			}
			catch (error:*)
			{
				trace("error triggerd when unloading the application", error);
			}
			log("UIApplication will terminate loaderInfo is " + loaderInfo);
			// unloading the application.
			if (loaderInfo)
			{
				loaderInfo.loader.unloadAndStop();
			}
		}
	
	}
}