package net.packets 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import net.packets.packetparts.Header;
	import net.packets.packetparts.IPacketWriter;
	
	public class BasePacket implements IPacketReader, IPacketWriter
	{
		private var parts:Vector.<Object> = new Vector.<Object>;
		private var partsCount:uint = 0;
		
		private var _size:int = 0;
		
		public var header:Header = new Header();
		
		public function BasePacket() 
		{
			initilize();
		}
		
		public function get size():int
		{
			return _size;
		}
		
		public function initilize():void 
		{
			addPart(header);
		}
		
		public function addPart(part:Object):void
		{
			partsCount++;
			parts.push(part);
			
			if (part is IPacketWriter)
				_size += (part as IPacketWriter).size;
		}
		
		public function read(source:IDataInput):void
		{
			for (var i:uint = 0; i < partsCount; i++)
			{
				parts[i].read(source);
				trace(parts[i]);
			}
		}
		
		public function write(source:IDataOutput):void 
		{
			header.packetSize = _size;
			
			for (var i:uint = 0; i < partsCount; i++)
			{
				parts[i].write(source);
				trace(i, parts[i]);
			}
		}
		
	}

}