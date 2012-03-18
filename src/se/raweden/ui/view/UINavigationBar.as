package se.raweden.ui.view
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import se.raweden.ui.UIImage;
	import se.raweden.ui.vo.UINavigationItem;
	
	/**
	 * A <code>UINavigationBar</code> view
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UINavigationBar extends UIView{
		
		//
		// TODO: add animation when pop and pushing UINavigation items.
		// TODO: write documentation.
		//
		
		[Embed(source="../../../../../res/nav-bar.png")]
		private static var BAR:Class;
				
		[Embed(source="../../../../../res/nav-back.png")]
		private static var BACK_IMAGE:Class;
		private static var backImage:UIImage;
		
		[Embed(source="../../../../../res/nav-back(down).png")]
		private static var BACK_DOWN:Class;
		private static var backImageDown:UIImage;
		
		{
			init();
		}
		
		private static function init():void{
			var bitmap:BitmapData;
			var image:UIImage;
			
			bitmap = new BACK_IMAGE().bitmapData;
			image = new UIImage(bitmap.width,bitmap.height);
			image.draw(bitmap);
			image.stretchable(20);
			backImage = image;

			bitmap = new BACK_DOWN().bitmapData;
			image = new UIImage(bitmap.width,bitmap.height);
			image.draw(bitmap);
			image.stretchable(20);
			backImageDown = image;
		}

		// Instance variables.
		
		private var _items:Array = new Array();
		private var _labelView:UILabel;
		private var _backButton:UIButton;
		
		/**
		 * Constructor.
		 */
		public function UINavigationBar(parent:UIView){
			super(parent,new Rectangle(0,0,320,40));
			addChildren();
		}
		
		/**
		 * Creates and adds related views.
		 */
		private function addChildren():void{
			_labelView = new UILabel(this);
			_labelView = new UILabel(this);
			_labelView.text = "UINavigationBar";
			_labelView.align = "center";
			_labelView.size = 18;
			_labelView.textColor = 0xFFFFFF;
			_labelView.resize(width,27);
			_backButton = new UIButton(this);
			_backButton.setBackground(backImageDown,UIControlState.Highlighted);
			_backButton.setBackground(backImage,UIControlState.Normal);
			_backButton.setBackground(backImage,UIControlState.Selected);
			_backButton.setBackground(backImage,UIControlState.Disabled);
			_backButton.x = 3;
			_backButton.y = 6;
			_backButton.title = "Back";
			//_backButton.enabled = false;
		}
		
		//------------------------------------
		// Getting Attributes.
		//------------------------------------
		
		/**
		 * Retuns the composite button which acts as the back button.
		 */
		public function get backButton():UIButton{
			return _backButton;
		}
			
		
		/**
		 * 
		 */
		public function get backItem():UINavigationItem{
			var len:int = _items.length;
			return len > 1 ? _items[len-2] : null;
		}
		
		public function get topItem():UINavigationItem{
			var len:int = _items.length;
			return len > 0 ? _items[len-1] : null;
		}
		
		//------------------------------------
		// Pushing and Popping Items.
		//------------------------------------
		
		/**
		 * 
		 * @param item
		 * @param animated
		 */
		public function push(item:UINavigationItem,animated:Boolean = true):void{
			animated = this.stage ? animated : false;
			_items.push(item);
			_labelView.text = item.title;
			var back:UINavigationItem = backItem;
			if(back){
				_backButton.title = back.title ? back.title : "";
				_backButton.enabled = true;
			}
			trace("nav length:",_items.length);
		}
		
		/**
		 * 
		 * @param animated
		 */
		public function pop(animated:Boolean = true):void{
			animated = this.stage ? animated : false;
			trace("nav length:",_items.length);
			if(_items.length > 1){
				var item:UINavigationItem = _items.pop();
				item = this.topItem;
				_labelView.text = item.title ? item.title : "";
				var back:UINavigationItem = backItem;
				if(back){
					_backButton.title = back.title ? back.title : "";	
				}else{
					_backButton.title = "Back";
					_backButton.enabled = false;
				}
			}
		}
	
		//------------------------------------
		// Updating Content Displayed.
		//------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function layout(rect:Rectangle):void{
			_labelView.width = rect.width;
			_labelView.y = Math.round((rect.height-_labelView.height)*0.5);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			var bar:BitmapData = new BAR().bitmapData;
			this.graphics.clear();
			this.graphics.beginBitmapFill(bar);
			this.graphics.drawRect(0,0,rect.width,rect.height);
			this.graphics.endFill();
		}
		
		public function set title(value:String):void{
			_labelView.text = value;
		}
		
		
		//------------------------------------
		// Deconstruction
		//------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void{
			// destoying the super implemenation.
			super.dispose();
		}
		
	}
}