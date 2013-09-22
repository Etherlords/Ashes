package net 
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import net.packets.BytePacket;
	import utils.dump.dump;
	
	public class DataReader 
	{
		
		public var readers:Object = { };
		public var buffer:ByteArray = new ByteArray();
		
		static public const HEADER_SYZE:int = 12;
		
		public function DataReader() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			buffer.length = 100000;
		}
		
		public function addPacket(packet:BytePacket):void
		{
			readers[packet.type] = packet;
		}
		
		private var bytesNeeded:uint = 0
		private var bufferLength:uint = 0;
		
		public function read(input:IDataInput):void
		{
			//read inputed data to buffer
			var inputDataLength:uint = input.bytesAvailable;
			
			bufferLength += inputDataLength;
			input.readBytes(buffer, 0, inputDataLength);
			
			//process buffer if buffer length is enought to read packet then read packet
			processBuffer();
		}
		
		private function processBuffer():void
		{
			//if buffer length less then minimum (mean header size) then return
			if (bufferLength < HEADER_SYZE)
				return;
			
			var isPacketRecived:Boolean = bytesNeeded <= bufferLength;
			
			//if buffer length less then bytesNeeded (mean size of packet readed from buffer) then return
			if (!isPacketRecived)
				return;
				
			//read lenght of first packet from buffer
			buffer.position = 0;
			bytesNeeded = buffer.readInt();
			
			//if it was first time when packet size was read check maybe current buffer size is enought to read
			isPacketRecived = bytesNeeded <= bufferLength;
			
			if (!isPacketRecived)
				return;
				
			//read packet type from buffer
			var type:uint = buffer.readInt();
			
			//read packet
			var reader:BytePacket = readers[type];
			reader.source = buffer;
			buffer.position = 0;
			
			trace('read', reader);
			reader.read();
			
			bufferLength -= bytesNeeded;
			buffer.writeBytes(buffer, bytesNeeded, bufferLength);
			bytesNeeded = 0;
			
			//after packet readed check buffer maybe another packet in buffer
			processBuffer();
		}
		
	}

}