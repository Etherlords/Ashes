package net 
{
	import core.net.Socket;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	/**
	 * ...
	 * @author Nikro
	 */
	public class MockSocket extends EventDispatcher implements IDataInput, IDataOutput
	{
		private var ba:ByteArray = new ByteArray();

		
		public function MockSocket(string:String, number:Number) 
		{
			
		}
		
		public function flush():void 
		{
			
			ba.position = 0;
			var size:int = ba.readInt();
			var type:int = ba.readInt();
			
			//trace('flush bytes', size, type);
			
			if (type == 3)
			{
				
				trace('handle login packet');
				ba.clear();
				ba.writeInt(8);
				ba.writeInt(2);
				ba.writeInt(0);
			}
			else if (type == 0)
			{
				trace('handle ping');
				ba.clear();
				return;
			}
			
			ba.position = 0;
			dispatchEvent(new ProgressEvent(ProgressEvent.SOCKET_DATA, false, 0, 0));
			ba.clear();
		}
		
		public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void 
		{
			ba.readBytes(bytes, offset, length);
			ba.clear();
		}
		
		public function readBoolean():Boolean 
		{
			return false;
		}
		
		public function readByte():int 
		{
			return 0;
		}
		
		public function readUnsignedByte():uint 
		{
			return 0;
		}
		
		public function readShort():int 
		{
			return 0;
		}
		
		public function readUnsignedShort():uint 
		{
			return 0;
		}
		
		public function readInt():int 
		{
			return ba.readInt();
		}
		
		public function readUnsignedInt():uint 
		{
			return 0;
		}
		
		public function readFloat():Number 
		{
			return 0;
		}
		
		public function readDouble():Number 
		{
			return ba.readDouble();
		}
		
		public function readMultiByte(length:uint, charSet:String):String 
		{
			return '';
		}
		
		public function readUTF():String 
		{
			return ba.readUTF();
		}
		
		public function readUTFBytes(length:uint):String 
		{
			return ''
		}
		
		public function get bytesAvailable():uint 
		{
			return ba.bytesAvailable;
		}
		
		public function readObject():* 
		{
			return { };
		}
		
		/* INTERFACE flash.utils.IDataOutput */
		
		public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void 
		{
			ba.writeBytes(bytes, offset, length);
		}
		
		public function writeBoolean(value:Boolean):void 
		{
			
		}
		
		public function writeByte(value:int):void 
		{
			
		}
		
		public function writeShort(value:int):void 
		{
			
		}
		
		public function writeInt(value:int):void 
		{
			ba.writeInt(value);
		}
		
		public function writeUnsignedInt(value:uint):void 
		{
			
		}
		
		public function writeFloat(value:Number):void 
		{
			
		}
		
		public function writeDouble(value:Number):void 
		{
			ba.writeDouble(value);
		}
		
		public function writeMultiByte(value:String, charSet:String):void 
		{
			
		}
		
		public function writeUTF(value:String):void 
		{
			ba.writeUTF(value);
		}
		
		public function writeUTFBytes(value:String):void 
		{
			
		}
		
		public function writeObject(object:*):void 
		{
			
		}
		
		public function get objectEncoding():uint 
		{
			return 0;
		}
		
		public function set objectEncoding(value:uint):void 
		{
			
		}
		
		public function get endian():String 
		{
			return '';
		}
		
		public function set endian(value:String):void 
		{
			
		}
		
		
	}

}