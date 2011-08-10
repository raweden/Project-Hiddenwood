﻿//
//	UIScrollView.as
//	Core UI Framework
//
//	Created by Jesper Svensson on 2011-07
//	Copyright 2011 Jesper Svensson. All rights reserved.
//

package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import se.raweden.core.core;
	
	/**
	 * A <code>UIScrollView</code> component is a...
	 * 
	 * @author Raweden
	 */
	public class UIScrollView extends UIView{
		
		//
		// TODO: add zooming capibitly, using rectangular area to scale the content view.
		// TODO: remove glitcy behaivor on buncing.
		// TODO: add paging logics.
		// TODO: add logics based on input device.
		// TODO: show overlay scrollers when mouse is over the view on pc.
		// TODO: add support with magic-mouse and trackpad on mac.
		//
		
		use namespace core;
		
		// static constants.
		private static const threshold:Number = 0.24;			// The smallest allowed velocity threshold.
		private static const BOUNCING_SPRINGESS:Number = 0.45;
		
		// content related variabels.
		private var m_content:InteractiveObject;
		private var m_contentBounds:Rectangle = new Rectangle(0,0,100,100);
		private var m_contentOffset:Point = new Point();
		private var m_mask:Shape;
		// scrollview general behvavior.
		private var m_scrollEnabled:Boolean = true;
		private var m_pagingEnabled:Boolean = false;
		// bouncing and scrolling.
		private var m_offset:Point = new Point();
		private var m_mouse:Point = new Point();
		private var vy:Number;
		private var vx:Number;
		// bouncing behvaior.
		private var m_alwaysBounceHorizontal:Boolean = false;
		private var m_alwaysBounceVertical:Boolean = false;
		private var m_bounces:Boolean = true;
		private var m_dragging:Boolean = false;
		private var m_decelerating:Boolean = false;		// this boolean also indicates if the enterFrame listners is added.
		// overlay scrollers components.
		core var hScroller:UIScroller;
		core var vScroller:UIScroller;
				
		public function UIScrollView(parent:DisplayObjectContainer = null,content:UIView = null){
			super(parent);
			addChildren();
			init();
			this.content = content;
		}
		
		// adds child component and display objects to the scrollview.
		private function addChildren():void{
			m_mask = new Shape();
			m_mask.graphics.beginFill(0x000000);
			m_mask.graphics.drawRect(0,0,100,100);
			m_mask.graphics.endFill();
			this.addChild(m_mask);
		}
		
		// initilizes the scroll view.
		private function init():void{
			this.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
		}
		
		//------------------------------------
		// Configurating the Content.
		//------------------------------------
		
		/**
		 * 
		 */
		public function set content(value:InteractiveObject):void{
			if(m_content){
				m_content.removeEventListener(Event.RESIZE,onContentResize);
				m_content.removeEventListener(MouseEvent.MOUSE_DOWN,dragStart);
				// removing the mask from the old content.
				if(m_content.mask == m_mask){
					m_content.mask = null;
				}
				// removing the content from the scrollview.
				if(this.contains(m_content)){
					this.removeChild(m_content);
				}
			}
			m_content = value;
			if(m_content){
				m_content.addEventListener(Event.RESIZE,onContentResize);
				m_content.addEventListener(MouseEvent.MOUSE_DOWN,dragStart);
				this.addChildAt(m_content,0);
				m_content.mask = m_mask;
			}
			// refrehing the layout.
			this.setNeedsLayout();
		}
		// returns the current content container.
		public function get content():InteractiveObject{
			return m_content;
		}
		
		/**
		 * A Rectangle that represents the visible bounds of the content view.
		 */
		public function get contentBounds():Rectangle{
			return m_contentBounds;
		}
		
		/**
		 * A Point at which the origin of the content view is offset relative to the orgin of the scroll view.
		 */
		public function get contentOffset():Point{
			return m_contentOffset.clone();
		}
		
		// responding the the resize of the content view.
		private function onContentResize(e:Event):void{
			this.setNeedsLayout();
		}
		
		//------------------------------------
		// Responding to user Interaction and Dragging and Throwing the content view.
		//------------------------------------
						
		// triggerd when as the user begins dragging the content view.
		private function dragStart(e:MouseEvent):void{
			m_dragging = true;
			stage.addEventListener(MouseEvent.MOUSE_UP,dragStop);
			// adding enter frame listner to drag the content and animate the scorlling.
			if(!m_decelerating){
				this.addEventListener(Event.ENTER_FRAME,dragMove);
				//trace("did start scroll animation");
			}
			// setting vars.
			m_offset.x = m_content.mouseX;
			m_offset.y = m_content.mouseY;
			m_mouse.x = this.mouseX;
			m_mouse.y = this.mouseY;
		}
				
		// triggerd as the user is dragging or throwing the content view.
		private function dragMove(e:Event):void{
			var x:Number;
			var y:Number;
			var mx:int = -(m_content.width-m_width);
			var my:int = -(m_content.height-m_height);
			// 
			if(m_dragging){
				// getting where the content should be draged.
				x = this.mouseX-m_offset.x;
				y = this.mouseY-m_offset.y;
				// getting the velocity.
				vx = this.mouseX-m_mouse.x;
				vy = this.mouseY-m_mouse.y;
				// setting reference.
				m_mouse.x = this.mouseX;
				m_mouse.y = this.mouseY;
			}else{
				var bx:Number = 0;
				var by:Number = 0;
				
				x = m_content.x;
				y = m_content.y;
				// carculating the bouncing.
				// constrains the horizontal bounds to the content bounds.
				if(m_bounces){
					//if(canScrollHorizontal || m_alwaysBounceHorizontal){
						// 
						if(x > 0 || mx > 0){
							bx = -x * BOUNCING_SPRINGESS;
						}else if(x < mx){
							bx = (mx - x) * BOUNCING_SPRINGESS;
						}		
					//}
					//if(canScrollVertical || m_alwaysBounceVertical){
						//
						if(y > 0 || my > 0){
							by = -y * BOUNCING_SPRINGESS;
						}else if(y < my){
							by = (my - y) * BOUNCING_SPRINGESS;
						}		
					//}
				}
				// carculating the final pos.
				x = x+vx+bx;
				y = y+vy+by;
				// decaying the velocity value, like friction.
				vy *= 0.95;
				vx *= 0.95;
				// constins the velocity to the threshold.
				var tx:Boolean = Math.abs(vx) < threshold;
				var ty:Boolean = Math.abs(vy) < threshold;
				vx = tx ? 0 : vx;
				vy = ty ? 0 : vy;
				tx = tx && Math.abs(bx) == 0;
				ty = ty && Math.abs(by) == 0;
				// killing the decelerating loop if both values are below the threshold.
				if(tx && ty){
					this.removeEventListener(Event.ENTER_FRAME,dragMove);
					m_decelerating = false;
					//trace("did kill scroll animation");
				}
			}
			if(!m_bounces){
				// constrains the horizontal bounds to the content bounds.
				if(x > 0){
					x = 0;
					vx = 0;
				}else if(x < mx){
					x = mx;
					vx = 0;
				}
				// constrains the vertical bounds to the content bounds.
				if(y > 0){
					y = 0;
					vy = 0;
				}else if(y < my){
					y = my;
					vy = 0;
				}	
			}
			var a:int;
			if(vScroller){
				vScroller.procent = y/my;
				a = 0;
				if(y > 0){
					a = y;
				}else if(y < my){
					a = Math.abs(y-my);
				}
				vScroller.ratio = m_height/(a+m_content.height);
			}
			if(hScroller){
				hScroller.procent = x/mx;
				a = 0;
				if(x > 0){
					a = x;
				}else if(x < mx){
					a = Math.abs(x-mx);
				}
				hScroller.ratio = m_width/(a+m_content.width);
			}
			// setting the final positon of the content.
			m_content.x = x;
			m_content.y = y;
			//if(y > 0 && y < my && x > 0 && x < mx){
				m_contentBounds.y = -y;
				m_contentBounds.x = -x;
				contentDidScroll(m_contentBounds.clone());	
			//}
		}
		
		// triggerd when the user's releases the mouse and stops the dragging.
		private function dragStop(e:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,dragStop);
			//this.addEventListener(Event.ENTER_FRAME,dragMove);
			m_decelerating = true;
			m_dragging = false;
			
			// if paging is enabled this code snippet makes the scroll view snap to the closest page bounds.
			if(m_pagingEnabled){
				//var pageSize:Point = new Point(m_bounds.width,m_bounds.height);
				//var numPages:Point = new Point(Math.floor(m_content.width/pageSize.x),Math.floor(m_content.height/pageSize.y));
				//var page:Point =  new Point(Math.floor(m_content.x/pageSize.x),Math.floor(m_content.y/pageSize.y));
			}
			
			/* UKit code.
			if (_pagingEnabled) {
			const CGSize pageSize = self.bounds.size;
			const CGSize numberOfWholePages = CGSizeMake(floorf(_contentSize.width/pageSize.width), floorf(_contentSize.height/pageSize.height));
			const CGSize currentRawPage = CGSizeMake(_contentOffset.x/pageSize.width, _contentOffset.y/pageSize.height);
			const CGSize currentPage = CGSizeMake(floorf(currentRawPage.width), floorf(currentRawPage.height));
			const CGSize currentPagePercentage = CGSizeMake(1-(currentRawPage.width-currentPage.width), 1-(currentRawPage.height-currentPage.height));
			
			CGPoint finalContentOffset = CGPointZero;
			
			// if currentPagePercentage is less than 50%, then go to the next page (if any), otherwise snap to the current page
			
			if (currentPagePercentage.width < 0.5 && (currentPage.width+1) < numberOfWholePages.width) {
			finalContentOffset.x = pageSize.width * (currentPage.width + 1);
			} else {
			finalContentOffset.x = pageSize.width * currentPage.width;
			}
			
			if (currentPagePercentage.height < 0.5 && (currentPage.height+1) < numberOfWholePages.height) {
			finalContentOffset.y = pageSize.height * (currentPage.height + 1);
			} else {
			finalContentOffset.y = pageSize.height * currentPage.height;
			}
			
			// quickly animate the snap (if necessary)
			if (!CGPointEqualToPoint(finalContentOffset, _contentOffset)) {
			[self _setContentOffset:finalContentOffset withAnimationDuration:UIScrollViewAnimationDuration/3.];
			}
			}
			*/
		}
		
		// triggerd as the user is manualy scrolling the view with the overlay scrollers - Vertical.
		private function onVScroll(e:Event):void{
			var y:int = Math.floor((m_content.height-m_mask.height)*vScroller.procent);
			m_content.y = -y;
			m_contentBounds.y = y;
			contentDidScroll(m_contentBounds.clone());
		}
		
		// triggerd as the user is manualy scrolling the view with the overlay scrollers - Horizontal.
		private function onHScroll(e:Event):void{
			var x:int = Math.floor((m_content.width-m_width)*hScroller.procent);
			m_content.x = -x;
			m_contentBounds.x = x;
			contentDidScroll(m_contentBounds.clone());
		}
		
		// triggerd as the user rolls over the ScrollView.
		private function onRollOver(e:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,onScroll);
			trace("did roll over scrollview");
		}
		
		// triggerd as the user rolls out from the scrollview.
		private function onRollOut(e:Event):void{
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL,onScroll);
			trace("did roll out scrollview");
		}
		
		// triggerd as the user scroll while beeing over the scrollview.
		private function onScroll(e:MouseEvent):void{
			trace("delta:",e.delta);
			/*
			var y:int = Math.floor((m_content.height-m_mask.height)*vScroller.procent);
			m_content.y = -y;
			m_contentBounds.y = y;
			contentDidScroll(m_contentBounds.clone());
			*/
		}

		//------------------------------------
		// Regular Scrolling.
		//------------------------------------
				
		/**
		 * A Boolean value that determines if scrolling is enabled in the scroll view.
		 */
		public function set scrollEnabled(value:Boolean):void{
			m_scrollEnabled = value;
		}
		// Indicates if scrolling is enabled.
		public function get scrollEnabled():Boolean{
			return m_scrollEnabled;
		}
		
		/**
		 * Returns the scroller instance used for vertical scrolling.
		 */
		public function get verticalScroller():UIScroller{
			if(!vScroller){
				vScroller = new UIScroller(this);
				vScroller.y = 2;
				vScroller.addEventListener(Event.SCROLL,onVScroll);
				this.setNeedsLayout();
			}
			return vScroller;
		}
				
		/**
		 * Returns the scroller instance used for vertical scrolling.
		 */
		public function get horizontalScroller():UIScroller{
			if(!hScroller){
				hScroller = new UIScroller(this);
				hScroller.direction = UIScroller.DIRECTION_HORIZONTAL;
				hScroller.x = 2;
				hScroller.addEventListener(Event.SCROLL,onHScroll);
				this.setNeedsLayout();
			}
			return hScroller;
		}
				
		/**
		 * Triggerd as the content view is scrolled.
		 * 
		 * @param bounds The Bounds that are currently visible in the content view.
		 */
		public function contentDidScroll(bounds:Rectangle):void{
			
		}
		
		// 
		private function get canScrollHorizontal():Boolean{
			return this.scrollEnabled && (m_content.width > this.width);
		}
		
		//
		private function get canScrollVertical():Boolean{
			return this.scrollEnabled && (m_content.height > this.height);
		}
		
		
		//------------------------------------
		// Bounce Behavior.
		//------------------------------------
		
		/**
		 * A Boolean value that controls whether the scroll view bounces past the edge of the content and back again.
		 *  
		 * @default <code>true</code>
		 */
		public function set bounces(value:Boolean):void{
			m_bounces = value;
		}
		// indicetes if bounces is to be used.
		public function get bounces():Boolean{
			return m_bounces;
		}

		/**
		 * A Boolean value that determines whether bouncing allways occurs when vertical scrolling reaches the end of the content view.
		 * 
		 * @default <code>false</code>
		 */
		public function set alwaysBounceVertical(value:Boolean):void{
			m_alwaysBounceVertical = value;
		}
		//
		public function get alwaysBounceVertical():Boolean{
			return m_alwaysBounceVertical;
		}

		/**
		 * A Boolean value that determines whether bouncing allways occurs when horizontal scrolling reaches the end of the content view.
		 * 
		 * @default <code>false</code>
		 */
		public function set alwaysBounceHorizontal(value:Boolean):void{
			m_alwaysBounceHorizontal = value;
		}
		//
		public function get alwaysBounceHorizontal():Boolean{
			return m_alwaysBounceHorizontal;
		}

		
		/**
		 * A Boolean value that indicates whether the user has begun scrolling the content.
		 */
		public function get dragging():Boolean{
			return m_dragging;
		}
		
		/**
		 * A Boolean value that indicates whether the scroll view is currently decelerating after scrolling the content.
		 */
		public function get decelerating():Boolean{
			return m_decelerating;
		}
		
		//------------------------------------
		// Paging Behavior.
		//------------------------------------
		
		/**
		 * A Boolean valie taht determines whether paging is enabled for the scroll view.
		 * 
		 * <p>If this value is set to <code>true</code>, the scroll view stops on the nearest 
		 * multiple if the scroll view's bounds when the user scrolls.</p>
		 * 
		 * @default <code>false</code>
		 */
		public function set pagingEnabled(value:Boolean):void{
			m_pagingEnabled = value;
		}
		// indicates if paging is enabled.
		public function get pagingEnabled():Boolean{
			return m_pagingEnabled;
		}
						
		//------------------------------------
		// Updating Content Displayed.
		//------------------------------------
		
		/**
		 * @private;
		 */
		override protected function layout(rect:Rectangle):void{
			if(m_content){
				if(m_content.height < m_height){
					m_content.y = 0;
					verticalScroller.procent = 0;
					m_contentBounds.y = 0;
					contentDidScroll(m_contentBounds);
				}
				verticalScroller.ratio = m_height/m_content.height;
			}
			verticalScroller.visible = this.canScrollVertical;
			horizontalScroller.visible = this.canScrollHorizontal;
			if(vScroller){
				verticalScroller.height = rect.height-12;
				verticalScroller.x = rect.width-9;
			}
			if(hScroller){
				horizontalScroller.width = rect.width-12;
				horizontalScroller.y = rect.height-9;
			}
			m_mask.width = m_contentBounds.width = rect.width;
			m_mask.height = m_contentBounds.height = rect.height;
		}
						
		//------------------------------------
		// Deconstruction
		//------------------------------------
		
		/**
		 * @private;
		 */
		override public function destroy():void{
			
			// destoying the super implemenation.
			super.destroy();
		}
		
		//------------------------------------
		// Other 
		//------------------------------------
		
		/**
		 * @private
		 */		
		public override function toString():String{
			return "[UIScrollView frame = "+m_bounds.toString()+" contentOffset = "+this.contentOffset.toString()+" ]";
		}
		
	}
}
