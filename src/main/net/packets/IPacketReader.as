package net.packets 
{
	import flash.utils.IDataInput;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IPacketReader 
	{
		
		function read(source:IDataInput):void;
	}
	
}