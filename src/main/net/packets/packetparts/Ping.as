package net.packets.packetparts 
{
	import flash.utils.ByteArray;
	import flash.utils.IDataOutput;
	import net.packets.IPacketReader;
	/**
	 * ...
	 * @author Nikro
	 */
	public class Ping implements IPacketWriter 
	{
		
		public function Ping() 
		{
			
		}
		
		public function write(source:IDataOutput):void 
		{
			
		}
		
		/* INTERFACE net.packets.packetparts.IPacketWriter */
		
		public function get size():int 
		{
			return 0;
		}
		
	}

}