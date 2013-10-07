package logic.ui 
{
	import flash.display.Stage;
	import ui.ViewComponent;
	/**
	 * ...
	 * @author Nikro
	 */
	public class UIController 
	{
		
		[Inject]
		public var stage:Stage;
		
		public var myView:ViewComponent
		
		public function UIController() 
		{
			
		}
		
		public function show():void
		{
			stage.addChild(myView);
		}
		
		public function hide():void
		{
			stage.removeChild(myView);
		}
		
		public function initilize():void
		{
			inject(this);
		}
		
	}

}