package net.events 
{
	import logic.ui.LobbyWindowController;
	import net.packets.BytePacket;
	
	public class ChatMessageEventListener implements IBytePacketDataEventListener
	{
		private var _type:int;
		
		public var lobbyController:LobbyWindowController;
		
		public function ChatMessageEventListener() 
		{
			
		}
		
		public function handle(packet:BytePacket):void 
		{
			var fromUser:int = packet.output[0];
			var toGtoup:int = packet.output[1];
			var message:String = packet.output[2];
			
			lobbyController.addMessage(message, fromUser);
		}
		
		public function setType(packet:BytePacket):void 
		{
			type = packet.type;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
	}

}