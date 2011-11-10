//
//	UITextField.as
//	Core UI Framework
//
//	Created by Raweden on 2011-07-22
//	Copyright 2011 Raweden. Some rights reserved.
//

package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import se.raweden.core.core;
	
	/**
	 * A <code>UITextField</code>
	 * 
	 * @copyright Copyright 2011 Raweden. All rights reserved.
	 * @author Raweden
	 */
	public class UITextField extends UIControl{
		
		use namespace core;
		
		//
		// TODO: add iOS style implementation for customize the images.
		// TODO: implement a custom way to show secure text input.
		//
		
		public static const PLACE_HOLDER_COLOR:uint = 0x808080;
		
		// general properties.
		private var m_font:String;
		private var m_textFormat:TextFormat = new TextFormat();
		private var m_text:String;
		private var m_textColor:uint = 0x000000;
		private var m_textAlign:String;
		private var m_isSecure:Boolean;
		private var m_placeHolder:String;
		// configurating editing
		private var m_editing:Boolean = false;
		private var m_clearOnBeginEditing:Boolean = false;
		
		private var textField:TextField;
		
		public function UITextField(parent:DisplayObjectContainer = null, frame:Rectangle = null){
			super(parent, frame);
			addChildren();
			init();
		}
		
		private function addChildren():void{
			textField = new TextField();
			textField.type = "input";
			textField.addEventListener(TextEvent.TEXT_INPUT,onTextInput);
			textField.addEventListener(FocusEvent.FOCUS_IN,onFocusChange);
			textField.addEventListener(FocusEvent.FOCUS_OUT,onFocusChange);
			textField.defaultTextFormat = new TextFormat("Arial",16,0x000000);
			this.addChild(textField);
		}
		
		private function init():void{
			// setting the default size.
			resize(320,24);
		}
		
		//------------------------------------
		// Responding to user Interaction.
		//------------------------------------
		
		private var delay:Timer;

		protected function onTextInput(e:TextEvent):void{
			if(m_isSecure){
				if(!delay){
					delay = new Timer(500);
					delay.addEventListener(TimerEvent.TIMER,onTimerComplete);
				}
				if(!delay.running)
					delay.start();
				trace("event-text:","\""+e.text+"\"");
			}
		}
		
		private function onTimerComplete(e:TimerEvent):void{
			textField.text = textField.text.replace(/./g,"•");
			delay.stop();
		}
		
		private function onFocusChange(e:FocusEvent):void{
			switch(e.type){
				case FocusEvent.FOCUS_IN : {
					// clears the text if the behavior is specified.
					if(m_clearOnBeginEditing || textField.text == m_placeHolder){
						textField.text = "";
						textField.textColor = m_textColor;
					}
					// traces the state.
					trace(this,"focus in");
					m_editing = true;
				}break;
				case FocusEvent.FOCUS_OUT : {
					// reverting to placeholder if empty.
					if(textField.text == ""){
						textField.text = m_placeHolder;
						textField.textColor = PLACE_HOLDER_COLOR;
					}
					// traces the state.
					trace(this,"focus out");
					m_editing = false;
				}
			}
		}
		
		//------------------------------------
		// Getting and Setting Attributes.
		//------------------------------------
		
		/**
		 * 
		 */
		public function set isSecure(value:Boolean):void{
			m_isSecure = value;
			//textField.displayAsPassword = value;
		}
		
		public function get isSecure():Boolean{
			return m_isSecure;
		}
		
		/**
		 * The String that is displayed when tere is no other text in the text field.
		 * 
		 * @default <code>null</code>
		 */
		public function set placeHolder(value:String):void{
			m_placeHolder = value;
			if(textField.text == "" && !m_editing){
				textField.text = value;
				textField.textColor = PLACE_HOLDER_COLOR;
			}
		}
		
		public function get placeHolder():String{
			return m_placeHolder;
		}
		
		/**
		 * 
		 */
		public function set text(value:String):void{
			textField.text = value;
			this.setNeedsDisplay();
			this.setNeedsLayout();
		}
		//
		public function get text():String{
			return textField.text;
		}
		
		/**
		 * 
		 */
		public function set textAlign(value:String):void{
			value = value == "right" || value == "center" ? value : "left";
			m_textFormat.align = m_textAlign = value;
			textField.setTextFormat(m_textFormat);
		}
		//
		public function get textAlign():String{
			return m_textAlign;
		}

		/**
		 * 
		 */
		public function set textColor(value:uint):void{
			m_textColor = value;
			if(textField.text != m_placeHolder){
				textField.textColor = value;
			}
		}
		//
		public function get textColor():uint{
			return m_textColor;
		}

		/**
		 * 
		 */
		public function set font(value:String):void{
			m_font = value;
			m_textFormat.font = value;
			textField.setTextFormat(m_textFormat);
		}
		//
		public function get font():String{
			return m_font;
		}

		/**
		 * 
		 */
		public function get editing():Boolean{
			return m_editing;
		}

		/**
		 * 
		 */
		public function set clearOnBeginEditing(value:Boolean):void{
			m_clearOnBeginEditing = value;
		}
		//
		public function get clearOnBeginEditing():Boolean{
			return m_clearOnBeginEditing;
		}
		
		//------------------------------------
		// Updating Content Displayed.
		//------------------------------------

		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			this.graphics.clear();
			this.graphics.beginFill(0xF1F1F1);
			this.graphics.drawRoundRect(0,0,rect.width,rect.height,8,8);
			this.graphics.endFill();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout(rect:Rectangle):void{
			textField.width = rect.width;
			textField.height = rect.height;
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
/*
Accessing the Text Attributes
text  property
placeholder  property
font  property
textColor  property
textAlignment  property

Sizing the Text Field’s Text
adjustsFontSizeToFitWidth  property
minimumFontSize  property

Managing the Editing Behavior
editing  property
clearsOnBeginEditing  property

Setting the View’s Background Appearance
borderStyle  property
background  property
disabledBackground  property

Managing Overlay Views
clearButtonMode  property
leftView  property
leftViewMode  property
rightView  property
rightViewMode  property
Accessing the Delegate
delegate  property

Drawing and Positioning Overrides
– textRectForBounds:
– drawTextInRect:
– placeholderRectForBounds:
– drawPlaceholderInRect:
– borderRectForBounds:
– editingRectForBounds:
– clearButtonRectForBounds:
– leftViewRectForBounds:
– rightViewRectForBounds:

Replacing the System Input Views
inputView  property
inputAccessoryView  property
*/