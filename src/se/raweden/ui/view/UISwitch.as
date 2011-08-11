//
//	UISwitch.as
//	Core UI Framework
//
//	Created by Raweden on 2011-05-22
//	Copyright 2011 Raweden. Some rights reserved.
//

package se.raweden.ui.view
{
	import caurina.transitions.Tweener;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * A <code>UISwitch</code> component manages an boolean On/Off state.
	 * 
	 * <p>Switch component are offen used in user preferences for manipulate Boolean value, 
	 * when the user manipulates by dragging/flipping the switch the component dispatches a
	 * event indicating that it have been chaged.</p>
	 * 
	 * @author Raweden
	 */
	public class UISwitch extends UIControl{
		
		// value references.
		private var m_on:Boolean = false;
		private var m_hitX:int
		private var m_dragging:Boolean = false;
		
		/** @private */
		protected var _track:Sprite;
		/** @private */
		protected var _thumb:Sprite;
		/** @private */
		protected var _mask:Sprite;
		
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
		}
		
		// creates and adds the child display objects of this component.
		private function addChildren():void{
			// creating the track.
			_track = new Sprite();
			_track.y = 1;
			_track.addEventListener(MouseEvent.DOUBLE_CLICK,onTrackDoubleClick);
			_track.doubleClickEnabled = true;
			// creating the handle(thumb).
			_thumb = new Sprite();
			_thumb.x = 26;
			_thumb.y = -1;
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN,dragStart);
			_track.addChild(_thumb);
			this.addChild(_track);
			// creating the mask.
			_mask = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0,0,52,22);
			_mask.graphics.endFill();
			_track.mask = _mask;
			this.addChild(_mask);
		}
		
		// initilizes this component instance.
		private function init():void{
			resize(100,16);
			// starting listing to when the switch is removed and added to the stage.
			if(stage){
				this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			}
		}
		
		//------------------------------------
		// Responding to View Stack Changes.
		//------------------------------------
		
		// triggerd when the component is added to stage.
		private function onAddedToStage(e:Event):void{
			// cycle the events.
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		// triggerd when the component is removed from stage.
		private function onRemovedFromStage(e:Event):void{
			// aborts any ongoing draging (removes listners used under the dragging.)
			if(m_dragging){
				dragStop(null);
			}
			// cycle the events.
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
		}
		
		//------------------------------------
		// Responding to User Interaction
		//------------------------------------
			
		// triggerd when the track is double click.. this inverts the on state of the switch.
		private function onTrackDoubleClick(e:Event):void{
			if(e.target == _track){
				on = !on;	
			}
		}
		
		// triggerd when the user presses down the handle.
		private function dragStart(e:MouseEvent):void{
			m_hitX = _track.mouseX;
			m_dragging = true;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,dragMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,dragStop);
		}
		
		// triggerd when the mouse moves over the stage after the handle have been pressed down.
		private function dragMove(e:MouseEvent):void{
			var v:int = mouseX-m_hitX;
			v = v < -27 ? -27 : v;
			v = v > 0 ? 0 : v;
			_track.x = v;
			e.updateAfterEvent();
		}
		
		// triggerd when the mouse relases over the stage after the handle have been pressed down.
		private function dragStop(e:MouseEvent):void{
			// removes listners used under the dragging.
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,dragMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,dragStop);
			m_dragging = false;
			// sets the value and visuals based on which side the handle is closest to.
			var x:int = _track.x;
			var selected:Boolean = _track.x > -13;
			m_on = selected;
			if(x == 0 || x == - 27)return;
			if(selected){
				Tweener.addTween(_track,{x:0,time:0.3});
			}else{
				Tweener.addTween(_track,{x:-27,time:0.3});
			}
		}
				
		//------------------------------------
		// Setting the Off/On State
		//------------------------------------
		
		/**
		 * Specifies if the switch is On or Off.
		 * 
		 * <p>The state change is automaticly animated if the UISwitch is on the display
		 * list, otherwise the positon of the thumb is set.</p>
		 * 
		 * @default <code>false</code>
		 */
		public function set on(value:Boolean):void{
			if(value == m_on)return;
			m_on = value;
			var animated:Boolean = this.stage != null;
			var x:int = value ? 0 : -27;
			// if animated.
			if(animated){
				Tweener.addTween(_track,{x:x,time:0.3});
			}// else we just set a new x positon.
			else{
				_track.x = x;
			}
			
		}
		// returns if the Switch is currently selected.
		public function get on():Boolean{
			return(m_on);
		}
				
		//------------------------------------
		// Updating Content Displayed.
		//------------------------------------
		
		/**
		 * @private;
		 */
		override protected function draw(rect:Rectangle):void{
			// drawing the track.
			_track.graphics.clear();
			_track.graphics.beginFill(0xCCCCCC);
			_track.graphics.drawRect(0,0,78,20);
			_track.graphics.endFill();
			// drawing the thumb.
			_thumb.graphics.clear();
			_thumb.graphics.beginFill(0xEDEDED);
			_thumb.graphics.drawRect(0,0,26,22);
			_thumb.graphics.endFill();
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
			// removing listners.
			_track.removeEventListener(MouseEvent.DOUBLE_CLICK,onTrackDoubleClick);
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN,dragStart);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
				
	}
}