package net.packets 
{
	import flash.utils.IDataOutput;
	import net.packets.packetparts.Ping;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PacketsBuilder 
	{
		
		public function PacketsBuilder() 
		{
			
		}
		
		public function buildPingPacket():BasePacket
		{
			var basePacket:BasePacket = new BasePacket();
			
			basePacket.header.packetType = PacketTypes.PING;
			basePacket.header.packetSize = 0;
			
			return basePacket;
		}
		
	}

}