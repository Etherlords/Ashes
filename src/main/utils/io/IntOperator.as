package utils.io 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	public class IntOperator implements ISerializer, IDeserealizer, IStreamOperator
	{
		private var _value:Object;
		
		private static const _size:int = TypesSize.INT_SIZE;
		
		public function IntOperator(value:int = 0) 
		{
			_value = value;
		}
		
		public function deserialize(source:IDataOutput):int 
		{
			source.writeInt(_value as int);
			return _size;
		}
		
		public function serialize(source:IDataInput):int 
		{
			_value = source.readInt();
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