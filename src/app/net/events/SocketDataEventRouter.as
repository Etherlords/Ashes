package net.events 
{
	import net.packets.BytePacket;
	
	public class SocketDataEventRouter 
	{
		private var eventsMap:Vector.<IBytePacketDataEventListener> = new Vector.<IBytePacketDataEventListener>;
		
		public function SocketDataEventRouter() 
		{
			
		}
		
		public function addEventListener(eventListener:IBytePacketDataEventListener):void
		{
			//eventsMap[eventListener.type] = eventListener;
			eventsMap.push(eventListener);
		}
		
		public function routeData(packet:BytePacket):void
		{
			var eventListener:IBytePacketDataEventListener;// = eventsMap[packet.type]
			
			for (var i:int = 0; i < eventsMap.length; i++)
			{
				if (eventsMap[i].type == packet.type)
				{
					eventListener = eventsMap[i];
					break;
				}
			}
			
			if (!eventListener)
				return;
				
			eventListener.handle(packet);
		}
		
	}

}