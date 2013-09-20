package net.packets.packetparts 
{
	import characters.model.mobile.MoveData;
	import flash.utils.IDataInput;
	import net.packets.IPacketReader;
	import utils.formateToString;
	
	public class MoveInfo implements IPacketReader 
	{
		
		public var moveData:MoveData = new MoveData();
		
		public function MoveInfo() 
		{
			
		}
		
		public function read(source:IDataInput):void 
		{
			moveData.setStartPoint(source.readDouble(), source.readDouble());
			moveData.setEndPoint(source.readDouble(), source.readDouble());
			moveData.startTime = source.readDouble();
			moveData.travelTime = source.readUnsignedInt();
			moveData.speed = source.readUnsignedInt();
		}
		
		public function toString():String
		{
			return formateToString(moveData, this, 'startPoint', 'endPoint', 'startTime', 'travelTime', 'speed');
		}
		
	}

}