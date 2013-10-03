package error 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class BeanError extends Error 
	{
		
		public function BeanError(message:String, id:int) 
		{
			super(message, id);
		}
		
		public static function beanClassNotDefinedError(bean:String):BeanError
		{
			return new BeanError('Class not defined for bean ' + bean, 0);
		}
		
	}

}