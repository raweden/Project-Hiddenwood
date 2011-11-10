//
//	UIPageControl.as
//	Core UI Framework
//
//	Created by Raweden on 2011-07-01
//	Copyright 2011 Raweden. Some rights reserved.
//

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
	 * @copyright Copyright 2011 Raweden. All rights reserved.
	 * @author Raweden
	 */
	public class UIPageControl extends UIControl{
				
		//
		// TODO: use a DisplayObject for each dot instead of the graphics context.
		// TODO: provide a way to customize the colors and icons of the dots.
		//
		
		private var m_currentPage:int;
		private var m_numPages:int;
		private var m_hideWhenSinglePage:Boolean;
		private var m_defersCurrentPageDisplay:Boolean;
		
		private var m_dots:Array = new Array();
		
		public function UIPageControl(parent:DisplayObjectContainer = null){
			super(parent);
			// initilizes the Page control.
			init();
		}
		
		// Initilizes the page control.
		private function init():void{
			// setting the default values.
			m_defersCurrentPageDisplay = false;
			m_hideWhenSinglePage = false;
			m_numPages = 0;
			m_currentPage = -1;
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
			if(value != m_currentPage){
				m_currentPage = value;
				if(m_defersCurrentPageDisplay){
					updateCurrentPageDisplay();
				}
			}
		}
		// indicates the current page.
		public function get currentPage():int{
			return m_currentPage;
		}
		
		/**
		 * 
		 * @default <code>0</code>
		 */
		public function set numPages(value:int):void{
			m_numPages = value;
			if(value > 0 && hideWhenSinglePage && !this.visible){
				this.visible = true;
			}
			updateCurrentPageDisplay();
		}
		// indicates the current page.
		public function get numPages():int{
			return m_numPages;
		}
		
		/**
		 * 
		 * @default <code>false</code>
		 */
		public function set hideWhenSinglePage(value:Boolean):void{
			m_hideWhenSinglePage = value;
			if(m_numPages == 1){
				this.visible = false;
			}
		}
		// indicates the current page.
		public function get hideWhenSinglePage():Boolean{
			return m_hideWhenSinglePage;
		}
		
		//------------------------------------
		// Updating the Page Display
		//------------------------------------
		
		public function set defersCurrentPageDisplay(value:Boolean):void{
			m_defersCurrentPageDisplay = value;
		}
		// indicates if the Page Control should switch directly.
		public function get defersCurrentPageDisplay():Boolean{
			return m_defersCurrentPageDisplay;
		}
		
		public function updateCurrentPageDisplay():void{
			this.setNeedsDisplay();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			var len:int = m_numPages;
			var dia:int = 10;
			var spa:int = dia+4;
			var width:Number = spa*len;
			var x:int = Math.round((rect.width-width)*0.5)+2;
			var y:int = Math.round((rect.height-dia)*0.5);
			this.graphics.clear();
			for(var i:int = 0;i<len;i++){
				if(i == m_currentPage){
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