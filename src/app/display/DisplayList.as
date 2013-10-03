package display 
{
	import away3d.containers.Scene3D;
	import characters.Actor;
	/**
	 * ...
	 * @author Nikro
	 */
	public class DisplayList 
	{
		public var displayList:Vector.<Actor> = new Vector.<Actor>;
		private var scene:Scene3D;
		
		public function DisplayList(scene:Scene3D) 
		{
			this.scene = scene;	
		}
		
		public function addDisplayObject(actor:Actor):void
		{
			displayList.push(actor);
			scene.addChild(actor.viewController.displayObject);
		}
		
		public function removeDisplayObject(actor:Actor):void
		{
			var l:int = displayList.length;
			
			for (var i:int = 0; i < l; i++)
				if (displayList[i] == actor)
					displayList.splice(i, 1);
					
			scene.removeChild(actor.viewController.displayObject);
		}
	}

}