package logic.ui 
{
	import core.ui.KeyBoardController;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import services.ChatService;
	import ui.LobbyWindow;
	import ui.model.LazyProxy;
	
	public class LobbyWindowController extends UIController
	{
		private var lobbyWindowModel:LazyProxy;
		public var lobbyWindowView:LobbyWindow;
		
		public var chatService:ChatService;
		
		
		public function LobbyWindowController() 
		{
			
		}
		
		override public function initilize():void
		{
			super.initilize();
			
			var keyboard:KeyBoardController = new KeyBoardController(stage);
			keyboard.registerKeyDownReaction(Keyboard.ENTER, onSendMessage);
			
			lobbyWindowModel = new LazyProxy(200);
			
			lobbyWindowView = new LobbyWindow();
			lobbyWindowView.config = 'ui/settings/config/LobbyWindow.xml';
			lobbyWindowView.modelProxy = lobbyWindowModel;
			lobbyWindowView.addEventListener(Event.COMPLETE, onViewConfigured);
			lobbyWindowView.initilize();
			
			myView = lobbyWindowView;
			
			trace("## LOBBY WINDOW INITILIZED", stage, lobbyWindowView);
		}
		
		private function onViewConfigured(e:Event):void 
		{
			initView();
		}
		
		private function onSendMessage():void 
		{
			if (lobbyWindowModel.inputText.length)
			{
				var toInput:String = lobbyWindowModel.inputText;
				//addMessage(toInput);
				
				lobbyWindowView.setInputText('');
				
				chatService.sendMessage(toInput, 0);
			}
		}
		
		public function addMessage(toInput:String, from:int = 0):void
		{
			var displayedText:String = lobbyWindowModel.displayedText;
			
			var user:String = '';
			if (from == -1)
				user = 'System: ';
			else
			{
				lobbyWindowView.addPlayer({label:from.toString(), status:1});
				user = from.toString()+': ';
			}
			
			lobbyWindowModel.displayedText = displayedText + user + toInput + '\n';
		}
		
		public function initView():void
		{
			lobbyWindowModel.displayedText = '';
			lobbyWindowModel.inputText = '';
			
			//lobbyWindowView.addPlayer( { label:'tratata', status:1 } );
			//lobbyWindowView.addGame( { label:'tratata', status:1 } );
		}
		
	}

}