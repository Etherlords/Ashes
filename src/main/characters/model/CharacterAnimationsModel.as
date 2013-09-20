package characters.model 
{
	
	import away3d.animators.nodes.AnimationNodeBase;
	/**
	 * ...
	 * @author 
	 */
	public class CharacterAnimationsModel 
	{
		private var animationsMap:Object;
		
		public function CharacterAnimationsModel() 
		{
			initilize();
		}
		
		public function addAnimation(animationName:String, animation:AnimationNodeBase):void
		{
			animationsMap[animationName] = animation;
		}
		
		public function getAnimation(animationName:String):AnimationNodeBase
		{
			return animationsMap[animationName];
		}
		
		private function initilize():void 
		{
			animationsMap = [];
		}
		
	}

}