package net.events 
{
	import net.packets.BytePacket;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IBytePacketDataEventListener 
	{
		function handle(packet:BytePacket):void
		
		function setType(packet:BytePacket):void;
		
		function get type():int;
		function set type(value:int):void;
	}
	
}