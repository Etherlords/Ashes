package net 
{
	import core.net.Socket;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.Security;
	import geom.PathMathematic;
	import net.packets.BytePacket;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ConnectionManager 
	{
		public var sock:Socket;
		
		private static const crossDomain:String = "<cross-domain-policy><site-control permitted-cross-domain-policies='all'/><allow-access-from domain='*' to-ports='*' /></cross-domain-policy>";
		
		[Inject]
		public var mathem:PathMathematic;
		
		[Inject]
		public var worldTime:WorldTimeController;
		
		public var dataReader:DataReader;
		
		private var totalSend:int;
		private var totalRecived:int;
		
		public function ConnectionManager() 
		{
			inject(this);	
			connect();
		}
		
		public function connect():void 
		{
			//Security.loadPolicyFile('xmlsocket://localhost:8881');
			//Security.loadPolicyFile('socket://PLANETVEGETA:8881');
			
			trace('load policy');
			sock = new Socket('PLANETVEGETA', 8881);
			
			sock.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			sock.addEventListener(Event.CONNECT, onConnect);
		}
		
		public function send(packet:BytePacket):void
		{
			packet.source = sock;
			packet.write();
			totalSend += sock.bytesPending;
			trace('send', sock.bytesPending);
			
			sock.flush();
			
			trace('totalsend', (totalSend / 1000).toFixed(2));
			
		}
		
		private function onData(e:ProgressEvent):void 
		{
			var avail:int = sock.bytesAvailable;
			trace('ondata', avail);
			totalRecived += avail;
			trace('totalget', (totalRecived / 1000).toFixed(2));
			dataReader.read(sock);
		}
		
		private function onConnect(e:Event):void 
		{
			
		}
		
	}

}