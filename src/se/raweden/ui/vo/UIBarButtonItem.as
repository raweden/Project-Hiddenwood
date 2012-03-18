package se.raweden.ui.vo
{
	import se.raweden.ui.view.UIView;

	/**
	 * A <code>UIBarButtonItem</code> object.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIBarButtonItem extends UIBarItem{
		
		private var _callback:Function;
		private var _width:int;
		private var _customView:UIView;
		
		public function UIBarButtonItem(callback:Function){
			super();
			_callback = callback;
		}
		
		//Getting and Setting Properties

		public function set callback(value:Function):void{
			_callback = value;
		}
		// returns the callback.
		public function get callback():Function{
			return _callback;
		}
		
				
		public function set width(value:int):void{
			_width = value;
		}
		// returns the width.
		public function get width():int{
			return _width;
		}
		
		public function set customView(value:UIView):void{
			_customView = value;
		}
		// returns the curstom view.
		public function get customView():UIView{
			return _customView;
		}
		
	}
}