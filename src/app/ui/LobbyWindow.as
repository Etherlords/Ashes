package ui 
{
	import com.bit101.components.InputText;
	import com.bit101.components.List;
	import com.bit101.components.TextArea;
	import flash.events.Event;
	import ui.model.events.ProxyEvent;
	
	public class LobbyWindow extends ViewComponent
	{
		public var input:InputText;
		public var textArea:TextArea;
		public var playersList:List;
		public var gamesList:List;
		
		public var playersListItems:Array = [];
		public var gamesListItems:Array = [];
		
		public function LobbyWindow() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		override protected function onConfigured(e:Event):void 
		{
			super.onConfigured(e);
			gamesList.items = gamesListItems;
			gamesList.listItemClass = GameListItem;
			
			playersList.items = playersListItems;
			playersList.listItemClass = PlayerListItem;
			
			modelProxy.addEventListener(ProxyEvent.UPDATE_EVENT, onUIChange);
			
			//bind('inputText', setInputText);
			bind('displayedText', setTextLog);
		}
		
		public function setTextLog(value:String):void 
		{
			this.textArea.text = value;
		}
		
		public function setInputText(value:String):void 
		{
			this.input.text = value;
		}                                                                                                                      
		
		
		public function addPlayer(item:Object):void
		{
			for (var i:int = 0; i < playersListItems.length; i++)
			{
				if (playersListItems[i].label == item.label)
					return;
			}
			
			playersList.addItem(item);
			
			//playersListItems.push(item);
			playersList.invalidate();
		}
		
		public function addGame(item:Object):void
		{
			gamesListItems.push(item);
			gamesList.invalidate();
		}
		
		public function onSelectPlayer(e:Event):void
		{
			trace(playersList.selectedItem);
		}
		
		public function onSelectGame(e:Event):void
		{
			trace(gamesList.selectedItem);
		}
		
		private function onUIChange(e:ProxyEvent):void 
		{
			if (!isConfigured)
				return;
				
			executeBind();
			//if ('displayedText' in lobbyWindowModel.changedFields && lobbyWindowModel.displayedText.length)
			//{
			//	textArea.text = lobbyWindowModel.displayedText;
			//}
		}
		
		
		
	}

}