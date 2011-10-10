package 
{
	import com.greensock.easing.Linear;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import com.greensock.TweenLite
	/**
	 * ...
	 * @author Raphael Luchini
	 */
	public class Bezier_00 extends MovieClip 
	{
		public var points:Vector.<Point> = new Vector.<Point>(30);
		public var letras:Vector.<Letra> = new Vector.<Letra>(30);
		public var line:Shape
		public var ISmDown:Boolean;
		public var objMoving:MovieClip;
		
		function Bezier_00()
		{
			var cont:int = 0;
			var p:Point;
			
			line = new Shape();
			line.graphics.lineStyle(2,0x000000);
			line.graphics.moveTo(p0.x, p0.y);
			
			var cx:Number = 3 * (p1.x - p0.x);
			var bx:Number = 3 * (p2.x - p1.x) - cx;
			var ax:Number = p3.x - p0.x - cx - bx;
			
			var cy:Number = 3 * (p1.y - p0.y);
			var by:Number = 3 * (p2.y - p1.y) - cy;
			var ay:Number = p3.y - p0.y - cy - by;
			
			for (var u:Number = 0; u <= 1; u += 1 / 30)
			{
				p = new Point();
				p.x = (ax * Math.pow(u, 3)) + (bx * Math.pow(u, 2)) + cx * u + p0.x;
				p.y = (ay * Math.pow(u, 3)) + (by * Math.pow(u, 2)) + cy * u + p0.y;
				line.graphics.lineTo(p.x, p.y);
				points[cont] = p;
				cont ++;
			}
			line.graphics.lineTo(p3.x, p3.y);

			addChild(line);
			
			swapChildrenAt(this.numChildren-1, getChildIndex(p1));
			swapChildrenAt(this.numChildren - 2, getChildIndex(p2));
			
			p1.buttonMode = true;
			p1.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, mUP);
			
			p2.buttonMode = true;
			p2.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, mUP);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			if (ISmDown)
			{
				refresh();
			}
		}
		
		private function mDown(e:MouseEvent):void 
		{
			objMoving = e.currentTarget as MovieClip
			e.currentTarget.startDrag();
			ISmDown = true;
		}
		
		private function mUP(e:MouseEvent):void 
		{
			if (objMoving)
			{
				objMoving.stopDrag();
			}
			
			ISmDown = false;
		}
		
		private function refresh():void
		{
			var cx:Number = 3 * (p1.x - p0.x);
			var bx:Number = 3 * (p2.x - p1.x) - cx;
			var ax:Number = p3.x - p0.x - cx - bx;
			
			var cy:Number = 3 * (p1.y - p0.y);
			var by:Number = 3 * (p2.y - p1.y) - cy;
			var ay:Number = p3.y - p0.y - cy - by;
			var cont:int = 0;
			
			line.graphics.clear();
			
			line.graphics.lineStyle(2,0x000000);
			line.graphics.moveTo(p0.x, p0.y);
			
			for (var u:Number = 0; u <= 1; u += 1 / 30)
			{
				points[cont].x = (ax * Math.pow(u, 3)) + (bx * Math.pow(u, 2)) + cx * u + p0.x;
				points[cont].y = (ay * Math.pow(u, 3)) + (by * Math.pow(u, 2)) + cy * u + p0.y;
				
				line.graphics.lineTo(points[cont].x, points[cont].y);
				cont++;
			}
			line.graphics.lineTo(p3.x, p3.y);
		}
	}
	
}