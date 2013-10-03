package net 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.packets.BasePacket;
	import net.packets.BytePacket;
	import net.packets.PacketsBuilder;
	import utils.io.StreamOperator;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PingSender 
	{
		private var timer:Timer;
		
		[Inject]
		public var connectionManager:ConnectionManager;
		
		[Inject(id='PingPacket')]
		public var pingPacket:BytePacket;
		
		public function PingSender() 
		{
			inject(this);
			//initilize();
		}
		
		public function launch():void 
		{
			timer = new Timer(10000, 0);
			timer.addEventListener(TimerEvent.TIMER, sendPing);
			timer.start();
			
			sendPing();
		}
		
		private function sendPing(e:TimerEvent = null):void 
		{
			connectionManager.send(pingPacket);
		}
		
	}

}