package se.raweden.ui.view
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	/**
	 * A <code>UIProgressView</code> view 
	 * 
	 * 
	 * @author Raweden
	 */	
	public class UIProgressView extends UIView{
		
		/**
		 * Todo: Improve apperance of this view, instead of vetor boring style.. it should use bitmap graphics.
		 */
		
		private var m_progress:Number
		
		public function UIProgressView(parent:DisplayObjectContainer=null, frame:Rectangle=null){
			super(parent, frame);
		}
		
		/**
		 * The current progress.@tag
		 * 
		 * @tag<p></p>
		 * 
		 * @default <code>0.0</code>
		 */
		public function set progress(value:Number):void{
			// constraing the input value.
			value = value < 0 ? 0 : value;
			value = value > 1 ? 1 : value;
			// setting value.
			m_progress = value;
			this.setNeedsDisplay();
		}
		// returns the current progress.
		public function get progress():Number{
			return m_progress;
		}
		
		/*The current progress is represented by a floating-point value between 0.0 and 1.0,
		inclusive, where 1.0 indicates the completion of the task. The default value is 0.0.
		Values less than 0.0 and greater than 1.0 are pinned to those limits.
		*/
		
		override protected function draw(rect:Rectangle):void{
			var w:int = rect.width;
			var h:int = 10;
			this.graphics.clear();
			this.graphics.beginFill(0xCCCCCC);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
			this.graphics.beginFill(0x999999);
			this.graphics.drawRect(0,0,w*m_procent,h);
			this.graphics.endFill();
		}
		
		override public function dispose():void{
			super.dispose();
		}

	}
}

/* iOS Implementation
Initializing the UIProgressView Object
– initWithProgressViewStyle:
Managing the Progress Bar
progress  property
Configuring the Bar Style
progressViewStyle  property

*/