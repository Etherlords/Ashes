package error 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class MethodLookupError extends Error
	{
		
		public function MethodLookupError(message:String, id:int) 
		{
			super(message, id);
		}
		
		static public function badFormatClassOrInstance(toXMLString:String):MethodLookupError 
		{
			return new MethodLookupError('lookup-method have bad format, class or instance not defined ' + toXMLString, 0);
		}
		
	}

}