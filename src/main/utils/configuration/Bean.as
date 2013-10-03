package utils.configuration 
{
	import error.BeanClassNotDefinedError;
	import error.BeanError;
	
	public class Bean implements IConfigReader
	{
		public static const IDENT:String = 'bean';
		static public const PROPERTY_CREATE_METHOD:String = "createFromXMLList";
		static public const INITILZIE_METHOD:String = 'initilize';
		
		private var config:XML;
		private var instance:Object;
		
		public function Bean() 
		{
			
		}
		
		public function get ident():String
		{
			return IDENT;
		}
		
		public function read(config:XML):void
		{
			this.config = config;
			parse();
		}
		
		private function parse():void 
		{
			var clazz:String = config.@[KeyConstants.CLASS_REF];
			var ident:String = config.@id;
			
			if (!clazz)
				throw BeanError.beanClassNotDefinedError(config[0].toXMLString());
			
			instance = ClassFactory.createClass(clazz);
			
			addToContext(instance, ident);
		}
		
		public function inject():void
		{
			assignPropertys(KeyConstants.PROPERTY, Property);
			assignPropertys(KeyConstants.METHOD_LOOKUP, MethodLookup);
			
			//instance['initilize']();
		}
		
		public function callConstructor():void 
		{
			if (INITILZIE_METHOD in instance)
				instance['initilize']();
		}
		
		private function assignPropertys(type:String, builder:Class):void
		{
			var propertySetters:Vector.<IProperty> = builder[PROPERTY_CREATE_METHOD](config.children().(name() == type));
			
			if (propertySetters)
			{	
				var propertySetter:IProperty
				for (var i:int = 0; i < propertySetters.length; i++)
				{
					propertySetter = propertySetters[i];
					propertySetter.assign(instance);
				}
			}
		}
		
	}

}