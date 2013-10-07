package net.packets 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import utils.io.StreamOperator;
	/**
	 * ...
	 * @author Nikro
	 */
	public class BytePacket 
	{
		public var source:Object;
		
		public var type:int = 0;
		public var streamOperator:StreamOperator;
		public var headerOperator:StreamOperator;
		
		public var input:Array = [];
		public var output:Array = [];
		
		public var headerInput:Array = [];
		public var headerOutput:Array = [];
		
		public function BytePacket() 
		{
			
		}
		
		public function read():void
		{
			headerOperator.output = headerOutput;
			headerOperator.serialize((source as IDataInput));
			
			if (streamOperator)
			{
				output = [];
				streamOperator.output = output;
				streamOperator.serialize((source as IDataInput));
			}
		}
		
		public function write():void
		{
			var size:int;
			
			if (streamOperator)
			{
				streamOperator.input = input;
				
				if (streamOperator.isStaticSize)
					size += streamOperator.writeSize;
				else
					size += streamOperator.calculateWriteSize();
			}
			
			if (headerOperator.isStaticSize)
				size += headerOperator.writeSize;
			else
				size += headerOperator.calculateWriteSize();
			
			headerInput[0] = size;
			headerInput[1] = type;
			
			headerOperator.input = headerInput;
			headerOperator.deserialize((source as IDataOutput));
			
			if (streamOperator)
				streamOperator.deserialize((source as IDataOutput));
		}
		
		
	}

}