package se.raweden.ui.view
{	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import se.raweden.motion.Tween;
	
	/**
	 * A <code>UISwitch</code> component manages an boolean On/Off state.
	 * 
	 * <p>Switch component are offen used in user preferences for manipulate Boolean value, 
	 * when the user manipulates by dragging/flipping the switch the component dispatches a
	 * event indicating that it have been chaged.</p>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UISwitch extends UIControl{
		
		// THE EMBED BELLOW, shoulb not be done here!!!
		[Embed(source="../../../../../res/switch-bg.png")]
		private static var BACKGROUND:Class;
		private static var background:BitmapData = new BACKGROUND().bitmapData;
		
		[Embed(source="../../../../../res/switch-highlights.png")]
		private static var HIGHLIGHT:Class;
		private static var hightlight:BitmapData = new HIGHLIGHT().bitmapData;
		
		[Embed(source="../../../../../res/switch-knob.png")]
		private static var KNOB:Class;
		private static var knob:BitmapData = new KNOB().bitmapData;
		
		
		//
		// TODO: add default skin, and implementation to customize the Control.
		//
		
		// value references.
		private var _on:Boolean = false;
		private var hitX:int
		private var _dragging:Boolean = false;
		// composite elements.
		private var _track:Sprite;
		private var _thumb:Sprite;
		private var _mask:Shape;
		private var _highlight:Shape;
		
		/**
		 * Constructor - creates a new Switch instance.
		 * @param parent
		 * @param selected
		 */
		public function UISwitch(parent:DisplayObjectContainer = null){
			super(parent);
			// initilizes the component instance.
			addChildren();
			init();
			resize(70,29);
		}
		
		/**
		 * Creates and adds related view instances.
		 */
		private function addChildren():void{
			// adding the track.
			_track = new Sprite();
			_track.y = 1;
			_track.addEventListener(MouseEvent.DOUBLE_CLICK,onTrackDoubleClick);
			_track.doubleClickEnabled = true;
			this.addChild(_track);
			// adding shape to contain highlight.
			_highlight = new Shape();
			_highlight.blendMode = BlendMode.MULTIPLY;
			_highlight.y = 1;
			this.addChild(_highlight);
			// adding the dragging thumb.
			_thumb = new Sprite();
			_thumb.x = 40; // 26
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN,dragStart);
			this.addChild(_thumb);
			// adding the mask.
			_mask = new Shape();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRoundRect(0,0,70,28,28,28);
			_mask.graphics.endFill();
			_mask.y = 1;
			_track.mask = _mask;
			this.addChild(_mask);
		}
		
		/**
		 * Instance initilization.
		 */
		private function init():void{
			// starting listing to when the switch is removed and added to the stage.
			if(stage){
				this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			}
			// setting the default size.
			//resize(100,16);
		}
		
		//------------------------------------
		// Responding to View Stack Changes.
		//------------------------------------
		
		/**
		 * Triggerd when the component is added to stage.
		 */
		private function onAddedToStage(e:Event):void{
			// cycle the events.
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		/**
		 * Triggerd when the component is removed from stage.
		 */
		private function onRemovedFromStage(e:Event):void{
			// aborts any ongoing draging (removes listners used under the dragging.)
			if(_dragging){
				dragStop(null);
			}
			// cycle the events.
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
		}
		
		//------------------------------------
		// Responding to User Interaction
		//------------------------------------
			
		/**
		 * Triggerd when the track is double click.. this inverts the on state of the switch.
		 */
		private function onTrackDoubleClick(e:Event):void{
			if(e.target == _track){
				on = !on;	
			}
		}
		
		/**
		 * Triggerd when the user presses down the handle.
		 */
		private function dragStart(e:MouseEvent):void{
			hitX = _track.mouseX;
			_dragging = true;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,dragMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,dragStop);
		}
		
		/**
		 * Triggerd when the mouse moves over the stage after the handle have been pressed down.
		 */
		private function dragMove(e:MouseEvent):void{
			var v:int = mouseX-hitX;
			v = v < -40 ? -40 : v;
			v = v > 0 ? 0 : v;
			_track.x = v;
			_thumb.x = 40+v;
			e.updateAfterEvent();
		}
		
		/**
		 * Triggerd when the mouse relases over the stage after the handle have been pressed down.
		 */
		private function dragStop(e:MouseEvent):void{
			// removes listners used under the dragging.
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,dragMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,dragStop);
			_dragging = false;
			// sets the value and visuals based on which side the handle is closest to.
			if(x == 0 || x == - 40)return;
			setOn(_track.x > -20,true);
		}
				
		//------------------------------------
		// Setting the Off/On State
		//------------------------------------
		
		/**
		 * 
		 * 
		 * @param value
		 * @param animated
		 */
		public function setOn(value:Boolean,animated:Boolean):void{
			var x:int = value ? 0 : -40;
			// if animated.
			if(animated){
				Tween.to(_track,0.3,{x:x},{onUpdate:onUpdate}).start();
			}// else we just set a new x positon.
			else{
				_track.x = x;
			}
			_on = value;
		}
		
		/**
		 * Specifies if the switch is On or Off.
		 * 
		 * <p>The state change is automaticly animated if the UISwitch is on the display
		 * list, otherwise the positon of the thumb is set.</p>
		 * 
		 * @default <code>false</code>
		 */
		public function set on(value:Boolean):void{
			if(value != _on){
				setOn(value,stage != null);
			}
		}
		// returns the value of the on attribute.
		public function get on():Boolean{
			return _on;
		}
				
		/**
		 * Utility method that is invoked as the thumb is animated (this method moves the background).
		 */
		private function onUpdate():void{
			_thumb.x = 40+_track.x;
		}
		
		//------------------------------------
		// Updating Content Displayed.
		//------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			// drawing the track.
			_track.graphics.clear();
			_track.graphics.beginBitmapFill(background);
			//_track.graphics.beginFill(0xCCCCCC);
			_track.graphics.drawRect(0,0,124,28);
			_track.graphics.endFill();
			// drawing the thumb.
			_thumb.graphics.clear();
			_thumb.graphics.beginBitmapFill(knob);
			_thumb.graphics.drawRect(0,0,30,30);
			_thumb.graphics.endFill();
			// drawing highlight.
			_highlight.graphics.clear();
			_highlight.graphics.beginBitmapFill(hightlight);
			_highlight.graphics.drawRect(0,0,70,29);
			_highlight.graphics.endFill();
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
			// removing listners.
			_track.removeEventListener(MouseEvent.DOUBLE_CLICK,onTrackDoubleClick);
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN,dragStart);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
				
	}
}