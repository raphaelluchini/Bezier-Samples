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
	public class Bezier_01 extends MovieClip 
	{
		public var points:Vector.<Point> = new Vector.<Point>(30);
		public var letras:Vector.<Letra> = new Vector.<Letra>(30);
		private var texto:String = "Lorem ipsum dolor sit posuere."
		public var line:Shape;
		private var ISmDown:Boolean;
		private var objMoving:MovieClip;
		
		function Bezier_01()
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
			getDegree(true);
			
			swapChildrenAt(this.numChildren-1, getChildIndex(p1));
			swapChildrenAt(this.numChildren-2, getChildIndex(p2));
			
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
				getDegree();
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
		
		private function getDegree(add:Boolean = false):void 
		{
			for (var i:int = 0; i < points.length; i++) 
			{
				
				if (i < points.length - 1)
				{
					var p:Point = points[i];
					var pPost:Point = points[i + 1];
					var radians:Number = Math.atan2(p.y - pPost.y, p.x - pPost.x);
					var degrees:Number = (radians / Math.PI) * 180;
					if(add)
						addChild(drawPoint(p, degrees, i));
					else
						refreshLetters(p, degrees, i)
				}
				
			}
		}
		
		private function refreshLetters(p:Point, num:int, i:int)
		{
			letras[i].x = p.x;
			letras[i].y = p.y;
			letras[i].rotation = num + 180;
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
		
		private function drawPoint(p:Point, num:int, i:int):Letra
		{
			var tf:Letra = new Letra();
			tf.x = p.x;
			tf.y = p.y;
			tf.txt.autoSize = TextFieldAutoSize.CENTER;
			tf.txt.text = texto.charAt(i);
			tf.rotation = num + 180;
			letras[i] = tf;
			/*var sprite:Shape = new Shape();
			sprite.graphics.beginFill(0x000000 );
			sprite.graphics.drawRect(-2.5,-2.5,5,5);
			sprite.x = p.x;
			sprite.y = p.y;
			sprite.rotation = num;*/
			return tf;
		}
	}
	
}