package utils.configuration.error 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class ClassReferenceError extends Error 
	{
		
		public function ClassReferenceError(message:String = "") 
		{
			super("Class " + message + " not defined in Application, you should create reference for that class in application", 0);
			
		}
		
	}

}