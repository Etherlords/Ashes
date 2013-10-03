package 
{
	import com.bit101.utils.MinimalConfigurator;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import logic.ui.LobbyWindowController;
	import ui.LobbyWindow;
	import ui.ViewComponent;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Main extends Sprite 
	{
		private var tf:TextField;
		private var tf2:TextField;
		private var lastPath:String = '';
		private var conf:String = '';
		private var instance:ViewComponent;
		private var fl:File = new File();
		private var isFileLoaded:Boolean = false;
		
		public function Main():void 
		{
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			tf = new TextField();
			tf.width = 100;
			tf.height = 20;
			
			tf2 = new TextField();
			tf2.width = 100;
			tf2.height = 20;
			
			addChild(tf);
			addChild(tf2);
			tf.border = true;
			
			var lobbyController:LobbyWindowController = new LobbyWindowController();
			
			addToContext(stage);
			lobbyController.initilize();
			instance = lobbyController.lobbyWindowView;
			
			addChild(instance);
			instance.y = 25;
			
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			fl.addEventListener(Event.SELECT, onBrowseComplete);
			
			tf.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onBrowseComplete(e:Event):void 
		{
			tf.autoSize = TextFieldAutoSize.LEFT;;
			tf.text = fl.nativePath;
			isFileLoaded = true;
			
			tf2.autoSize = TextFieldAutoSize.LEFT;
			
			
			tf2.text = 'open file';
		}
		
		private function onClick(e:MouseEvent):void 
		{
			isFileLoaded = false;
			fl.browseForOpen('open config');
		}
		
		private function onFrame(e:Event):void 
		{
			tf2.x = tf.width + 5;
			syncFile();
		}
		
		private function syncFile():void 
		{
			tf2.text = 'nothink to process';
			
			if (!isFileLoaded)
				return;
				
			tf2.text = 'syncing';
			var f:FileStream = new FileStream();
			f.open(fl, FileMode.READ);
			var r:String = f.readUTFBytes(f.bytesAvailable);
			
			if (r != conf)
			{
				conf = r;
				processConf();
			}
			else
			{
				tf2.text = 'nothink to sync';
			}
			
			f.close();
		}
		
		private function processConf():void
		{
			while (instance.numChildren)
			{
				instance.removeChildAt(0);
			}
			
			//var m:MinimalConfigurator = new MinimalConfigurator(instance);
			//m.parseXMLString(conf);
			instance.configureByString(conf);
			tf2.text = 'config sync';
		}
		
		private function openFile():void 
		{
			
		}
		
	}
	
}