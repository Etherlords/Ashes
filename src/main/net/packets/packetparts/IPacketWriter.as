package net.packets.packetparts 
{
	import flash.utils.IDataOutput;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IPacketWriter 
	{
		
		function write(source:IDataOutput):void;
		function get size():int;
	}
	
}