package net.packets.packetparts 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import net.BytesCost;
	import net.packets.IPacketReader;
	import utils.formateToString;
	
	public class Header implements IPacketReader, IPacketWriter
	{
		
		static public const SIZE:int = BytesCost.INT_COST + BytesCost.INT_COST;
		
		public var packetSize:uint;
		public var packetType:uint;
		public var serverTime:Number;
		
		public function Header() 
		{
			super();
		}
		
		public function get size():int
		{
			return SIZE;
		}
		
		public function write(source:IDataOutput):void
		{
			source.writeInt(packetSize);
			source.writeInt(packetType);
		}
		
		public function read(source:IDataInput):void 
		{
			packetSize = source.readInt();
			packetType = source.readInt();
			serverTime = source.readDouble();
		}
		
		public function toString():String
		{
			return formateToString(this, 'packetSize', 'packetType', 'serverTime');
		}
		
	}

}