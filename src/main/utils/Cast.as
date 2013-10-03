package utils 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class Cast 
	{
		static public const NUMBER_TAG:String = ".";
		
		
		static public function cast(value:String):Object 
		{
			var returnValue:Object;
			
			var asInt:Object = parseInt(value);
			
			if (!isNaN(asInt as Number))// && String(asInt).length == value.length)
			{
				if (isNumber(value))
					return parseFloat(value);
				else
					return asInt as int;
			}
			
			return value
		}
		
		
		static public function isNumber(value:String):Boolean
		{
			return value.search(NUMBER_TAG) != -1;
		}
	}

}