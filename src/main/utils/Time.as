package utils 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class Time 
	{
		private static var startTime:Date = new Date();
		private static var timeBuffer:Date = new Date();
		
		private static var startTimeInMsec:Number = 0;
		
		public function Time() 
		{
			
			startTimeInMsec = timeBuffer.getDate();
		}
		
		public static function get timeMSec():Number
		{
			var h:Number = startTime.getHours();
			var m:Number = startTime.getMinutes();
			
			trace(h, m);
			
			return 0;
		}
		
		public function get time():Number
		{
			return 0;
		}
		
	}

}