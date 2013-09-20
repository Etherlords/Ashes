package  
{
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.TerrainDiffuseMethod;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	import characters.Actor;
	import characters.model.mobile.MobileController;
	import characters.model.mobile.PositionSetter3D;
	import display.builders.MD5ModelBuilder;
	import display.SceneController;
	import display.ViewController;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mvc.mainscene.model.SceneSettings;
	import resources.VFSManager;
	
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class TestTest 
	{
		
		private static var FLODER:String = 'terrain/';
		
		private static var BEACH:String =	FLODER + 'beach';
		private static var GRASS:String =	FLODER + 'grass_10';
		private static var ROCK:String =	FLODER + 'rock';
		private static var BLEND:String =	FLODER + 'terrain_splats';
		private static var ALBEDO:String =	FLODER + 'terrain_diffuse';
		private static var NORMALS:String =	FLODER + 'terrain_normals';
		private static var HEIGHT:String =	FLODER + 'terrain_heights';
		
		[Inject]
		public var scene:SceneController;
		
		[Inject]
		public var md5Builder:MD5ModelBuilder;
		
		[Inject]
		public var vfs:VFSManager;
		
		private var vv:Vector.<MobileController> = new Vector.<MobileController>;
		
		public function TestTest() 
		{
			inject(this);
			
			var sceneSettings:SceneSettings = new SceneSettings();
			sceneSettings.globalLight = new StaticLightPicker([new DirectionalLight()]);
			

			var positionSetter:PositionSetter3D = new PositionSetter3D();
			
			for (var i:int = 0; i < 1; i++)
			{
				var view:ViewController = md5Builder.build('models/hellknigh/');
				view.displayObject.scale(100);
				
				view.displayObject['material'].lightPicker = sceneSettings.globalLight;
				var mobileController:MobileController = new MobileController(view, positionSetter);
				vv.push(mobileController);
				var actor:Actor = new Actor(view);
				actor.addController(mobileController);
				
				scene.addDisplayObject(actor);
				
			//	mobileController.moveTo(0, 0)//-1000+Math.random() * 2000, -1000+Math.random() * 2000);
			}
			
			var t:Timer = new Timer(1000, 0);
			t.addEventListener(TimerEvent.TIMER, ont);
			//t.start();
			
			var plane:Mesh = new Mesh(new PlaneGeometry(5000, 5000, 1, 1), new TextureMaterial(vfs.getFile(BEACH) as BitmapTexture, true, false, true));
			
			var terrainMethod:TerrainDiffuseMethod = new TerrainDiffuseMethod
																				(
																					[	
																						vfs.getFile(BEACH) as BitmapTexture,
																						//new BitmapTexture(new BitmapData(2, 2, true, 0xFFFF0000)),
																						vfs.getFile(GRASS) as BitmapTexture,
																						//new BitmapTexture(new BitmapData(2, 2, true, 0xFF00FF00)),
																						vfs.getFile(ROCK) as BitmapTexture
																						//new BitmapTexture(new BitmapData(2, 2, true, 0xFF0000FF))
																					],
																					
																					vfs.getFile(BLEND) as BitmapTexture,
																					blend
																				);
			plane.material['diffuseMethod'] = terrainMethod;
			
			scene.view.scene.addChild(plane);
			
			keyboardController = new KeyboardPlayerController(actor);
		}
		
		public function update():void
		{
			keyboardController.update();
		}
		
		public var blend:Array = [1, 40, 5, 3];
		private var b:Boolean = true;
		private var keyboardController:KeyboardPlayerController;
		private function ont(e:TimerEvent):void 
		{
			var xx:Number
			var yy:Number
			
			b = !b;
			
			
			for (var i:int = 0; i < vv.length; i++)
			{
				
			if (b)
			{
				xx = -1000+Math.random() * 2000;
				yy = -1000+Math.random() * 2000;
			}
			else
			{
				xx = 0;
				yy = 0;
			}
				
				vv[i].moveTo(xx, yy);
			}
		}
		
	}

}