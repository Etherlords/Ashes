package services 
{
	import net.ConnectionManager;
	import net.packets.BytePacket;
	import resources.IService;
	import ui.model.LazyProxy;
	
	public class ChatService implements IService
	{
		
		public var connectionManager:ConnectionManager;
		
		public var chatMessage:BytePacket;
		public var gameModel:LazyProxy;
		
		public function ChatService() 
		{
			
		}
		
		public function sendMessage(message:String, group:int = 0):void
		{
			chatMessage.input = [gameModel.playerId, group, message];
			connectionManager.send(chatMessage);
		}
		
	}

}