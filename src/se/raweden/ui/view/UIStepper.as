package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	/**
	 * A <code>UIStepper</code> component consits of two small arrows that increment and decrement a value that apperas beside it.
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIStepper extends UIControl{
		
		private var _max:Number;
		private var _min:Number;
		private var _increment:Number;
		private var _value:Number;
		// sub components.
		private var add:UIButton;
		private var sub:UIButton;
		private var display:UITextField;
		
		public function UIStepper(parent:DisplayObjectContainer = null, bounds:Rectangle = null){
			super(parent, bounds);
		}

		//------------------------------------
		// Getting and Setting Attributes.
		//------------------------------------
		
		/**
		 * 
		 */
		public function set max(value:Number):void{
			
		}
		// returns the value of the max attribute.
		public function get max():Number{
			return _max;
		}
		
		/**
		 * 
		 */
		public function set value(value:Number):void{
			
		}
		// returns the value of the value attribute.
		public function get value():Number{
			return _value;
		}
		
		/**
		 * 
		 */
		public function set min(value:Number):void{
			
		}
		// returns the value of the min attribute.
		public function get min():Number{
			return _min;
		}
		
		/**
		 * 
		 */
		public function set increment(value:Number):void{
			
		}
		// returns the value of the increment attribute.
		public function get increment():Number{
			return _increment;
		}
		
		//------------------------------------
		// Updating Content Displayed.
		//------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout(rect:Rectangle):void{
			
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