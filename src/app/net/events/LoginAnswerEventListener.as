package net.events 
{
	import logic.MainController;
	import net.packets.BytePacket;
	import ui.model.LazyProxy;
	
	public class LoginAnswerEventListener implements IBytePacketDataEventListener 
	{
		[Inject(id="Main")]
		public var mainController:MainController;
		
		private var _type:int;
		
		public function LoginAnswerEventListener() 
		{
			
		}
		
		public function handle(packet:BytePacket):void 
		{
			if (!mainController)
				inject(this);
				
				trace('on login answr', packet.output);
			mainController.onLoginAnswer(packet.output[0], packet.output[1]);
		}
		
		public function setType(packet:BytePacket):void
		{
			this._type = packet.type;
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