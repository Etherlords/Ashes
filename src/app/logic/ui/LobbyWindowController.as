package logic.ui 
{
	import core.ui.KeyBoardController;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import ui.LobbyWindow;
	import ui.model.LazyProxy;
	
	public class LobbyWindowController 
	{
		[Inject]
		public var stage:Stage;
		
		private var lobbyWindowModel:LazyProxy;
		public var lobbyWindowView:LobbyWindow;
		
		public function LobbyWindowController() 
		{
			
		}
		
		public function initilize():void
		{
			inject(this);
			
			var keyboard:KeyBoardController = new KeyBoardController(stage);
			keyboard.registerKeyDownReaction(Keyboard.ENTER, onSendMessage);
			
			lobbyWindowModel = new LazyProxy(200);
			
			lobbyWindowView = new LobbyWindow();
			lobbyWindowView.modelProxy = lobbyWindowModel;
			lobbyWindowView.addEventListener(Event.COMPLETE, onViewConfigured);
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
				var displayedText:String = lobbyWindowModel.displayedText;
				lobbyWindowModel.displayedText = displayedText + toInput + '\n';
				//lobbyWindowModel.inputText = '';
				
				lobbyWindowView.setInputText('');
			}
		}
		
		public function initView():void
		{
			lobbyWindowModel.displayedText = '';
			lobbyWindowModel.inputText = '';
			
			lobbyWindowView.addPlayer( { label:'tratata', status:1 } );
			lobbyWindowView.addGame( { label:'tratata', status:1 } );
		}
		
	}

}