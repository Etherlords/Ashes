package utils 
{
	/**
	 * ...
	 * @author 
	 */
	public class Angle 
	{
		private var _angle:Number = 0;
		
		public function Angle() 
		{
			
		}
		
		public function set angle(value:Number):void
		{
			_angle = value;
			
			if (_angle > 360)
				_angle = _angle - 360;
				
			if (angle < 0)
				_angle = 360 + angle;
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
	}

}