package net 
{
	import core.net.Socket;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import geom.PathMathematic;
	import net.packets.BytePacket;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ConnectionManager 
	{
		public var sock:MockSocket;
		
		private static const crossDomain:String = "<cross-domain-policy><site-control permitted-cross-domain-policies='all'/><allow-access-from domain='*' to-ports='*' /></cross-domain-policy>";
		
		[Inject]
		public var mathem:PathMathematic;
		
		[Inject]
		public var worldTime:WorldTimeController;
		
		public var dataReader:DataReader;
		
		public function ConnectionManager() 
		{
			inject(this);	
			connect();
		}
		
		public function connect():void 
		{
			sock = new MockSocket('PLANETVEGETA', 8881);
			
			sock.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			sock.addEventListener(Event.CONNECT, onConnect);
		}
		
		public function send(packet:BytePacket):void
		{
			packet.source = sock;
			packet.write();
			sock.flush();
			
			
		}
		
		private function onData(e:ProgressEvent):void 
		{
			trace('ondata', sock.bytesAvailable);
			dataReader.read(sock);
		}
		
		private function onConnect(e:Event):void 
		{
			
		}
		
	}

}