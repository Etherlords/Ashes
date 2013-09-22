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
		
		protected var input:Array = [];
		protected var output:Array = [];
		
		protected var headerInput:Array = [];
		protected var headerOutput:Array = [];
		
		public function BytePacket() 
		{
			
		}
		
		public function read():void
		{
			if (!streamOperator)
			{
				streamOperator.output = output;
				streamOperator.serialize((source as IDataInput));
			}
		}
		
		public function write():void
		{
			var size:int = headerOperator.writeSize;
			headerInput[0] = size;
			headerInput[1] = type;
			headerOperator.input = headerInput;
			headerOperator.deserialize((source as IDataOutput));
			
			if (streamOperator)
			{
				streamOperator.input = input;
				streamOperator.deserialize((source as IDataOutput));
			}
		}
		
		
	}

}