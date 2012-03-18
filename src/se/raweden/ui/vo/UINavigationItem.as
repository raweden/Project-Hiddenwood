package se.raweden.ui.vo
{
	
	/**
	 * A <code>UINavigationItem</code> object is a value object for a UIViewController in a UINavigationController.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UINavigationItem{
		
		private var _title:String;
		
		public function UINavigationItem(title:String){
			_title = title;
		}
		
		/**
		 * 
		 */
		public function set title(value:String):void{
			// binding should be used here.
			_title = value;
		}
		
		public function get title():String{
			return _title;
		}
		
	}
}