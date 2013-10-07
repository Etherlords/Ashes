package logic 
{
	import flash.display.Stage;
	import flash.events.Event;
	import logic.ui.LobbyWindowController;
	import logic.ui.LoginWindowController;
	import net.PingSender;
	import services.LoginService;
	import ui.LoginWindow;
	import ui.model.LazyProxy;
	
	public class MainController 
	{
		[Inject]
		public var stage:Stage;
		
		public var pingSender:PingSender
		public var loginWindow:LoginWindowController;
		public var lobbyWindow:LobbyWindowController;
		public var gameModel:LazyProxy;
		
		public function MainController() 
		{
			
		}
		
		public function initilize():void
		{
			inject(this);
			
			loginWindow.show();
		}
		
		public function onLoginAnswer(id:int, status:int):void 
		{
			
			if (status != 0)
				return;
				
			trace('login success');
			
			gameModel.playerId = id;
			pingSender.launch();
			
			loginWindow.hide();
			lobbyWindow.show();
		}
	}

}