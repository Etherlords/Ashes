package logic.ui 
{
	import flash.display.Stage;
	import flash.events.Event;
	import services.LoginService;
	import ui.LoginWindow;
	import ui.model.ObjectProxy;
	/**
	 * ...
	 * @author Nikro
	 */
	public class LoginWindowController 
	{
		
		[Inject]
		public var stage:Stage;
		
		public var loginService:LoginService;
		
		private var loginWindowModel:ObjectProxy
		private var loginWindowView:LoginWindow;
		
		public function LoginWindowController() 
		{
			
		}
		
		public function initilize():void
		{
			inject(this);
			
			loginWindowModel = new ObjectProxy();
			
			loginWindowView = new LoginWindow();
			loginWindowView.config = 'ui/settings/config/LoginWindow.xml';
			loginWindowView.modelProxy = loginWindowModel;
			loginWindowView.initilize();
			
			loginWindowView.addEventListener('Login', onLoginPress);
			
			stage.addChild(loginWindowView);
		}
		
		private function onLoginPress(e:Event):void 
		{
			if (!loginWindowModel.login.length || !loginWindowModel.password.length)
				return;
				
			loginService.login(loginWindowModel.login, loginWindowModel.password);
		}
		
	}

}