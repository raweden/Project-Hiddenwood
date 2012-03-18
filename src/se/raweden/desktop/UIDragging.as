package se.raweden.desktop
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import se.raweden.events.UIDragEvent;

	/**
	 * A <code>UIDragging</code> manages drag and drop operations, which let you move data
	 * from one place to another in a flash application. 
	 * 
	 * <p>For example, you can select an object, such as a item in a list and then drag it
	 * onto another view component to add or manage it in that view. One or multible 
	 * thumbnails can be provided to represent the data as it is dragged over the stage.</p>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIDragging{
		
		// Constants
		private static const EASE:Number = 4.5;
		
		//
		private static var currentSequence:int = 0;
		private static var currentDestination:InteractiveObject;
		private static var stage:Stage;
		private static var session:UIDragging;
		private static var location:Point = new Point();
		
		private static var vx:Number = 0;
		private static var vy:Number = 0;		
		
		// private reference variables.
		private var source:InteractiveObject;
		private var dragging:Boolean = false;
		private var content:Bitmap;
		private var offset:Point = new Point();
		// getters (setters) reference
		private var _resource:UIPasteboard;
		private var _location:Point;
		private var _sequence:int = -1;
		
		/**
		 * Constructor. use <code>UIDragging.beginDragging()</code> instead.
		 * 
		 * @param	pasteboard
		 * @param	images
		 * @param	operation
		 */
		public function UIDragging(){
		
		}
		
		// Getters
		
		/**
		 * A <code>UIPasteboard</code> representing the resource being dragged.
		 */
		public final function get resource():UIPasteboard{
			return _resource;
		}
		
		/**
		 * A integer representing the operations that can be applied to <code>UIPasteboard</code> instance.
		 */
		public final function get operation():int{
			return int.MAX_VALUE;
		}
		
		// Private methods.
		
		private function onEnterFrame(e:Event):void{
			var x:Number;
			var y:Number;
			// Getting actual position..
			if(dragging){
				x = stage.mouseX;
				y = stage.mouseY;
			}else{
				x = _location.x;
				y = _location.y;
			}
			// easing a bit to the new position.
			x = ((x-offset.x)-content.x)/EASE;
			y = ((y-offset.y)-content.y)/EASE;
			
			// determine whether the dragging have reach it's destination 
			if(x != 0 && y != 0){
				content.x += x;
				content.y += y;
			}else if(!dragging){
				// stopping the slide back animation.
				stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				
				// removes the drag image from stage.
				if(content.parent){
					content.parent.removeChild(content);
				}
				
			}
		}
		
		
		/**
		 * 
		 */
		private final function cancel(slideback:Boolean = true):void{
			var loc:Point = source.localToGlobal(new Point());
			_location.x = loc.x;
			_location.y = loc.y;
		}

		/**
		 * TODO: better documentation here.
		 * 
		 * @param source The source view from which the dragging accoured.
		 * @param resource The pasteboard holding the data of the drag.
		 * @param event The <code>MouseEvent</code> that triggerd the dragging.
		 */
		public static function beginDragging(source:InteractiveObject,resource:UIPasteboard,event:Event):UIDragging{
			
			// TODO: add support for gestures in from the se.raweden.ui.gesture
			
			// getting stage reference, if not set.
			if(stage){
				stage = source.stage;
			}
			
			// setting up listeners to stage.
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onDragUpdate);
			stage.addEventListener(MouseEvent.MOUSE_UP,onDrop);
			stage.addEventListener(MouseEvent.MOUSE_OVER,onDragEnter);
			stage.addEventListener(MouseEvent.MOUSE_OUT,onDragExit);
			stage.addEventListener(Event.MOUSE_LEAVE,onExit);
			
			// creating session object.
			var session:UIDragging = new UIDragging();
			session.source = source;
			session._resource = resource;
			session._sequence = currentSequence++;
			
			stage.addEventListener(Event.ENTER_FRAME,session.onEnterFrame);	
			
			UIDragging.session = session;
			
			return session;
		}
		
		
		/**
		 * A Boolean value that determine whether the user is currently dragging a session.
		 */
		public static function get isDragging():Boolean{
			return false;
		}
		
		//------------------------------------
		// Responding to User Interaction while Dragging.
		//------------------------------------
		
		/**
		 * Triggerd at the framerate to determine the mouse move velocity.
		 */
		private static function onEnterFrame(e:Event):void{
			var x:int = stage.mouseX;
			var y:int = stage.mouseY
			// carculates the delta since last frame.
			vx = x-location.x;
			vy = y-location.y;
			// setting reference to current position.
			location.x = x;
			location.y = y;
		}
		
		/**
		 * Triggerd when the mouse moves while dragging.
		 */
		private static function onDragUpdate(e:Event):void{
			var x:int = stage.mouseX;
			var y:int = stage.mouseY;
			
			// updates the mouse location on the session object.
			session._location.x = x;
			session._location.y = y;
		}
		
		/**
		 * Triggerd when the dragging is entering the bounds of an InteractiveObject.
		 */
		private static function onDragEnter(e:MouseEvent):void{
			var target:InteractiveObject = e.target as InteractiveObject;
			
			if(target && target.hasEventListener(UIDragEvent.DRAG_DROP) == true){
				// TODO: set reference to posible destionation here.
				currentDestination = target;
			}			
		}
		
		/**
		 * Triggerd when the dragging is exiting the bounds of an InteractiveObject.
		 */
		private static function onDragExit(e:MouseEvent):void{
			var target:InteractiveObject = e.target as InteractiveObject;
			
			if(target && target == currentDestination){
				currentDestination = null;
			}
			
		}
		
		/**
		 * Triggerd when the mouse down is released while dragging.
		 */
		private static function onDrop(e:MouseEvent):void{
		
			var views:Array = stage.getObjectsUnderPoint(session._location);
			trace(views);
			var event:UIDragEvent;
			
			if(!currentDestination){
				return;
			}
			
			event = new UIDragEvent(UIDragEvent.DRAG_DROP,null,location,session._resource);
			
			currentDestination.dispatchEvent(event);
			
			// removes the critical event listners that where added when drag where started.
			stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onDragUpdate);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_OVER,onDragEnter);
			stage.removeEventListener(MouseEvent.MOUSE_OUT,onDragExit);
			stage.addEventListener(Event.MOUSE_LEAVE,onExit);
			
			if(event.isDefaultPrevented() == true){
				// drop where accepted.
				
			}else{
				// slide back animation.
				session.dragging = false;
			}
		}
		
		/**
		 * Triggerd when the mouse pointer leaves the flash stage, while dragging.
		 */
		private static function onExit(e:Event):void{
			session.cancel();
		}
		
		
	}
}