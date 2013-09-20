package characters.model.mobile 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class AngleMathematic 
	{
		
		public function AngleMathematic() 
		{
			
		}
		
		public static function normalizeAngle(a:Number):Number
		{
			if (a < 0)
				a = 360 + a;
				
			if (a > 360)
				a = a % 360;
				
			return a;
		}
		
	}

}