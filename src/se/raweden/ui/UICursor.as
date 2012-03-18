package se.raweden.ui
{
	import flash.display.BitmapData;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import se.raweden.ui.events.UIScrollEvent;

	import flash.ui.MouseCursorData;
	
	/**
	 * Description
	 *
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UICursor{
		
		// JavaScript injection.
		//[Embed(source="../../../../assets/injection/UIMouse.js", mimeType="application/octet-stream")]
		//private static const WALK_AROUND:Class;
		
		// initlizes the static interface.
		{
			// adding and replacing default cursor.
			//UICursor.addCursor(MouseCursor.ARROW,null);		
			
			// setting up mouse-whell walkaround.
			if (ExternalInterface.available) {
				// adding callback for this on the flash object.
				ExternalInterface.addCallback( "scrollEvent", onExternalDelta);
				ExternalInterface.call("setupScrolling", ExternalInterface.objectID);
				/*
				// injecting the JavaScript from ByteArray.
				ExternalInterface.call("eval", new WALK_AROUND().toString());
				// initlize the JavaScript interfaec.
				*/
				log("- platform: object-id = "+ExternalInterface.objectID);
			}
		}
		
		private static var _hidden:Boolean = false;
		private static var _hiddenUntilMove:Boolean = false;
		private static var _stage:Stage;
		private static var _focus:InteractiveObject;
		
		public static function initilize(stage:Stage):void{
			if(stage){
				stage.addEventListener(MouseEvent.MOUSE_OVER,onMouseEvent);
				stage.addEventListener(MouseEvent.MOUSE_OUT,onMouseEvent);
				_stage = stage;	
			}
		}
		
		// instance impl.
		private var data:MouseCursorData;
		
		public function UICursor(image:BitmapData,hotSpot:Point){
			
		}
		
		//------------------------------------
		// Managing Delta Scroll.
		//------------------------------------
		
		private static function onExternalDelta(deltaX:Number,deltaY:Number):void{
			//log("UICursor-scroll - deltaX: "+deltaX+" ,deltaY: "+deltaY);
			if(_focus)
				_focus.dispatchEvent(new UIScrollEvent(UIScrollEvent.SCROLL,true,true,deltaX,deltaY));
		}
		
		private static function onMouseEvent(e:MouseEvent):void{
			//log("UICursor-change: "+e.type+" ,target: "+e.target);
			_focus = e.target as InteractiveObject;
		}
		
		private static function onMouseMove(e:MouseEvent):void{
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			_hiddenUntilMove = false;
			Mouse.show();
		}
		
		//------------------------------------
		// Managing Cursors.
		//------------------------------------
		
		public static function addCursor(name:String,cursor:UICursor):void{
			Mouse.registerCursor(name,cursor.data);
		}
		
		// Getting Pointer Support Attributes.
		
		public static function get isSupported():Boolean{
			return Mouse.supportsCursor;
		}
		
		//------------------------------------
		// Managing Mouse Cursor visiblity.
		//------------------------------------
		
		/**
		 * Hides the mouse cursor until next mouse move.
		 */
		public static function hideUntilMove():void{
			if(!_hiddenUntilMove){
				Mouse.hide();
				_stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				_hiddenUntilMove = true;
			}
		}
		
		/**
		 * Unhides the mouse cursor.
		 * 
		 * <p>Calling this method doesn't affect the behavior of the <code>UICursor.hideUntilMove()</code> method.</p>
		 */		
		public static function show():void{
			if(!_hiddenUntilMove){
				Mouse.show();
			}
		}
		
		/**
		 * 
		 */		
		public static function hide():void{
			Mouse.hide();
		}
		
		/**
		 * 
		 */		
		public static function get isHidden():Boolean{
			return _hiddenUntilMove ? false : _hidden;
		}
		
	}
}