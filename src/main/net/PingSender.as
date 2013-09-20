package net 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.packets.BasePacket;
	import net.packets.PacketsBuilder;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PingSender 
	{
		private var timer:Timer;
		private var pingPacket:BasePacket;
		
		[Inject]
		public var connectionManager:ConnectionManager;
		
		[Inject]
		public var packetsBuilder:PacketsBuilder;
		
		public function PingSender() 
		{
			inject(this);
			initilize();
		}
		
		private function initilize():void 
		{
			timer = new Timer(10000, 0);
			timer.addEventListener(TimerEvent.TIMER, sendPing);
			timer.start();
			
			pingPacket = packetsBuilder.buildPingPacket();
			
			sendPing();
		}
		
		private function sendPing(e:TimerEvent = null):void 
		{
			pingPacket.write(connectionManager.sock);
			connectionManager.sock.flush();
		}
		
	}

}