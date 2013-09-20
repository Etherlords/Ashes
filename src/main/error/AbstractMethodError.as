package error 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class AbstractMethodError extends Error 
	{
		
		public function AbstractMethodError(method:String, id:int = 0) 
		{
			super('Method' 'should be implemented', id);
		}
		
	}

}