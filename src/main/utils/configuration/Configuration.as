package utils.configuration 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class Configuration 
	{
		private static var configReaders:Vector.<IConfigReader>;
		
		public function Configuration() 
		{
			if (!configReaders)
				initilize();
		}
		
		private function initilize():void 
		{
			configReaders = new Vector.<IConfigReader>
			configReaders.push(new Bean());
		}
		
		public function processConfig(config:IConfig):void
		{
			var currentConfigList:XMLList;
			var currentSize:int;
			var i:int;
			
			var configReader:IConfigReader;
			var xmlConfig:XML = config.value;
			
			for each(configReader in configReaders)
			{
				currentConfigList = xmlConfig.children().(name() == configReader.ident);
				currentSize = currentConfigList.length();
				
				for (i = 0; i < currentSize; i++)
				{
					configReader.read(currentConfigList[i]);
				}
			}
			
		}
		
	}

}