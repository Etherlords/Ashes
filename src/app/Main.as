package  
{
	import core.ioc.Context;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			super();
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			Context.instance.addObjectToContext(stage, 'Stage');
			
			new XMLBootstrap();
		}
		
	}

}