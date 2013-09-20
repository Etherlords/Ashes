package net.packets.packetparts 
{
	import flash.utils.IDataInput;
	import net.packets.IPacketReader;
	import utils.formateToString;
	
	public class PlayerInfo implements IPacketReader 
	{
		public var playerID:uint;
		public var playerName:String;
		
		public function PlayerInfo() 
		{
			super();
		}
		
		public function read(source:IDataInput):void 
		{
			playerID = source.readUnsignedInt();
			playerName = source.readUTF();
		}
		
		public function toString():String
		{
			return formateToString(this, 'playerID', 'playerName');
		}
		
	}

}