package display.animation 
{
	import away3d.animators.data.Skeleton;
	import away3d.animators.nodes.SkeletonClipNode;
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import away3d.entities.Mesh;
	import away3d.events.AnimatorEvent;
	import characters.model.AnimationModel;
	
	public class AnimationController implements IAnimationController
	{
		private var _animationQualityRation:Number = 1;
		private static const CROSS_FADE:Number = 0.5;
		
		private var _currentAnimation:AnimationModel;
		
		private var animationSequence:Array;
		private var animator:SkeletonAnimator;
		
		private var _timeScale:Number = 1;
		private var skeleton:Skeleton;
		private var target:Mesh;
		private var animatrionSet:SkeletonAnimationSet;
		private var internalAnimation:SkeletonClipNode;
		private var lastFrame:int = 0;
		private var lastTime:Number = 0;
		
		public function AnimationController(target:Mesh) 
		{
			this.target = target;
			
			initilize();
		}
		
		private function initilize():void 
		{
			animationSequence = [];
			animator = target.animator as SkeletonAnimator;
			animatrionSet = (animator.animationSet as SkeletonAnimationSet);
			
			animator.addEventListener(AnimatorEvent.CYCLE_COMPLETE, onAnimationDone);
			
			animator.updatePosition = false;
		}
		
		public function registerAnimation(animation:SkeletonClipNode):void
		{
			animation.highQuality = true;
			animatrionSet.addAnimation(animation);
		}
		
		private function onAnimationDone(e:AnimatorEvent = null):void 
		{
			if (_currentAnimation)
			{
				_currentAnimation.isCurrentrlyPlaying = false;
				_currentAnimation = null;
			}
			
			var nexAnimation:AnimationModel = animationSequence.shift();
			
			if (nexAnimation)
				playAnimation(nexAnimation);
		}
		
		public function pushAnimation(animation:AnimationModel):void
		{
			animationSequence.push(animation);
		}
		
		public function update(time:Number):void
		{
			if (!internalAnimation)
				return;
				
			var dt:Number = (time - lastTime) / _animationQualityRation;
			
			
			
			if (dt < internalAnimation.totalDuration / timeScale / internalAnimation.frames.length)
				return;
			
			animator.update(time);
			lastTime = time;
		}
		
		public function playAnimation(animation:AnimationModel):void
		{
			if (_currentAnimation)
				onAnimationDone();
				
			if (animation.animationTimeScale != 0)
				timeScale = animation.animationTimeScale;
				
			_currentAnimation = animation;
			animation.isCurrentrlyPlaying = true;
			
			internalAnimation = animatrionSet.getAnimation(animation.animationId) as SkeletonClipNode;
			
			if (animation.startTime != 0)
				var animationPart:Number =   ( internalAnimation.totalDuration - animation.startTime) / internalAnimation.totalDuration;
			
			animator.play(animation.animationId, null, animation.startTime);
		}
		
		public function get timeScale():Number 
		{
			return animator.playbackSpeed;
		}
		
		public function set timeScale(value:Number):void 
		{
			animator.playbackSpeed = value;
		}
		
		public function get currentAnimation():AnimationModel 
		{
			return _currentAnimation;
		}
		
		public function get animationQualityRation():Number 
		{
			return _animationQualityRation;
		}
		
		public function set animationQualityRation(value:Number):void 
		{
			if (value < 1)
				value = 1;
				
			_animationQualityRation = value;
		}
		
		public function clone():AnimationController
		{
			return null
		}
		
	}

}