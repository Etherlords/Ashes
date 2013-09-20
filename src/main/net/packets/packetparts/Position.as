package net.packets.packetparts 
{
	import flash.utils.IDataInput;
	import net.packets.IPacketReader;
	import utils.formateToString;
	
	public class Position implements IPacketReader 
	{
		public var y:Number;
		public var x:Number;
		
		public function Position() 
		{
			
		}
		
		public function read(source:IDataInput):void 
		{
			x = source.readDouble();
			y = source.readDouble();
		}
		
		public function toString():String
		{
			return formateToString(this, 'x', 'y');
		}
		
	}

}