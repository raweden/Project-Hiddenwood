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
	
	/**
	 * A <code>UITextField</code>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UITextField extends UIControl{
		
		//
		// TODO: add iOS style implementation for customize the images.
		// TODO: implement a custom way to show secure text input.
		//
		
		public static const PLACE_HOLDER_COLOR:uint = 0x808080;
		
		// general properties.
		private var _font:String;
		private var _textFormat:TextFormat = new TextFormat();
		private var _text:String;
		private var _textColor:uint = 0x000000;
		private var _textAlign:String;
		private var _secure:Boolean;
		private var _placeHolder:String;
		// configurating editing
		private var _editing:Boolean = false;
		private var _clearOnBeginEditing:Boolean = false;
		
		private var textField:TextField;
		
		public function UITextField(parent:DisplayObjectContainer = null, frame:Rectangle = null){
			super(parent, frame);
			addChildren();
			init();
		}
		
		/**
		 * Creates and adds related view instances.
		 */
		private function addChildren():void{
			textField = new TextField();
			textField.type = "input";
			textField.addEventListener(TextEvent.TEXT_INPUT,onTextInput);
			textField.addEventListener(FocusEvent.FOCUS_IN,onFocusChange);
			textField.addEventListener(FocusEvent.FOCUS_OUT,onFocusChange);
			textField.defaultTextFormat = new TextFormat("Arial",16,0x000000);
			this.addChild(textField);
		}
		
		/**
		 * Instance Initilization.
		 */
		private function init():void{
			// setting the default size.
			resize(320,24);
		}
		
		//------------------------------------
		// Responding to user Interaction.
		//------------------------------------
		
		private var delay:Timer;

		protected function onTextInput(e:TextEvent):void{
			if(_secure){
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
					if(_clearOnBeginEditing || textField.text == _placeHolder){
						textField.text = "";
						textField.textColor = _textColor;
					}
					// traces the state.
					trace(this,"focus in");
					_editing = true;
				}break;
				case FocusEvent.FOCUS_OUT : {
					// reverting to placeholder if empty.
					if(textField.text == ""){
						textField.text = _placeHolder;
						textField.textColor = PLACE_HOLDER_COLOR;
					}
					// traces the state.
					trace(this,"focus out");
					_editing = false;
				}
			}
		}
		
		//------------------------------------
		// Getting and Setting Attributes.
		//------------------------------------
		
		/**
		 * 
		 */
		public function set secure(value:Boolean):void{
			//_secure = value;
			textField.displayAsPassword = value;
		}
		// returns the value of the secure attribute.
		public function get secure():Boolean{
			return textField.displayAsPassword;
		}
		
		/**
		 * The String that is displayed when tere is no other text in the text field.
		 * 
		 * @default <code>null</code>
		 */
		public function set placeHolder(value:String):void{
			_placeHolder = value;
			if(textField.text == "" && !_editing){
				textField.text = value;
				textField.textColor = PLACE_HOLDER_COLOR;
			}
		}
		// returns the value of the placeHolder attribute.
		public function get placeHolder():String{
			return _placeHolder;
		}
		
		/**
		 * 
		 */
		public function set text(value:String):void{
			textField.text = value;
			needs("layout",layout);
			needs("draw",draw);
		}
		// returns the value of the text attribute.
		public function get text():String{
			return textField.text;
		}
		
		/**
		 * 
		 */
		public function set textAlign(value:String):void{
			value = value == "right" || value == "center" ? value : "left";
			_textFormat.align = _textAlign = value;
			textField.setTextFormat(_textFormat);
		}
		// returns the value of the textAlign attribute.
		public function get textAlign():String{
			return _textAlign;
		}

		/**
		 * 
		 */
		public function set textColor(value:uint):void{
			_textColor = value;
			if(textField.text != _placeHolder){
				textField.textColor = value;
			}
		}
		// returns the value of the textColor attribute.
		public function get textColor():uint{
			return _textColor;
		}

		/**
		 * 
		 */
		public function set font(value:String):void{
			_font = value;
			_textFormat.font = value;
			textField.setTextFormat(_textFormat);
		}
		// returns the value of the font attribute.
		public function get font():String{
			return _font;
		}

		/**
		 * 
		 */
		public function get editing():Boolean{
			return _editing;
		}

		/**
		 * 
		 */
		public function set clearOnBeginEditing(value:Boolean):void{
			_clearOnBeginEditing = value;
		}
		// returns the value of the clearOnBeginEditing attribute.
		public function get clearOnBeginEditing():Boolean{
			return _clearOnBeginEditing;
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