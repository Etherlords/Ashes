package display.builders 
{
	import display.ViewController;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IModelBuilder 
	{
		
		function build(path:String):ViewController;
	}
	
}