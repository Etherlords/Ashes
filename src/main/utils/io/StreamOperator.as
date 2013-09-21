package utils.io 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	/**
	 * ...
	 * @author Nikro
	 */
	public class StreamOperator implements ISerializer, IDeserializer, IStream
	{
		
		private var serializersCount:int = 0;
		private var deserializersCount:int = 0;
		
		private var output:Object = { };
		
		private var _size:int = 0;
		
		private var serializers:Vector.<ISerializer> = new Vector.<ISerializer>;
		private var deserializers:Vector.<IDeserializer> = new Vector.<IDeserializer>;
		
		private var _isStaticSize:Boolean = true;
		
		public function StreamOperator() 
		{
			
		}
		
		public function deserialize(source:IDataOutput):int 
		{
			_size = 0;
			var currentDeserializer:IDeserializer;
			for (var i:int = 0; i < deserializersCount; i++)
			{
				currentDeserializer = deserializers[i];
				_size += currentDeserializer.deserialize(source);
				trace(currentDeserializer);
			}
			
			return _size;
		}
		
		public function serialize(source:IDataInput):int 
		{
			_size = 0;
			var currentSerializer:ISerializer;
			for (var i:int = 0; i < serializersCount; i++)
			{
				currentSerializer = serializers[i];
				_size += currentSerializer.serialize(source);
				trace(currentSerializer);
			}
			
			return _size;
		}
		
		public function addSerializer(serializer:ISerializer):void 
		{
			serializersCount++;
			serializers.push(serializer);
			
			if (!serializer.isStaticSize)
				_isStaticSize = false;
		}
		
		public function addDesirealizer(deserializer:IDeserializer):void 
		{
			deserializersCount++;
			deserializers.push(deserializer);
			
			if (!deserializer.isStaticSize)
				_isStaticSize = false;
		}
		
		public function get value():Object 
		{
			return {};
		}
		
		public function set value(value:Object):void 
		{
			//_value = value;
		}
		
		public function get isStaticSize():Boolean 
		{
			return _isStaticSize;
		}
		
		public function get size():int 
		{
			return _size;
		}
		
	}

}