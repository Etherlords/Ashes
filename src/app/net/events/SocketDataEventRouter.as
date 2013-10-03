package net.events 
{
	import net.packets.BytePacket;
	
	public class SocketDataEventRouter 
	{
		private var eventsMap:Object = { };
		
		public function SocketDataEventRouter() 
		{
			
		}
		
		public function addEventListener(eventListener:IBytePacketDataEventListener):void
		{
			eventsMap[eventListener.type] = eventListener;
		}
		
		public function routeData(packet:BytePacket):void
		{
			var eventListener:IBytePacketDataEventListener = eventsMap[packet.type]
			
			if (!eventListener)
				return;
				
			eventListener.handle(packet);
		}
		
	}

}