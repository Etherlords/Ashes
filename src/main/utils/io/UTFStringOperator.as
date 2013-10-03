package utils.io 
{
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import utils.formateToString;

public class UTFStringOperator implements ISerializer, IDeserializer
	{
		private var _value:Object;
		
		private var _size:Number;
		
		public function UTFStringOperator(value:Number = 0) 
		{
			_value = value;
		}
		
		public function set value(n:Object):void
		{
			_value = n;
		}
		
		public function deserialize(source:IDataOutput):int 
		{
			source.writeUTF(value as String);
			_size = utfSizeOf(_value as String);
			return _size;
		}
		
		public function serialize(source:IDataInput):int 
		{
			_value = source.readUTF();
			_size = utfSizeOf(_value as String);
			return _size;
		}
		
		public function get value():Object 
		{
			return _value;
		}
		
		public function get isStaticSize():Boolean 
		{
			return false;
		}
		
		public function toString():String 
		{
			return formateToString(this, 'value', 'writeSize', 'readSize');
		}
		
		public function calculateReadSize():int 
		{
			return _size;
		}
		
		public function calculateWriteSize():int 
		{
			return utfSizeOf(_value as String);
		}
		
		public function get writeSize():int 
		{
			return _size;
		}
		
		public function get readSize():int 
		{
			return _size;
		}
		
	}

}