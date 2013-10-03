package utils.io 
{
import flash.geom.Point;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import utils.formateToString;

public class PointOperator implements ISerializer, IDeserializer
	{
		private var _value:Object;
		
		private static const _size:Number = TypesSize.POINT_SIZE;
		
		public function PointOperator(value:Point = null) 
		{
			_value = value;
		}
		
		public function set value(point:Object):void
		{
			this._value = point;
		}
		
		public function deserialize(source:IDataOutput):int 
		{
			source.writeDouble((_value as Point).x);
			source.writeDouble((_value as Point).y);
			return _size;
		}
		
		public function serialize(source:IDataInput):int 
		{
			(_value as Point).x = source.readDouble();
			(_value as Point).y = source.readDouble();
			return _size;
		}
		
		public function get value():Object 
		{
			return _value;
		}
		
		public function get isStaticSize():Boolean 
		{
			return true;
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
			return _size;
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