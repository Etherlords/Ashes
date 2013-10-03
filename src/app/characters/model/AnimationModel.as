package characters.model 
{
	/**
	 * ...
	 * @author 
	 */
	public class AnimationModel 
	{
		
		private var _animationTimeScale:Number = 0;
		private var _animationId:String;
		private var _isCurrentrlyPlaying:Boolean;
		private var _isLoop:Boolean;
		private var _startTime:Number = 0;
		
		public function AnimationModel(animationId:String = '', startTime:int = 0, animationTimeScale:Number = 0) 
		{
			_animationTimeScale = animationTimeScale;
			_startTime = startTime;
			_animationId = animationId;
		}
		
		public function get animationId():String 
		{
			return _animationId;
		}
		
		public function set animationId(value:String):void 
		{
			_animationId = value;
		}
		
		public function get animationTimeScale():Number 
		{
			return _animationTimeScale;
		}
		
		public function set animationTimeScale(value:Number):void 
		{
			_animationTimeScale = value;
		}
		
		public function get isCurrentrlyPlaying():Boolean 
		{
			return _isCurrentrlyPlaying;
		}
		
		public function set isCurrentrlyPlaying(value:Boolean):void 
		{
			_isCurrentrlyPlaying = value;
		}
		
		public function get isLoop():Boolean 
		{
			return _isLoop;
		}
		
		public function get startTime():Number 
		{
			return _startTime;
		}
		
		public function set startTime(value:Number):void 
		{
			_startTime = value;
		}
		
	}

}