package ui 
{
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	import flash.events.Event;
	/**
	 * ...
	 * @author Nikro
	 */
	public class LoginWindow extends ViewComponent
	{
		
		public var login:String = '';
		public var password:String = '';
		
		public var loginButton:PushButton;
		
		public function LoginWindow() 
		{
			
		}
		
		override protected function onConfigured(e:Event):void 
		{
			invalidate();
		}
		
		override protected function validate():void 
		{
			centerTo({width:stage.stageWidth, height:stage.stageHeight});
		}
		
		public function onLogOn(e:Event = null):void
		{
			dispatchEvent(new Event('Login'));
		}
		
	}

}