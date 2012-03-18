package se.raweden.ui.vo
{
	import flash.display.BitmapData;

	/**
	 * A <code>UIBarItem</code> object.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIBarItem{
		
		private var _enabed:Boolean;
		private var _image:BitmapData;
		private var _title:String;
		private var _tag:int;
		
		public function UIBarItem(){
		
		}
		
		/**
		 * 
		 */
		public function set enabed(value:Boolean):void{
			_enabed = value;
		}
		// indicates if the bar item is enabled.
		public function get enabed():Boolean{
			return _enabed;
		}

		/**
		 * 
		 */
		public function set image(value:BitmapData):void{
			_image = value;
		}
		// returns the image.
		public function get image():BitmapData{
			return _image;
		}

		/**
		 * 
		 */
		public function set title(value:String):void{
			_title = value;
		}
		// returns the title.
		public function get title():String{
			return _title;
		}

		/**
		 * 
		 */
		public function set tag(value:int):void{
			_tag = value;
		}
		// returns the tag.
		public function get tag():int{
			return _tag;
		}
	}
}