package net 
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import net.packets.AddPlayerPacket;
	import net.packets.BasePacket;
	import net.packets.packetparts.Header;
	import utils.io.IStreamOperator;
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
		
		public function addStreamOperator(operator:IStreamOperator):void
		{
			
		}
		
		private var bytesNeeded:uint = 0
		private var bufferLength:uint = 0;
		
		public function read(input:IDataInput):void
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