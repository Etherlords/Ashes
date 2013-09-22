package net 
{
	import core.net.Socket;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import geom.PathMathematic;
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
		
		public function ConnectionManager() 
		{
			inject(this);	
			connect();
		}
		
		public function connect():void 
		{
			sock = new Socket('PLANETVEGETA', 8881);
			
			sock.addEventListener(ProgressEvent.SOCKET_DATA, onData);
			sock.addEventListener(Event.CONNECT, onConnect);
		}
		
		private function onData(e:ProgressEvent):void 
		{
			
		}
		
		private function onConnect(e:Event):void 
		{
			
		}
		
	}

}