﻿////	UIButton.as//	Core UI Framework////	Created by Raweden on 2011-05-22//	Copyright 2011 Raweden. Some rights reserved.//package se.raweden.ui.view{	import flash.display.BitmapData;	import flash.display.DisplayObjectContainer;	import flash.events.MouseEvent;	import flash.geom.Rectangle;	import flash.text.TextField;	import flash.text.TextFormat;		import se.raweden.core.core;	import se.raweden.ui.UIImage;
	/**	 * A <code>UIButton</code> component	 * 	 * @copyright Copyright 2011 Raweden. All rights reserved.	 * @author Raweden	 */	public class UIButton extends UIControl{				use namespace core;				//		// TODO: Add support for title for state.		//				private var m_toggle:Boolean = false;		private var m_callback:Function;		// Button Configuration.		private var m_backgrounds:Object;		private var m_images:Object;		// Related Views.				private var m_labelView:UILabel;		private var m_imageView:UIImageView;				/**		 * Constructor.		 */		public function UIButton(parent:DisplayObjectContainer = null,callback:Function = null){			super(parent);			m_callback = callback;			addChildren();			init();		}				// adds children to this button instance.		private function addChildren():void{					}				// initlizes this button instance.		private function init():void{			resize(90,22);			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);			this.addEventListener(MouseEvent.CLICK,onMouseClick);		}				//------------------------------------ 		// Responding to User interaction		//------------------------------------				// triggerd when the Button instace resives a mouse down event.		private function onMouseDown(e:MouseEvent):void{			if(m_toggle){				this.highlighted = !this.highlighted;			}else{				stage.addEventListener(MouseEvent.MOUSE_UP,onMouseEvent);				this.highlighted = true;			}		}				// triggerd when the Button instance resives a muse click event.		private function onMouseClick(e:MouseEvent):void{			if(m_callback != null){				m_callback.length == 1 ? m_callback(this) : m_callback();							}		}				// triggerd when the Button instance resives a mouse event.		private function onMouseEvent(e:MouseEvent):void{			var type:String = e.type;			if(!m_toggle && type == MouseEvent.MOUSE_UP){				stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseEvent);				if(!m_toggle)					this.highlighted = false;				return;			}		}						//------------------------------------		// Configuring Button Title		//------------------------------------				/**		 * Specifies the default label of the button.		 * 		 * @default <code>null</code>		 */		public function set label(value:String):void{			labelView.text = value;			this.setNeedsLayout();		}		//		public function get label():String{			return m_labelView.text;		}				/**		 * Specifies the default label of the button.		 * 		 * @default <code>null</code>		 */		public function set labelColor(value:uint):void{			labelView.textColor = value;		}		//		public function get labelColor():uint{			return m_labelView.textColor;		}				/**		 * 		 */		public function get labelView():UILabel{			if(!m_labelView){				m_labelView = new UILabel(this);				m_labelView.align = "center";				m_labelView.textColor = 0xCCCCCC;				m_labelView.size = 16;				m_labelView.y = 4;				m_labelView.height = 18;				this.setNeedsLayout();			}			return m_labelView;		}				//------------------------------------		// Configuring Button Icon		//------------------------------------				/**		 * 		 * @param image		 * @param state		 */		public function setImage(image:BitmapData,state:int):void{			if(!m_images){				m_images = {};			}			m_images[state] = image;			if(this.state == state){				this.setNeedsDisplay();				this.setNeedsLayout();				}		}				/**		 * 		 * @param state		 */		public function image(state:int):BitmapData{			return m_images ? m_images[state] : null;		}				/**		 * 		 */		public function get imageView():UIImageView{			if(!m_imageView){				m_imageView = new UIImageView(this);				this.setNeedsLayout();			}			return m_imageView;		}				//------------------------------------		// Getting Related Views.		//------------------------------------				//------------------------------------		// Getting and Setting Attributes		//------------------------------------						/**		 * Specifies the callback function to be called when then the UIButton instance is clicked.		 * 		 * <p><h1>example</h1><code>button.callback = function(button:UIButton):void{}</code></p>		 * 		 * @default <code>null</code>		 */		public function set callback(value:Function):void{			m_callback = value;		}		//		public function get callback():Function{			return(m_callback);		}								/**		 * Specifies if the button is a toggle button.		 * 		 * @default <code>false</code>		 */		public function set toggle(value:Boolean):void{			if(value == m_toggle)return;			m_toggle = value;			invalidate();		}		//		public function get toggle():Boolean{			return(m_toggle);		}				//------------------------------------		// Customize Button States		//------------------------------------						/**		 * 		 * @oaram image		 * @param state		 */		public function setBackground(image:BitmapData,state:int):void{			if(!m_backgrounds){				m_backgrounds = {};			}			m_backgrounds[state] = image;			if(this.state == state)				this.setNeedsDisplay();		}				/**		 * 		 * @param state		 * @return		 */		public function background(state:int):BitmapData{			return m_backgrounds ? m_backgrounds[state] : null;		}				//------------------------------------		// Updating Content Displayed.		//------------------------------------						/**		 * @inheritDoc		 */		override protected function draw(rect:Rectangle):void{			var w:int = rect.width;			var h:int = rect.height;			if(m_backgrounds){				var background:BitmapData = m_backgrounds[state];				var image:UIImage;				if(background is UIImage){					image = background as UIImage;					if(image.topCap == -1){						rect.height = image.height;					}					if(image.leftCap == -1){						rect.width = image.width;					}					this.graphics.clear();					var size:Rectangle = image.drawOn(this.graphics,rect,false);				}else{					rect.height = background.height;					rect.width = background.width;					this.graphics.clear();					this.graphics.beginBitmapFill(background);					this.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);					this.graphics.endFill();				}				if(background){				}			}else{				this.graphics.beginFill(0x2D2D2D,0.85);				this.graphics.drawRoundRect(1,1,rect.width,rect.height,6,6);			}		}				/**		 * @inheritDoc		 */		override protected function layout(rect:Rectangle):void{			if(m_labelView && m_imageView){								return;			}else{				// Laying out label.				if(m_labelView){					m_labelView.width = rect.width;					m_labelView.height = rect.height;				}								if(m_imageView){					m_imageView.x = Math.round((rect.width-m_labelView.height)*0.5);					m_imageView.y = Math.round((rect.height-m_labelView.height)*0.5);				}			}					}						//------------------------------------		// Deconstruction		//------------------------------------				/**		 * @inheritDoc		 */		override public function dispose():void{			// removing eventlistners.			this.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent);			this.removeEventListener(MouseEvent.CLICK,onMouseClick);			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseEvent);			// destroying the super object.			super.dispose();		}			}}