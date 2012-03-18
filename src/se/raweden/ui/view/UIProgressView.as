package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	/**
	 * A <code>UIProgressView</code> view 
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */	
	public class UIProgressView extends UIView{
		
		//
		// TODO: add alternatives for customization.
		//
		
		private var _progress:Number = 0;
		
		public function UIProgressView(parent:DisplayObjectContainer = null, frame:Rectangle = null){
			super(parent, frame);
			// sets the default size.
			resize(120,14);
		}
		
		/**
		 * The current progress.
		 * 
		 * <p>The current progress is represented by Number value between <code>0.0</code> and <code>1.0</code>,
		 * where <code>1.0</code> indicates the completion of the task. values less than <code>0.0</code> and 
		 * greater than <code>1.0</code> are pinned to those limits.</p>
		 * 
		 * @default <code>0.0</code>
		 */
		public function set progress(value:Number):void{
			// constraing the input value.
			value = value < 0 ? 0 : value;
			value = value > 1 ? 1 : value;
			// setting value.
			if(value != _progress){
				_progress = value;	
				this.needsDraw();
			}
		}
		// returns the value of the progress attribute.
		public function get progress():Number{
			return _progress;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function draw(rect:Rectangle):void{
			// just a simple drawing.. nothing fancy with this preloader yet.
			this.graphics.clear();
			// drawing the border.
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0,0,rect.width,rect.height);
			this.graphics.drawRect(1,1,rect.width-2,rect.height-2);
			this.graphics.endFill();
			// drawing the progress fill.
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(2,2,Math.round((rect.width-4)*_progress),rect.height-4);
		}
		
		//------------------------------------
		// Deconstruction
		//------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void{
			super.dispose();
		}

	}
}