package se.raweden.ui
{
	

	/**
	 * A <code>UIMenuItem</code> object represents a custom item in the editing menu managed by the <code>UIMenuController</code>.
	 * 
	 * Copyright 2011, Raweden. All Rights Reserved.
	 * 
	 * @author Raweden
	 */
	public class UIMenuItem{
		
		private var _title:String;
		private var _callback:Function;
		
		/**
		 * 
		 * @param title The title of the menu item.
		 * @param callback The function that will be called when the user interacts with menu item.
		 */
		public function UIMenuItem(title:String,callback:Function){
			_title = title;
			_callback = callback;
		}
		
		/**
		 * The title of the menu item.
		 */
		public function set title(value:String):void{
			_title = value;
		}
		// returns the current title.
		public function get title():String{
			return _title;
		}
		
		/**
		 * A Callback Method that will be invoked for handling the menu command.
		 */
		public function set callback(value:Function):void{
			_callback = value;
		}
		// returns the current callback.
		public function get callback():Function{
			return _callback;
		}

	}
}