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
		
		public var output:Array = [];
		public var input:Array;
		
		private var _writeSize:int = 0;
		private var _readSize:int = 0;
		
		private var serializers:Vector.<ISerializer> = new Vector.<ISerializer>;
		private var deserializers:Vector.<IDeserializer> = new Vector.<IDeserializer>;
		
		private var _isStaticSize:Boolean = true;
		
		public function StreamOperator() 
		{
			
		}
		
		public function deserialize(source:IDataOutput):int 
		{
			var size:int = 0;
			var currentDeserializer:IDeserializer;
			for (var i:int = 0; i < deserializersCount; i++)
			{
				currentDeserializer = deserializers[i];
				currentDeserializer.value = input[i];
				size += currentDeserializer.deserialize(source);
				//trace(currentdeserializer);
			}
			
			trace('writed: ' + size);
			
			return size;
		}
		
		public function serialize(source:IDataInput):int 
		{
			var size:int = 0;
			var currentSerializer:ISerializer;
			for (var i:int = 0; i < serializersCount; i++)
			{
				currentSerializer = serializers[i];
				size += currentSerializer.serialize(source);
				output.push(currentSerializer.value);
				//trace(currentSerializer);
			}
			
			trace('readed: ' + size);
			
			return size;
		}
		
		public function addSerializer(serializer:ISerializer):void 
		{
			serializersCount++;
			serializers.push(serializer);
			
			if (!serializer.isStaticSize)
				_isStaticSize = false;
			else
				_readSize += serializer.readSize;
		}
		
		public function addDeserializer(deserializer:IDeserializer):void 
		{
			deserializersCount++;
			deserializers.push(deserializer);
			
			if (!deserializer.isStaticSize)
				_isStaticSize = false;
			else
				_writeSize += deserializer.writeSize;
		}
		
		public function get value():Object 
		{
			return output;
		}
		
		public function set value(value:Object):void
		{
			input = value as Array;
		}
		
		public function get isStaticSize():Boolean 
		{
			return _isStaticSize;
		}
		
		public function calculateReadSize():int
		{
			if (_isStaticSize)
			{
				return _readSize;
			}
			
			_readSize = 0;
			var currentSerializer:ISerializer;
			for (var i:int = 0; i < serializersCount; i++)
			{
				currentSerializer = serializers[i];
				currentSerializer.value = output[i];
				
				if(currentSerializer.isStaticSize)
					_readSize += currentSerializer.readSize
				else
					_readSize += currentSerializer.calculateReadSize();
			}
			
			return _readSize;
		}
		
		public function calculateWriteSize():int
		{
			if (_isStaticSize)
			{
				return _writeSize;
			}
			
			_writeSize = 0;
			var currentDesirealizer:IDeserializer;
			for (var i:int = 0; i < deserializersCount; i++)
			{
				currentDesirealizer = deserializers[i];
				currentDesirealizer.value = input[i];
				
				if(currentDesirealizer.isStaticSize)
					_writeSize += currentDesirealizer.writeSize;
				else
					_writeSize += currentDesirealizer.calculateWriteSize();
			}
			
			return _writeSize;
		}
		
		public function get readSize():int
		{
			return _readSize;
		}
		
		public function get writeSize():int 
		{
			return _writeSize;
		}
		
	}

}