package utils.configuration 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class Configuration 
	{
		private static var configReaders:Vector.<Class>;
		
		public function Configuration() 
		{
			if (!configReaders)
				initilize();
		}
		
		private function initilize():void 
		{
			configReaders = new Vector.<Class>
			configReaders.push(Bean);
		}
		
		public function processConfig(config:IConfig):void
		{
			var currentConfigList:XMLList;
			var currentSize:int;
			var i:int;
			
			var configReader:IConfigReader;
			var xmlConfig:XML = config.value;
			
			var configurators:Vector.<IConfigReader> = new Vector.<IConfigReader>;
			
			for each(var constructor:Class in configReaders)
			{
				configReader = new constructor();
				currentConfigList = xmlConfig.children().(name() == configReader.ident);
				currentSize = currentConfigList.length();
				
				for (i = 0; i < currentSize; i++)
				{
					configReader = new constructor();
					configReader.read(currentConfigList[i]);
					configurators.push(configReader);
				}
			}
			
			for (i = 0; i < configurators.length; i++)
			{
				configurators[i].inject();
			}
			
			for (i = 0; i < configurators.length; i++)
			{
				configurators[i].callConstructor();
			}
			
		}
		
	}

}