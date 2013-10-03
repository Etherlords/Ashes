package logic 
{
	import flash.display.Stage;
	import flash.events.Event;
	import net.PingSender;
	import services.LoginService;
	import ui.LoginWindow;
	
	public class MainController 
	{
		[Inject]
		public var stage:Stage;
		
		public var pingSender:PingSender
		
		public function MainController() 
		{
			
		}
		
		public function initilize():void
		{
			inject(this);
		}
		
		public function onLoginAnswer(status:int):void 
		{
			if (status == 0)
			{
				//then login success
				trace('login success');
				pingSender.launch();
			}
		}
	}

}