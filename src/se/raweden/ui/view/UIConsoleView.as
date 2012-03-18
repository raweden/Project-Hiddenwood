package se.raweden.ui.view
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import se.raweden.logging.ILogger;
	import se.raweden.logging.Level;
	import se.raweden.console.Console;
	import se.raweden.console.IConsoleClient;

	
	/**
	 * A <code>UIBashView</code> view provides a command-line interface.
	 *
	 * <p>Copyright 2011, Raweden. All Rights Reserved.</p>
	 *
	 * @author Raweden
	 */
	public class UIConsoleView extends UIScrollView implements IConsoleClient, ILogger{
		
		//
		// TODO: add support for drag-and-drop.
		// TODO: add support for blocking user interaction while the bash is currently working.
		//
		
		// default text that is shown when staring the command-line client.
		private static const DEFAULT_TEXT:String = "Core Console v0.6\n";
		private static const PROMT:String = ">";
		public static const VERSION:String = "0.6"
		
		private var _content:Sprite;
		// text-fields
		private var _output:TextField;
		private var _promt:TextField;
		private var _input:TextField;
		// bash client styling.
		private var _format:TextFormat;
		// basic state reference.		
		private var _focus:Boolean = false;
		
		private var m_enableLogging:Boolean = true;
		
		public function UIConsoleView(parent:DisplayObjectContainer = null){
			super(parent);
			addChildren();
			init();
		}
		
		/**
		 * Creates and adds related view instances.
		 */
		private function addChildren():void{
			_content = new Sprite();
			// Creating the text output.
			_output = new TextField();
			_output.wordWrap = true;
			_output.multiline = true;
			_output.selectable = false;	// TODO: change this later.. lock at the OS X terminal.
			_output.tabEnabled = false;
			_output.type = TextFieldType.DYNAMIC;
			_output.autoSize = TextFieldAutoSize.LEFT;
			_output.wordWrap = true;
			_content.addChild(_output);
			// Creating the promt field.
			_promt = new TextField();
			_promt.selectable = false;
			_promt.tabEnabled = false;
			_promt.type = TextFieldType.DYNAMIC;
			_promt.height = 17;
			_promt.width = 74;
			_content.addChild(_promt);
			// Creating the input field.
			_input = new TextField();
			_input.tabEnabled = false;
			_input.type = TextFieldType.INPUT;
			_input.autoSize = TextFieldAutoSize.LEFT;
			_input.height = 17;
			_content.addChild(_input);
			super.content = _content;
		}
		
		/**
		 * Instance initliziation.
		 */
		private function init():void{
			super.scrollEnabled = true;
			super.showHorizontalIndicator = false;
			// creating the default textformat.
			var tf:TextFormat = new TextFormat();
			tf.align = "left";
			tf.color = 0xCCCCCC;
			tf.font = "Menlo Regular";
			tf.size = 12;
			_format = tf;
			// applying the textformat on the fields.
			_output.defaultTextFormat = tf;
			_input.defaultTextFormat = tf;	
			_promt.defaultTextFormat = tf;
			// setting the promt and default client text.
			_promt.text = PROMT;
			write(DEFAULT_TEXT);
			write("-bash: sandbox: "+Security.sandboxType+"\n");
			// temporary code.
			//
			//stage.focus = _promt;
			this.addEventListener(FocusEvent.FOCUS_IN,onFocus);
			this.addEventListener(FocusEvent.FOCUS_OUT,onFocus);
		}
		
		private function onFocus(e:FocusEvent):void{
			if(e.type == FocusEvent.FOCUS_IN && !_focus){
				stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyboard);
				stage.focus = _promt;
				_focus = true;
				log(null,"focus in");
			}else if(e.type == FocusEvent.FOCUS_OUT && _focus){
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyboard);
				log(null,"focus out");
				_focus = false;
			}
		}
		
		//------------------------------------
		// Getting and Setting Attributes.
		//------------------------------------
		
		/**
		 * A <code>Boolean</code> value that determine whether logging is enabled in this console view
		 * instance.
		 */
		public function set enableLogging(value:Boolean):void{
			m_enableLogging = value;
		}
		// returns the value of the enableLogging attiribute.
		public function get enableLogging():Boolean{
			return m_enableLogging;
		}
		
		/**
		 * A <code>String</code> value that will be displayed in text as the promt characther.
		 */
		public function set promt(value:String):void{
			_promt.text = value;	
		}
		// returns the current promt text.
		public function get promt():String{
			return _promt.text;
		}
		
		
		//------------------------------------
		// IBashClient implementation.
		//------------------------------------
		
		/**
		 * @copy se.raweden.ui.bash.IBashClient#currentOutput
		 */
		public function get currentOutput():String{
			return _output.text;
		}
		
		/**
		 * @copy se.raweden.ui.bash.IBashClient#hide()
		 */
		public function hide():void{
			// TODO Auto Generated method stub	
		}
		
		/**
		 * @copy se.raweden.ui.bash.IBashClient#show()
		 */
		public function show():void{
			// TODO Auto Generated method stub	
		}
		
		/**
		 * @copy se.raweden.ui.bash.IBashOutput#clear()
		 */
		public function clear():void{
			_output.text = "";
			write("");
		}
		
		/**
		 * @copy se.raweden.ui.bash.IBashOutput#write()
		 */
		public function write(text:String):void{
			// appending the text.
			_output.appendText(text);
			// getting the new text promt and input positon.
			var y:int = _output.textHeight+3;
			var out:Boolean = false;
			/*
			if(y > height-20){
				out = true;
			}
			if(out != _out){
				_output.height = out ? height-20 : height;
				y = out ? height-17 : y;
				_out = out;
			}
			if(!out || out != _out){
				movePromt(y);
			}
			*/
			movePromt(y);
			// auto scrolls the text.
			//_output.scrollV = _output.maxScrollV;
			this.needsLayout();
		}
		
		private var _out:Boolean = false;
		
		private function movePromt(y:int):void{
			_promt.y = y;
			_input.y = y;
			_input.x = _promt.x + _promt.width+3;
			_input.width = width-_input.x-3;
		}
		
		//------------------------------------
		// ILogger implementation.
		//------------------------------------
		
		/**
		 * @copy se.raweden.logging.ILogger#log()
		 */
		public function log(level:Level, line:String):void{
			if(m_enableLogging){
				write(line+"\n");	
			}
		}

		//------------------------------------
		// Handles the execution and correction.
		//------------------------------------
		
		/**
		 * Handles the keyboard events to mnemic a terminal like behvaior.
		 */
		private function onKeyboard(e:KeyboardEvent):void{
			var code:uint = e.keyCode;
			switch(code){
				case Keyboard.ENTER:{
					exec();
					break;
				}
			}
		}
		
		/**
		 * Executes the current line in the console view, this is by default triggerd by the Enter key.
		 */
		private function exec():void{
			var line:String = _input.text;
			if(line == "")return;
			trace("exec:",line);
			_input.text = "";
			_input.setSelection(0,0);
			this.write(PROMT+" "+line+"\n");
			var result:String = Console.exec(line);
			trace(result);
		}
		
		//------------------------------------
		// Updating Content Displayed.
		//------------------------------------
				
		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			this.graphics.clear();
			this.graphics.beginFill(0x333333);
			this.graphics.drawRect(0,0,rect.width,rect.height);
			this.graphics.endFill();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout(rect:Rectangle):void{
			_output.width = rect.width;
			_output.height = rect.height;
			super.layout(rect);
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