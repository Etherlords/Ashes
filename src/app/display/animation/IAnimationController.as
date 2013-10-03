package display.animation 
{
	import characters.model.AnimationModel;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IAnimationController 
	{
		function update(currentTimePhase:Number):void;
		
		function set animationQualityRation(value:Number):void;
		
		function set timeScale(value:Number):void;
		
		function set playAnimation(animWalk:AnimationModel):void;
	}
	
}