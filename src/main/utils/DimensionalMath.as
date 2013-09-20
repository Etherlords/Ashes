package utils 
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author 
	 */
	public class DimensionalMath 
	{
		private static var xHelper:Number;
		private static var yHelper:Number
		
		public static function getMovieVector(from:Vector3D, to:Vector3D, numberOfSteps:Number):Vector3D
		{
			var delta:Vector3D = to.subtract(from);// (from);
			delta.x /= numberOfSteps;
			delta.z /= numberOfSteps;
			
			return delta;
		}
		
		public static function inRadius(radius:Number, appliationPoint:Object, interestPoint:Object):Boolean
		{
			return distance(appliationPoint, interestPoint) < radius;
		}
		
		public static function distance(point1:Object, point2:Object):Number
		{
			xHelper = (point1.x - point2.x);
			xHelper *= xHelper;
			
			yHelper = (point1.y - point2.y);
			yHelper *= yHelper;
			
			return Math.sqrt(xHelper + yHelper);
		}
		
		public static function angle(a:Object, b:Object):Number
		{
			xHelper = b.x - a.x;
			yHelper = b.y - a.y;

			return Math.atan2(yHelper, xHelper);
        }
		
	}

}