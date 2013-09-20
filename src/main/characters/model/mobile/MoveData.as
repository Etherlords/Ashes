package characters.model.mobile 
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Nikro
	 */
	public class MoveData 
	{
		public var startPoint:Vector3D = new Vector3D();
		public var endPoint:Vector3D = new Vector3D();
		public var startTime:Number = 0;
		public var travelTime:int = 0;
		public var speed:int = 300;
		
		public function MoveData() 
		{
			
		}
		
		public function setStartPoint(x:Number = 0, y:Number = 0, z:Number = 0):void 
		{
			startPoint.setTo(x, y, z);
		}
		
		public function setEndPoint(x:Number = 0, y:Number = 0, z:Number = 0):void
		{
			endPoint.setTo(x, y, z);
		}
		
		public static function fillData(moveData:MoveData, raw:Object):MoveData
		{
			moveData.startPoint.setTo(raw.sp.x, raw.sp.y, 0);
			moveData.endPoint.setTo(raw.ep.x, raw.ep.y, 0);
			moveData.travelTime = raw.tt;
			moveData.startTime = raw.st;
			
			return moveData;
		}
		
		public static function fromRaw(raw:Object):MoveData
		{
			var moveData:MoveData = new MoveData();
			
			fillData(moveData, raw);
			
			return moveData;
		}
		
		
		
	}

}