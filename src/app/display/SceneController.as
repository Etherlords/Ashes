package display 
{
	import away3d.containers.View3D;
	import characters.Actor;
	/**
	 * ...
	 * @author Nikro
	 */
	public class SceneController 
	{
		
		[Inject]
		public var view:View3D;
		
		public var displayList:DisplayList;
		private var frameTime:Date = new Date();
		
		public function SceneController() 
		{
			inject(this);
			initilize();
		}
		
		public function addDisplayObject(actor:Actor):void
		{
			displayList.addDisplayObject(actor);
		}
		
		public function removeDisplayObject(actor:Actor):void
		{
			displayList.removeDisplayObject(actor);
		}
		
		private function initilize():void
		{
			displayList = new DisplayList(view.scene);
		}
		
		public function update():void
		{
			var t:Number = frameTime.getTime();
			var displayObjects:Vector.<Actor> = displayList.displayList;
			var l:int = displayObjects.length;
			for (var i:int = 0; i < l; i++)
				displayObjects[i].update(t);
		}
		
	}

}