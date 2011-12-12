package se.raweden.ui.desktop
{
	import flash.display.Bitmap;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import se.raweden.ui.events.UIDragEvent;

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
	public final class UIDragging{
				
		//
		// TODO: add api for sliding images relative to the current destination when under update.
		// TODO: clean up after a dragging session is Completed.
		// TODO: allow alternative dragging image update.
		// TODO: allow images to be animated to destination cordinates as the images are alternativly updated.
		// TODO: fix begin dragging bug, the image is offset from the last offset used.
		// TODO: add support for sliding dragging images to specific location when dropped (m_destinationLocation).
		// TODO: add state indicator for whether the current session is under update.
		// TODO: implement onEnterFrame in instance to allow slideback while begining a new drag.
		//
				
		private var m_pasteboard:UIPasteboard;
		private var m_event:MouseEvent;
		private var m_items:Array;
		private var m_offset:Point;
		private var m_sequence:int = -1;
		private var m_location:Point = new Point();
		private var dragging:Boolean = false;
		private var sourceLocation:Point;
		private var source:InteractiveObject;
		private var m_render:Bitmap;
		// public vars.
		public var slideBack:Boolean = false;
		
		private var m_formation:String = UIDraggingFormation.NONE;
		private var m_images:Array;
		
		/**
		 * 
		 * @param	pasteboard
		 * @param	images
		 * @param	operation
		 */
		public function UIDragging(pasteboard:UIPasteboard,images:Array,operation:int = 0){
			m_pasteboard = pasteboard;
			m_images = images;
		}
		
		//------------------------------------
		// Getting Attributes
		//------------------------------------
		
		/**
		 * A <code>UIPasteboard</code> representing the resource being dragged.
		 */
		public final function get pasteboard():UIPasteboard{
			return m_pasteboard;
		}
		
		/**
		 * A integer representing the operations that can be applied to <code>UIPasteboard</code> instance.
		 * 
		 * @see UIDraggingOperation
		 */
		public final function get operation():int{
			return int.MAX_VALUE;
		}
				
		/**
		 * 
		 */
		public final function get images():Array{
			return m_images.concat();
		}
		
		/**
		 * Determines the formation in which the dragging images are arranged.
		 * 
		 * @see UIDraggingFormation
		 */
		public final function set formation(value:String):void{
			if(value != m_formation){
				if(m_session == this){
					UIDragging.setFormation(value,true);
				}
				m_formation = value;
			}
		}
		// returns the current formation value.
		public final function get formation():String{
			return m_formation;
		}		
		
		//------------------------------------
		// Identifying the Dragging Session.
		//------------------------------------
		
		/**
		 * A sequence number that is uniqe for this dragging session.
		 * This property is set after dragging have begun by calling the <code>beginDragging()</code> method.
		 * 
		 * @default <code>-1</code>
		 */
		public final function get sequence():uint{
			return m_sequence;
		}
		
		//------------------------------------
		// Dragging Session Localtion Attributes.
		//------------------------------------

		/**
		 * The current dragging location relative to the <code>stage</code>. 
		 * This property will always return <code>null</code> when the <code>UIDragging</code> instance isn't active.
		 */
		public final function get location():Point{
			return m_session == this ? m_location.clone() : null;
		}
		
		/**
		 * 
		 */
		public final function set draggingOffset(value:Point):void{
			m_offset = value;
		}
		// returns the dragging offset.
		public final function get draggingOffset():Point{
			return m_offset;
		}
		
		//------------------------------------
		// Managing Images.
		//------------------------------------
		
		/**
		 * Enumerates trough all items on the <code>UIPasteboard</code> to update the dragging images. 
		 * 
		 * @param	view
		 * @param	callback
		 */
		public final function enumerateDraggingImages(view:InteractiveObject,callback:Function):void{
			
		}
		
		/**
		 * 
		 * @param	view
		 * @param	x
		 * @param	y
		 */
		public final function slideTo(view:InteractiveObject,x:Number,y:Number):void{
			
		}
		
		//------------------------------------
		// Instance Based Respondint to User Interaction while Dragging.
		//------------------------------------
				
		private function onEnterFrame(e:Event):void{
			var x:Number;
			var y:Number;
			if(dragging){
				x = m_stage.mouseX;
				y = m_stage.mouseY;
			}else{
				x = m_location.x;
				y = m_location.y;
			}
			// Determine the location change, and applies easing effect.
			x = ((x-m_offset.x)-m_render.x)/EASE;
			y = ((y-m_offset.y)-m_render.y)/EASE;
			//trace("x:",x,", y:",y);
			// Updates the position, and kills the loop if destination where reached when not dragging.
			if(x != 0 && y != 0){
				m_render.x += x;
				m_render.y += y;
			}else if(!dragging){
				m_stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				clear();
			}
		}
		
		private function clear():void{
			if(m_stage.contains(m_render)){
				m_stage.removeChild(m_render);
			}
		}
		
		
				
		//------------------------------------
		// Global Implementation.
		//------------------------------------
		
		/**
		 * A Boolean value that determine whether the user is currently dragging a session.
		 */
		public static function get isDragging():Boolean{
			return m_session != null;
		}
		
		//------------------------------------
		// Private Implementation
		//------------------------------------
		
		// Session Related.
		private static const EASE:Number = 4.5;
		private static var m_session:UIDragging;
		private static var m_slideBack:Boolean;
		private static var m_currentSequence:int = 0;
		// Image Related 
		private static var m_image:Bitmap = new Bitmap();
		private static var m_images:Array = new Array();
		private static var m_formation:String;
		// Source Related.
		private static var m_source:InteractiveObject;
		private static var m_sourceLocation:Point;
		// Destination Related.
		private static var m_destination:InteractiveObject;
		// User Interaction Related.
		//private static var m_location:Point = new Point(-1,-1);
		private static var vx:Number = 0;
		private static var vy:Number = 0;
		private static var m_mouse:Point;
		private static var m_stage:Stage;
		
		/**
		 * TODO: better documentation here.
		 * 
		 * @param	session The dragging session be initilized
		 * @param	source The source view from which the dragging accoured.
		 * @param	images The images to be representing the data of the pasteboard.
		 * @param	event The <code>MouseEvent</code> that triggerd the dragging.
		 */
		public static function beginDragging(session:UIDragging,source:InteractiveObject,images:Array,event:Event):void{
			// Getting Stage not already set.
			if(!m_stage){
				m_stage = source.stage;
			}
			// TODO: throw error if stage is null on source.
			
			session.dragging = true;
			session.m_images = images;
			// adding stage listeners.			
			m_stage.addEventListener(Event.ENTER_FRAME,session.onEnterFrame);
			m_stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			m_stage.addEventListener(MouseEvent.MOUSE_MOVE,onDragUpdate);
			m_stage.addEventListener(MouseEvent.MOUSE_UP,onDragEnd);
			m_stage.addEventListener(MouseEvent.MOUSE_OVER,onDragEnter);
			m_stage.addEventListener(MouseEvent.MOUSE_OUT,onDragExit);
			m_stage.addEventListener(Event.MOUSE_LEAVE,onMouseLeave);
			// Creating location reference for source offset.
			var mouse:Point = new Point(m_stage.mouseX,m_stage.mouseY);
			m_sourceLocation = mouse.clone();
			m_mouse = mouse;
			// Temporary implementation for handling dragging images.
			var images:Array = session.m_images;
			if(images && images.length > 0){
				session.m_render = new Bitmap(images[0]);
				m_stage.addChild(session.m_render);
				if(session.draggingOffset){
					session.m_render.x = mouse.x-session.draggingOffset.x;
					session.m_render.y = mouse.y-session.draggingOffset.y;
				}else{
					session.m_render.x = mouse.x;
					session.m_render.y = mouse.y;
				}
			}
			// Referencing Source and Session.
			m_session = session;
			m_source = source;
			// Determine session uniqe sequence id.
			session.m_sequence = m_currentSequence;
			m_currentSequence++;
		}
		
		//------------------------------------
		// Responding to User Interaction while Dragging.
		//------------------------------------
		
		/**
		 * Listener that determine mouse velocity while dragging in a enterframe loop.
		 */
		private static function onEnterFrame(e:Event):void{
			// Carculates the current dragging velocity.
			var x:int = m_stage.mouseX;
			var y:int = m_stage.mouseY;
			vx = x-m_mouse.x;
			vy = y-m_mouse.y;
			m_mouse.x = x;
			m_mouse.y = y;
			// TODO: Determine if the current destionation is a posible drop destination by the current velocity.
		}
		
		/**
		 * Triggerd when the mouse moves while dragging.
		 */
		private static function onDragUpdate(e:Event):void{
			var x:int = m_stage.mouseX;
			var y:int = m_stage.mouseY;
			// Updating the location.
			m_session.m_location.x = x;
			m_session.m_location.y = y;
		}
		
		/**
		 * Triggerd when the dragging is entering the bounds of an InteractiveObject.
		 */
		private static function onDragEnter(e:MouseEvent):void{
			var target:IDraggingDestination = e.target is InteractiveObject ? e.target as IDraggingDestination : null;
			if(target){
				var accepted:Boolean = target.acceptsDrop(m_session);
				if(target && accepted)
					m_destination = target as InteractiveObject;	
			}
			//trace("dragging did enter:",target,"accepted:",accepted);
		}
		
		/**
		 * Triggerd when the dragging is exiting the bounds of an InteractiveObject.
		 */
		private static function onDragExit(e:MouseEvent):void{
			var target:IDraggingDestination = e.target is InteractiveObject ? e.target as IDraggingDestination : null;
			if(target == m_destination){
				m_destination = null;
			}
			//trace("dragging did exit:",target);
		}
		
		/**
		 * Listener that is triggerd when the pointer is released while dragging.
		 */
		private static function onDragEnd(e:MouseEvent):void{
			// Removes event listeners.
			m_stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			m_stage.removeEventListener(MouseEvent.MOUSE_MOVE,onDragUpdate);
			m_stage.removeEventListener(MouseEvent.MOUSE_UP,onDragEnd);
			m_stage.removeEventListener(MouseEvent.MOUSE_OVER,onDragEnter);
			m_stage.removeEventListener(MouseEvent.MOUSE_OUT,onDragExit);
			m_stage.addEventListener(Event.MOUSE_LEAVE,onMouseLeave);
			// Validates if the dragging pasteboard can be dropped over the current location.
			var local:Array = m_stage.getObjectsUnderPoint(m_session.m_location);
			var destination:IDraggingDestination;
			var valid:Boolean = false;
			for(var i:int = 0;i<local.length;i++){
				var target:InteractiveObject = local[i] as InteractiveObject;
				if(target is IDraggingDestination && IDraggingDestination(target).acceptsDrop(m_session)){
					destination = target as IDraggingDestination;
					break;
				}
			}
			// Sends the dragging pasteboard to valid destionation if found.
			if(destination){
				destination.dispatchEvent(new UIDragEvent(UIDragEvent.DRAG_DROP,m_session,m_session.m_location.clone()));
				// TODO: determine whether session's enterframe should keep firing.
				m_session.clear();
			}else if(m_session.slideBack){
				m_session.m_location.x = m_sourceLocation.x;
				m_session.m_location.y = m_sourceLocation.y;
			}else{
				m_stage.removeEventListener(Event.ENTER_FRAME,m_session.onEnterFrame);
				m_session.clear();
			}
			// Cleaning up after dragging session.
			m_destination = null;
			m_session.dragging = false;
			m_source = null;
			
			log("dragging did end - destination:",destination);	// remove this!
		}
				
		/**
		 * Listener that is triggerd when mouse leaves the stage area, this aborts the current drag.
		 */
		private static function onMouseLeave(e:Event):void{
			if(m_session){
				if(m_session.slideBack){
					m_session.m_location.x = m_sourceLocation.x;
					m_session.m_location.y = m_sourceLocation.y;
				}else{
					m_stage.removeEventListener(Event.ENTER_FRAME,m_session.onEnterFrame);
					m_session.clear();
				}
			}
		}
		
		//------------------------------------
		// Managing Dragging Formation.
		//------------------------------------
		
		/**
		 * 
		 * @param	formation
		 * @param	animated
		 */
		private static function setFormation(formation:String,animated:Boolean):void{
			var images:Array = m_images;
			var image:Bitmap;
			var len:int = images.length;
			var x:Number = 0;
			var y:Number = 0;
			if(formation == UIDraggingFormation.LIST){
				for (var i:int = 0; i < len; i++) {
					image = m_images[i];
					// arranges all images in a horizontal list.
					image.x = x;
					image.y = y;
					// incresses the x cordinate.
					x += image.width+10;
				}
				m_formation = formation;
			}else if (formation == UIDraggingFormation.NONE) {
				
				m_formation = formation;
			}else if(formation == UIDraggingFormation.PILE){

				m_formation = formation;
			}else if(formation == UIDraggingFormation.STACK){
				
				m_formation = formation;
			}
		}
		
		
	}
}