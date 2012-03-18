package se.raweden.ui  
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * A <code>UIImage</code>
	 * 
	 * <p>Copyright 2011 Raweden. All rights reserved.</p>
	 * 
	 * @author Raweden
	 */
	public class UIImage extends BitmapData{
		
		private var _leftCap:int = -1;
		private var _topCap:int = -1;
		private var _scale9:Rectangle;
		
		/**
		 * 
		 */
		public function UIImage(width:int,height:int,transparent:Boolean = true,fill:uint = 0xFFFFFF){
			super(width,height,transparent,fill);
		}
		
		/**
		 * 
		 */
		public function stretchable(leftCap:int = -1,topCap:int = -1):void{
			if(!_scale9)
				_scale9 = new Rectangle();
			// setting the left cap width.
			if(leftCap < 0){
				_scale9.x = 0;
				_scale9.width = this.width;
				_leftCap = -1;
			}else{
				_scale9.x = _leftCap = leftCap;
				_scale9.width = 1;
			}
			// setting the top cap height.
			if(topCap < 0){
				_scale9.y = 0;
				_scale9.height = this.height;
				_topCap = -1;
			}else{
				_scale9.y = _topCap = topCap;
				_scale9.height = 1;
			}
		}
				
		//------------------------------------
		// Getting and Setting Attributes
		//------------------------------------
		
		/**
		 * 
		 */
		public function get leftCap():int{
			return _leftCap;
		}
		
		/**
		 * 
		 */
		public function get topCap():int{
			return _topCap;
		}
		
		//------------------------------------
		// Drawing Image.
		//------------------------------------
		
		/**
		 * 
		 */
		public function drawOn(graphics:Graphics,rect:Rectangle,smooth:Boolean = true):Rectangle{
			var width:int;
			var height:int;
			if(_scale9){
				width = rect.width;
				height = rect.height;
				drawInternal(this,graphics,width,height,_scale9,null,smooth);
				return null;
			}
			width = this.width;
			height = this.height;
			// drawing the default size of the image.
			graphics.beginBitmapFill(this,null,false);
			graphics.drawRect(rect.x,rect.y,width,height);
			graphics.endFill();
			rect.width = width;
			rect.height = height;
			return rect;
		}
		
		/**
		 * Draws the BitmapData source as a pattern in the rectangle.
		 */
		public function drawPattern(graphics:Graphics,rect:Rectangle,smooth:Boolean):Rectangle{
			var matrix:Matrix = new Matrix(1,0,0,1,rect.x,rect.y);
			graphics.beginBitmapFill(this,matrix,true,smooth);
			graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
			graphics.endFill();
			return rect;
		}
		
		
		// Drawing Interal.
		
		private static function drawInternal(source:BitmapData,graphics:Graphics,width:int,height:int,inner:Rectangle,outer:Rectangle,smooth:Boolean):void{
			// some useful local vars
			var x:int, y:int;
			var ox:Number = 0, oy:Number;
			var dx:Number = 0, dy:Number;
			var wid:Number, hei:Number;
			var dwid:Number, dhei:Number;
			var sw:int = source.width;
			var sh:int = source.height;
			
			var mat:Matrix = new Matrix();
			
			var widths:Array = [inner.left + 1,
				inner.width - 2,
				sw - inner.right + 1];
			
			var heights:Array = [inner.top + 1,
				inner.height - 2,
				sh - inner.bottom + 1];
			
			var rx:Number = width - widths[0] - widths[2];
			var ry:Number = height - heights[0] - heights[2];
			var ol:Number = (outer != null) ? -outer.left : 0;
			var ot:Number = (outer != null) ? -outer.top : 0;
			
			// let's draw
			for (x; x < 3 ;x++)
			{
				// original width
				wid = widths[x];
				// draw width						
				dwid = x==1 ? rx : wid;
				// original & draw offset
				dy = oy = 0;
				mat.a = dwid / wid;
				
				for (y = 0; y < 3; y++)
				{
					// original height
					hei = heights[y];
					// draw height
					dhei = y==1 ? ry : hei;
					
					if (dwid > 0 && dhei > 0)
					{
						// some matrix computation
						mat.d = dhei / hei;
						mat.tx = -ox * mat.a + dx;
						mat.ty = -oy * mat.d + dy;
						mat.translate(ol, ot);
						
						// draw the cell
						graphics.beginBitmapFill(source, mat, false, smooth);
						graphics.drawRect(dx + ol, dy + ot, dwid, dhei);
					}
					
					// offset incrementation
					oy += hei;
					dy += dhei;
				}
				
				// offset incrementation
				ox += wid;
				dx += dwid;
			}
			
			graphics.endFill();
		}
		
	}
}