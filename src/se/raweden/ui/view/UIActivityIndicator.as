package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import se.raweden.core.core;
	
	/**
	 * A <code>UIActivityIndicator</code> view 
	 * 
	 * @copyright Copyright 2011 Raweden. All rights reserved.
	 * @author Raweden
	 */	
	public class UIActivityIndicator extends UIView{
		
		use namespace core;
		
		//
		// TODO: clean up this class, and alternativly add another apporach to the implementation.
		//
		
		public static const STYLE_PINS:String = "pins";
		public static const STYLE_DOTS:String = "dots";
				
		protected var content:Sprite = new Sprite();
		protected var timer:Timer;
		protected var style:String;
		private var _slices:uint;
		private var _radius:uint;
		
		
		public function UIActivityIndicator(parent:DisplayObjectContainer,style:String = "pins"){
			super(parent);
			if(style == "pins"){
				_slices = 12;
				_radius = 6;	
			}else{
				_slices = 8;
				_radius = 8;	
			}
			this.style = style;
			addChidren();
			init();
			//
			if(stage){
				onAddedToStage(null);
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
			}
		}
		
		public function addChidren():void{
			this.addChild(content);
		}
		
		private function init():void{
			resize(32,32);
			this.invalidate("build");
			render();
		}
		
// // // // // // // // // // // // // 
// EVENT METHODS
		
		// when Preloader instace is added to stage
		private function onAddedToStage(event:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			timer = new Timer(80);
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			timer.start();
		}
		// when Preloader instace is removed from stage
		private function onRemovedFromStage(event:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			timer.reset();
			timer.removeEventListener(TimerEvent.TIMER,onTimer);
			timer = null;
		}
		// when timer completes a delay
		private function onTimer(event:TimerEvent):void{
			// rotates the spinner around, when it goes a hole 360 dregress its starts over from a zero based value.
			content.rotation = (content.rotation+(360/slices))%360;
		}
		
// // // // // // // // // // // // // 
// PARAMETERS METHODS
		
		// sets the number of slices in the spinner
		public function set slices(value:uint):void{
			_slices = value;
			this.invalidate("build");
		}
		// returns the current number of slices
		public function get slices():uint{
			return(_slices);
		}
		
		// sets the spinner's radius
		public function set radius(value:uint):void{
			_radius = value;
			this.invalidate("build");
		}
		// returns the current radius
		public function get radius():uint{
			return(_radius);
		}
		
// // // // // // // // // // // // // 
// GENNERAL METHODS
		
		/**
		 * Start the spinning of the preloader.
		 */
		public function start():void{
			timer.stop();
		}
		
		/**
		 * Stops the spinning of the preloader.
		 */
		public function stop():void{
			timer.stop();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			timer.removeEventListener(TimerEvent.TIMER,onTimer);
			timer.stop();
			timer = null;
			if(this.contains(content)){
				this.removeChild(content);
			}
			clear();
			content = null;
			// destoying super implemenentation.
			super.dispose();
		}
		
// // // // // // // // // // // // // 
// GRAPHICAl RENDER

		/**
		 * @inheritDoc
		 */
		override protected function layout(rect:Rectangle):void{
			content.width = rect.width;
			content.height = rect.height;
			content.x = rect.width/2;
			content.y = rect.height/2;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			if(this.isInvalidated("build")){
				this.clear();
				this.build();
			}
		}
		
		private function build():void{
			var i:int = _slices;
			var degrees:int = 360/_slices;
			while(i--){
				var slice:Shape = getSlice();
				slice.alpha = Math.max(0.2, 1 - (0.1 * i));
				var radianAngle:Number = (degrees*i)*Math.PI/180;
				slice.rotation = -degrees*i;
				slice.x = Math.sin(radianAngle)*_radius;
				slice.y = Math.cos(radianAngle)*_radius;
				content.addChild(slice);
			}
		}
		
		// clears all the slices
		private function clear():void{
			var len:uint = content.numChildren;
			for(var i:uint = 0;i<len;i++){
				content.removeChildAt(0);
			}
		}
		
		// constructs a slice
		private function getSlice():Shape{
			var slice:Shape = new Shape();
			if(style == "pins"){
				slice.graphics.beginFill(0x666666);
				slice.graphics.drawRoundRect(-1, 0, 2, 6,2,2);
			}else{
				slice.graphics.beginFill(0x666666);
				slice.graphics.drawEllipse(-2.5,-2.5,5,5);
			}
			slice.graphics.endFill();
			return(slice);
		}
		

	}
}