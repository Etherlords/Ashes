package utils.configuration 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class InternalXMLConfig implements IConfig 
	{
		private var _value:XML;
		
		public function InternalXMLConfig(value:XML) 
		{
			_value = value;
			
		}
		
		public function get type():String 
		{
			return '';
		}
		
		public function get value():XML 
		{
			return _value;
		}
		
	}

}