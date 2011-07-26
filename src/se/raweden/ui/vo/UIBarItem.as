package se.raweden.ui.vo
{
	import flash.display.BitmapData;

	public class UIBarItem{
		
		private var m_enabed:Boolean;
		private var m_image:BitmapData;
		private var m_title:String;
		private var m_tag:int;
		
		public function UIBarItem(){
		
		}
		
		public function set enabed(value:Boolean):void{
			m_enabed = value;
		}
		// indicates if the bar item is enabled.
		public function get enabed():Boolean{
			return m_enabed;
		}

		public function set image(value:BitmapData):void{
			m_image = value;
		}
		// returns the image.
		public function get image():BitmapData{
			return m_image;
		}

		public function set title(value:String):void{
			m_title = value;
		}
		// returns the title.
		public function get title():String{
			return m_title;
		}

		public function set tag(value:int):void{
			m_tag = value;
		}
		// returns the tag.
		public function get tag():int{
			return m_tag;
		}
	}
}