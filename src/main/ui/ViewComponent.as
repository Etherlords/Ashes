package ui 
{
	import com.bit101.components.Component;
	import com.bit101.components.InputText;
	import com.bit101.utils.MinimalConfigurator;
	import flash.display.Sprite;
	import flash.events.Event;
	import ui.model.IObjectProxy;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ViewComponent extends Sprite
	{
		//public var decorator:UIDecorator;
		private var configurator:MinimalConfigurator;
		
		public var isConfigured:Boolean = false;
		public var config:String;
		public var modelProxy:IObjectProxy;
		
		protected var bindables:Object = { };
		
		public function ViewComponent() 
		{
			configurator = new MinimalConfigurator(this);
			configurator.addEventListener(Event.COMPLETE, onConfigured);
		}
		
		public function executeBind():void
		{
			var fields:Object = modelProxy.getUpdatedFields();
			var some:String;
			for(some in fields)
			{
				if(some in bindables)
					bindables[some](modelProxy[some]);
			}
		}
		
		public function bind(what:Object, to:Object):void
		{
			bindables[what] = to;
		}
		
		public function centerTo(obj:Object):void
		{
			this.x = (obj.width - this.width) / 2;
			this.y = (obj.height - this.height) / 2;
		}
		
		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, internalValidate);
		}
		
		protected function internalValidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, internalValidate);
			validate();
		}
		
		protected function validate():void 
		{
			
		}
		
		public function addComponent(component:Component):void
		{
			component.addEventListener(Event.CHANGE, onComponentChange);
		}
		
		private function onComponentChange(e:Event):void 
		{
			var comp:Component = e.currentTarget as Component;
			
			if(comp is InputText)
				modelProxy[comp.name] = (comp as InputText).text;
		}
		
		protected function onConfigured(e:Event):void 
		{
			isConfigured = true;
			dispatchEvent(e);
			//decorator.processConfig(configurator, this);
		}
		
		public function initilize():void
		{
			configure();
		}
		
		public function configureByString(s:String):void
		{
			configurator.parseXMLString(s);
		}
		
		public function configure():void
		{
			configurator.loadXML(config);
		}
		
	}

}