package utils.io 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class DoubleOperator implements ISerializer, IDeserealizer, IStreamOperator
	{
		private var _value:Object;
		
		private static const _size:Number = TypesSize.DOUBLE_SIZE;
		
		public function DoubleOperator(value:Number = 0) 
		{
			_value = value;
		}
		
		public function deserialize(source:IDataOutput):int 
		{
			source.writeDouble(_value as Number);
			return _size;
		}
		
		public function serialize(source:IDataInput):int 
		{
			_value = source.readDouble();
			return _size;
		}
		
		public function get size():Boolean 
		{
			return _size;
		}
		
		public function get value():Object 
		{
			return _value;
		}
		
		public function set value(value:Object):void 
		{
			_value = value;
		}
		
		public function get isStaticSize():Boolean 
		{
			return true;
		}
		
	}

}