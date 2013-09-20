package net 
{
	import flash.utils.ByteArray;
	import net.packets.AddPlayerPacket;
	import net.packets.BasePacket;
	import net.packets.packetparts.Header;
	/**
	 * ...
	 * @author Nikro
	 */
	public class DataReader 
	{
		
		public var readers:Object = { };
		public var buffer:ByteArray = new ByteArray();
		
		public function DataReader() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			buffer.length = 100000;
			fillReaders();
		}
		
		private function fillReaders():void 
		{
			//readers[AddPlayerPacket.TYPE] = new AddPlayerPacket();
		}
		
		private var bytesNeeded:uint = 0
		private var bufferLength:uint = 0;
		
		public function read(input:ByteArray):void
		{
			input.position = 0;
			
			var currentDataLength:uint = input.bytesAvailable
			
			bufferLength += currentDataLength;
			
			input.readBytes(buffer, 0, currentDataLength);
			
			var isPacketRecived:Boolean = bytesNeeded <= currentDataLength;
			
			if (!isPacketRecived)
				return;
			
			if(bufferLength < Header.SIZE)
				return;
				
			buffer.position = 0;
			bytesNeeded = buffer.readInt();
			
			isPacketRecived = bytesNeeded <= currentDataLength;
			
			if (!isPacketRecived)
				return;
			
			var type:uint = buffer.readInt();
			var reader:BasePacket = readers[type];
			buffer.position = 0;
			reader.read(buffer);
		}
		
	}

}