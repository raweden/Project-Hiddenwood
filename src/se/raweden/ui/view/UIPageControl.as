package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	/**
	 * A <code>UIPageControl</code> component manages pagination.
	 * <p>A page controll consists of a array of dots centered in the component.
	 * Each dot represents a page in the application's document (or other data-model entity),
	 * with the white dot indicating the currently viewed page.</p>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIPageControl extends UIControl{
				
		//
		// TODO: use a DisplayObject for each dot instead of the graphics context.
		// TODO: provide a way to customize the colors and icons of the dots.
		//
		
		private var _currentPage:int;
		private var _numPages:int;
		private var _autoHide:Boolean;
		private var _defersCurrentPageDisplay:Boolean;
		
		private var m_dots:Array = new Array();
		
		public function UIPageControl(parent:DisplayObjectContainer = null){
			super(parent);
			// initilizes the Page control.
			init();
		}
		
		// Initilizes the page control.
		private function init():void{
			// setting the default values.
			_defersCurrentPageDisplay = false;
			_autoHide = false;
			_numPages = 0;
			_currentPage = -1;
			// setting the default size.
			resize(320,20);
		}
		
		//------------------------------------
		// Managing the Page Navigation
		//------------------------------------
		
		/**
		 * 
		 * @default <code>-1</code>
		 */
		public function set currentPage(value:int):void{
			if(value != _currentPage){
				_currentPage = value;
				if(_defersCurrentPageDisplay){
					updateCurrentPageDisplay();
				}
			}
		}
		// returns the value of the currentPage attribute.
		public function get currentPage():int{
			return _currentPage;
		}
		
		/**
		 * 
		 * @default <code>0</code>
		 */
		public function set numPages(value:int):void{
			_numPages = value;
			if(value > 0 && autoHide && !this.visible){
				this.visible = true;
			}
			updateCurrentPageDisplay();
		}
		// returns the value of the numPages attribute.
		public function get numPages():int{
			return _numPages;
		}
		
		/**
		 * 
		 * @default <code>false</code>
		 */
		public function set autoHide(value:Boolean):void{
			_autoHide = value;
			if(_numPages == 1){
				this.visible = false;
			}
		}
		// returns the value of the autoHide attribute.
		public function get autoHide():Boolean{
			return _autoHide;
		}
		
		//------------------------------------
		// Updating the Page Display
		//------------------------------------
		
		/**
		 * A <code>Boolean</code> value that determines whether the page indicator should be 
		 * updated automatically when the <code>currentPage</code> attribute is changed.
		 */
		public function set defersCurrentPageDisplay(value:Boolean):void{
			_defersCurrentPageDisplay = value;
		}
		// returns the value of the defersCurrentPageDisplay attribute.
		public function get defersCurrentPageDisplay():Boolean{
			return _defersCurrentPageDisplay;
		}
		
		public function updateCurrentPageDisplay():void{
			needs("draw",draw);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			var len:int = _numPages;
			var dia:int = 10;
			var spa:int = dia+4;
			var width:Number = spa*len;
			var x:int = Math.round((rect.width-width)*0.5)+2;
			var y:int = Math.round((rect.height-dia)*0.5);
			this.graphics.clear();
			for(var i:int = 0;i<len;i++){
				if(i == _currentPage){
					this.graphics.beginFill(0x2D2D2D,0.4);	
				}else{
					this.graphics.beginFill(0xCCCCCC,0.4);
				}
				this.graphics.drawEllipse(x,y,dia,dia);
				this.graphics.endFill();
				x += spa;
			}
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