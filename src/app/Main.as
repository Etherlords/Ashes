package  
{
	import core.ioc.Context;
	import flash.display.Sprite;
	import utils.io.IStreamInputOutput;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			super();
			Context.instance.addObjectToContext(stage, 'Stage');
			new XMLBootstrap();
		}
		
	}

}