package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.pick.PickingType;
	import away3d.loaders.misc.SingleFileLoader;
	import away3d.loaders.parsers.ImageParser;
	import away3d.loaders.parsers.MD5AnimParser;
	import away3d.loaders.parsers.MD5MeshParser;
	import away3d.loaders.parsers.ParticleGroupParser;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import mvc.mainscene.logic.MainSceneController;
	import resources.VFSManager;
	
	
	/**
	 * ...
	 * @author Nikro
	 */
	[Frame(factoryClass="PreloadFrame")]
	public class Ashes extends Sprite 
	{
		private var view:View3D;
		private var maiinController:MainSceneController;
		
	
		public function Ashes():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			new ApplicationBootstrap().launch();
			
			view = new View3D();
			
			view.forceMouseMove = true;
			
			
			addChild(view);
			
			SingleFileLoader.enableParser(ImageParser);
			SingleFileLoader.enableParser(ParticleGroupParser);
			SingleFileLoader.enableParser(MD5AnimParser);
			SingleFileLoader.enableParser(MD5MeshParser);
			
			var scene:Scene3D = view.scene;
			var camera:Camera3D = view.camera;
			
			addToContext(scene);
			addToContext(view);
			addToContext(stage);
			
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0xAAAAAA);
			sprite.graphics.drawRect(0, 0, 15, 15);
			addChild(sprite);
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, changeDisplayState);
		
			var vfs:VFSManager = new VFSManager();
			vfs.addEventListener(Event.COMPLETE, onVFSReady);
			
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function changeDisplayState(e:MouseEvent):void 
		{
			if (stage.displayState == StageDisplayState.NORMAL)
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE
			else
				stage.displayState = StageDisplayState.NORMAL
				
				
		}
		
		private function onVFSReady(e:Event):void 
		{
			
			
			t = SoundMixer.soundTransform;
			
			
		}
		
		private var sounds:Array = ['baal.mp3', 'town4.mp3', 'tristram.mp3', 'xtemple.mp3', 'xtown.mp3']
		private var t:Object;
		private function onSoundComplete(e:Event = null):void 
		{
			var music:Sound = new Sound(new URLRequest('https://dl.dropboxusercontent.com/u/11377077/ashes/' + sounds[Math.floor((sounds.length-1) * Math.random())]));
			
			music.play(0, 1, new SoundTransform(0.1)).addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private function onFrame(e:Event):void 
		{
			if(maiinController)
				maiinController.render();
				
			view.render();	
			if (maiinController)
				maiinController.renderWater();
				
				
				
				
			if (t)
			{
				t.volume -= 0.05;
				SoundMixer.soundTransform = t as SoundTransform;
			
				if (t.volume <= 0)
				{
					t = null;
					SoundMixer.stopAll();
					SoundMixer.soundTransform = new SoundTransform(0.5);
					
					var music:Sound = new Sound(new URLRequest('https://dl.dropboxusercontent.com/u/11377077/ashes/xtown.mp3'));
				
					var ch:SoundChannel = music.play(0, 1, new SoundTransform(0.1))
					ch.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
					
					maiinController = new MainSceneController();
				}
			}
				
			view.render();			
				
			if (view.width != stage.stageWidth)
			{
				if(stage.displayState == StageDisplayState.NORMAL)
				{
					view.width = stage.stageWidth;
					view.height = stage.stageHeight;
				}
				else
				{
					view.width = stage.fullScreenWidth;
					view.height = stage.fullScreenHeight;
					stage.fullScreenSourceRect = new Rectangle(0, 0, view.width, view.height);
				}
				
				
			}
			
		}
		
	}
	
}