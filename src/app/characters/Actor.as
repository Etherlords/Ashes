package characters 
{
	import display.animation.IAnimationController;
	import display.IActorController;
	import display.ViewController;
	/**
	 * ...
	 * @author Nikro
	 */
	public class Actor 
	{
		private var controllers:Vector.<IActorController> = new Vector.<IActorController>;
		private var controllersMap:Object = { };
		
		public var viewController:ViewController;
		public var id:String;
		
		public function Actor(viewController:ViewController) 
		{
			this.viewController = viewController;
			addController(viewController);
		}
		
		public function getController(ident:String):IActorController
		{
			return controllersMap[ident];
		}
		
		public function addController(controller:IActorController):void
		{
			controllersMap[controller.ident] = controller;
			controllers.push(controller);
		}
		
		public function update(dt:Number):void
		{
			var l:int = controllers.length;
			for (var i:int = 0; i < l; i++)
			{
				controllers[i].update(dt);
			}
		}
		
	}

}