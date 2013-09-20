package 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.loaders.misc.SingleFileLoader;
	import away3d.loaders.parsers.AWDParser;
	import away3d.loaders.parsers.ImageParser;
	import away3d.loaders.parsers.MD5AnimParser;
	import away3d.loaders.parsers.MD5MeshParser;
	import away3d.loaders.parsers.OBJParser;
	import away3d.loaders.parsers.ParticleGroupParser;
	import cameracontrollers.GameCamera;
	import display.SceneController;
	import flash.display.Sprite;
	import flash.events.Event;
	import geom.PathMathematic;
	import net.ConnectionManager;
	import net.UsersManager;
	import resources.VFSManager;

	[Frame(factoryClass="PreloadFrame")]
	public class TestStage extends Sprite 
	{
		[Inject]
		public var vfs:VFSManager;
		
		[Inject]
		public var gameCamera:GameCamera;
		
		[Inject]
		public var worldTime:WorldTimeController;
		
		private var view:View3D;
		private var maiinController:SceneController;
		private var t:TestTest;
		
		
		
		public function TestStage():void 
		{
			SingleFileLoader.enableParser(ImageParser);
			SingleFileLoader.enableParser(ParticleGroupParser);
			SingleFileLoader.enableParser(MD5AnimParser);
			SingleFileLoader.enableParser(AWDParser);
			SingleFileLoader.enableParser(MD5MeshParser);
			SingleFileLoader.enableParser(OBJParser);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align = 'TL';
			stage.scaleMode = 'noScale';
			
			new ApplicationBootstrap().launch(stage);
			inject(this);
			
			view = new View3D();
			view.antiAlias = 16;
			
			addChild(view);
			view.addChild(new AwayStats(view));
			
			view.camera = gameCamera.camera;
			var camera:Camera3D = view.camera;
			
			addToContext(view);
			addToContext(stage);
			addToContext(camera);
			
			vfs.addEventListener(Event.COMPLETE, onVFSReady);
			
			
		}
		
		private function onVFSReady(e:Event):void 
		{
			maiinController = new SceneController();
			
			addToContext(new UsersManager());
			addToContext(new ConnectionManager());
			addToContext(maiinController);
			
			t = new TestTest();
			
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void 
		{
			if(maiinController)
				maiinController.update();
				
			worldTime.updateTime();
			view.render();
			gameCamera.render();
			
			t.update();
		}
		
	}
	
}