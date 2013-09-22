package utils.configuration 
{
import core.ioc.Context;

public class MethodLookup implements IProperty
	{
		
		public var instance:Object;
		public var name:String;
		
		public function MethodLookup() 
		{
			
		}
		
		public function assign(obj:Object):void 
		{
			obj[name](instance);
		}
		
		static public function createFromXML(xml:XML):IProperty
		{
			var instance:MethodLookup = new MethodLookup();
			
			instance.name = xml.@[KeyConstants.NAME];
			
			var reference:String = xml.@[KeyConstants.REFERANCE]
			var value:String = xml.@[KeyConstants.VALUE];
			var clazz:String = xml.@[KeyConstants.CLASS_REF];
			
			if (reference)
				fromInstance(reference, instance);
			else
				fromClass(clazz, instance);
				
				
			return instance;
		}
		
		static private function fromClass(clazz:String, instance:MethodLookup):void 
		{
			instance.instance = ClassFactory.createClass(clazz);
		}
		
		static private function fromInstance(reference:String, instance:MethodLookup):void 
		{
			instance.instance = Context.instance.getObjectById(reference);
		}
		
		static public function createFromXMLList(xml:XMLList):Vector.<IProperty>
		{
			if (!xml)
				return null;
				
			var size:int = xml.length();
			var ret:Vector.<IProperty> = new Vector.<IProperty>;
			
			for (var i:int = 0; i < size; i++)
			{
				ret.push(createFromXML(xml[i]));
			}
			
			return ret;
		}
		
		
	}

}