package se.raweden.ui.view
{
	import flash.display.InteractiveObject;
	import flash.events.FocusEvent;
	
	import se.raweden.ui.UIApplication;
	import se.raweden.ui.UIViewController;
	
	/**
	 * A <code>UIWindow</code> manages and coordinate the window of an application displayed on the screen.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * @author Raweden
	 */
	public class UIWindow extends UIView{
		
		//
		// TODO: implement stage like behavior to this class, so the window class manages focus.
		// TODO: implement the window as the "first responder" when active (key) so that the controllers can listent to events on the window instance instead of the stage(removing bad habits).
		// TODO: provide a way to manage peer windows.
		// TODO: automaticly resize the window instances to stage when active (less boilerplate code).
		//
		
		private var m_rootViewController:UIViewController;
		private var m_focus:InteractiveObject;
		
		/**
		 * Constuctor
		 * 
		 * @param rootViewController The UIViewController instance that will be asigned 
		 * as root controller for this window. 
		 */
		public function UIWindow(rootViewController:UIViewController = null){
			super();
			m_rootViewController = rootViewController;
			init();
			// TODO: remove this line of code.
			if(this == this.root){
				trace("window is root");
			}
		}
		
		private function init():void{
			this.addEventListener(FocusEvent.FOCUS_IN,onFocusEvent);
		}
		
		//------------------------------------
		// Getting and Setting Attributes.
		//------------------------------------
		
		/**
		 * Determine the view which have the current focus in this window.
		 */
		public function set focus(value:InteractiveObject):void{
			m_focus = value;
		}
		//
		public function get focus():InteractiveObject{
			return m_focus;
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
		// Responding to User Interaction.
		//------------------------------------
		
		// repsponds to user focus change.
		private function onFocusEvent(e:FocusEvent):void{
			if(e.type == FocusEvent.FOCUS_IN){
				m_focus = e.target as InteractiveObject;
			}
		}
		
		//------------------------------------
		// Making Window Key.
		//------------------------------------
		
		/**
		 * A Boolean value that determine whether this <code>UIWindow</code> instance is the key window.
		 */
		public function get isKeyWindow():Boolean{
			return UIApplication.sharedApplication.keyWindow == this;
		}
		
		/**
		 * Makes this <code>UIWindow</code> instance the key window.
		 */
		public function makeKeyWindow():void{
			UIApplication.sharedApplication.keyWindow = this;
			
		}
		
		//------------------------------------
		// Deconstruction
		//------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void{
			this.removeEventListener(FocusEvent.FOCUS_IN,onFocusEvent);
			super.dispose();
		}
		
		
	}
}