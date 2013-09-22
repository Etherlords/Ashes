package  
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	import utils.configuration.Configuration;
	import utils.configuration.InternalXMLConfig;
	/**
	 * ...
	 * @author Nikro
	 */
	public class XMLBootstrap 
	{
		private var loader:URLLoader;
		private var config:InternalXMLConfig;
		private var classesRef:ClassesReference = new ClassesReference();
		
		public function XMLBootstrap() 
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onConfigLoaded);
			loader.load(new URLRequest('config/mainconfig.xml'));
		}
		
		private function onConfigLoaded(e:Event):void 
		{
			config = new InternalXMLConfig(new XML(loader.data));
			launch();
		}
		
		public function launch():void
		{
			trace('Ashes.launch');
			var configurator:Configuration = new Configuration();
			configurator.processConfig(config);
			loader.close();
			System.disposeXML(config.value);
			configurator = null;
		}
		
	}

}