package services 
{
	import net.ConnectionManager;
	import net.packets.BytePacket;
	import resources.IService;
	/**
	 * ...
	 * @author Nikro
	 */
	public class LoginService implements IService
	{
		[Inject]
		public var connectionManager:ConnectionManager;
		
		[Inject]
		public var loginPacket:BytePacket;
		
		public function LoginService() 
		{
			
		}
		
		public function login(username:String, password:String):void
		{
			loginPacket.input = [username, password];
			connectionManager.send(loginPacket);
		}
		
	}

}