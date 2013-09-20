package mvc.mainscene.logic 
{
	import away3d.animators.SkeletonAnimator;
	import away3d.audio.Sound3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.math.Plane3D;
	import away3d.core.pick.AutoPickingCollider;
	import away3d.entities.Mesh;
	import away3d.entities.ParticleGroup;
	import away3d.events.MouseEvent3D;
	import away3d.extrusions.Elevation;
	import away3d.filters.BloomFilter3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.EnvMapMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.PlanarReflectionMethod;
	import away3d.materials.methods.SimpleWaterNormalMethod;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.primitives.SphereGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.textures.CubeReflectionTexture;
	import away3d.textures.PlanarReflectionTexture;
	import cameracontrollers.GameCamera;
	import characters.ViewController;
	
	import characters.model.AnimationModel;
	import core.ui.KeyBoardController;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import mvc.mainscene.model.SceneSettings;
	import resources.VFSManager;
	import utils.DimensionalMath;
	/**
	 * ...
	 * @author Nikro
	 */
	public class MainSceneController 
	{
		private var sceneSettings:SceneSettings;
		private var playerController:PlayerController;
		private var camera:GameCamera;
		private var charLight:PointLight;
		private var ashes:ParticleGroup;
		private var fire:ParticleGroup;
		private var fireLight:PointLight;
		private var waterMethod:SimpleWaterNormalMethod;
		private var mist:ParticleGroup;
		private var mirroMaterial:ColorMaterial;
		
		private var waterReflection:PlanarReflectionTexture;
		private var fireSound:Sound3D;
		private var _flares:Vector.<FlareObject>;
		private var _flareVisible:Boolean = true;
		private var _bloomFilter:BloomFilter3D;
		
		[Inject]
		public var scene:Scene3D;
		
		[Inject]
		public var stage:Stage;
		
		[Inject]
		public var view:View3D;
		
		[Inject]
		public var vfs:VFSManager;
		
		private var mobiles:Vector.<ViewController> = new Vector.<ViewController>
		private var water:Mesh;
		private var lightnings:ParticleGroup;
		
		public function MainSceneController() 
		{
			inject(this);
			
			initilize();
		}
		
		private function initilize():void 
		{
			
			keyboard = new KeyBoardController(stage);
			keyboard.registerKeyDownReaction(Keyboard.SPACE, onCast);
			keyboard.registerKeyDownReaction(Keyboard.NUMBER_1, LowTarget);
			keyboard.registerKeyUpReaction(Keyboard.NUMBER_1, LowUntarget);
			
			
			camera = new GameCamera(stage)
			view.camera = camera.camera;
			
			var light:PointLight = new PointLight();
			
			
			light.ambientColor = 0x000088;
			light.specular = 0;
			light.ambient = 0.2
			light.y = 1500;
			
			light.x += 500;
			
			light.fallOff = 2000;
			light.radius = 1000;
			
			
			
			var light1:DirectionalLight = new DirectionalLight(0, -1, 1);
			light1.lookAt(new Vector3D(1000, -1000, 1000));
			
			
			
			light1.ambient = 0.2;
			light1.specular = 0.2;
			light1.color = 0x000033;
			
			
			
			charLight = new PointLight();
			charLight.color = 0x7777FF;
			charLight.fallOff = 175;
			charLight.radius = 15;
			charLight.ambient = 0.0;
			
			light1.castsShadows = false
			charLight.castsShadows = light.castsShadows = false;
			fireLight = new PointLight();
			fireLight.ambient = 0;
			fireLight.specular = 2;
			
			//scene.addChild(charLight);
			//scene.addChild(light);
			//scene.addChild(light1);
			//scene.addChild(fireLight);
			//scene.addChild(light);
		
			
			sceneSettings = new SceneSettings();
			sceneSettings.globalLight = new StaticLightPicker([light1, charLight, light, fireLight]);
			
			addToContext(sceneSettings);
			
			var skyController:SkyboxController = new SkyboxController();
			terrainBuilder = new TerrainBuilder();
			var meshBuilder:CharacterBuilder = new CharacterBuilder();
			
			skyController.build();
			terrainBuilder.build();
			
			
			
			
			playerController = new PlayerController(terrainBuilder.terrain, meshBuilder.build('models/hellknigh/'));
			var npc3:ViewController = meshBuilder.build('models/hellknigh/');
			var npc1:ViewController = meshBuilder.build('models/hellknigh/');
			var npc4:ViewController = meshBuilder.build('models/hellknigh/');
			var npc2:ViewController = meshBuilder.build('models/hellknigh/');
			
			
			
			
			
			
			var m:Elevation = terrainBuilder.terrain
			
			
			camera.setTracingObject(playerController.actor.characherMeshModel.mesh)
			
			ashes = (vfs.getFile('particles/Ashes') as ParticleGroup);

			
			
			
			fire = (vfs.getFile('particles/fire') as ParticleGroup);
			
		
		
			
			fire.x = -1100
			fire.z = -830;
			
			mist = (vfs.getFile('particles/DustStorm') as ParticleGroup);
			var clouds:ParticleGroup = (vfs.getFile('particles/Clouds') as ParticleGroup);
			
			var t:Timer = new Timer(11100, 0);
			t.addEventListener(TimerEvent.TIMER, lightning);
			t.start();
			
			clouds.y = 3000;
			
			mist.animator.start();
			clouds.animator.start();
			
			
			
			playerController.actor.characherMeshModel.mesh.position = fire.position;
			
			fire.y = m.getHeightAt(fire.x, fire.z) + m.y; 
			//fire.showBounds = true;
			playerController.actor.characherMeshModel.mesh.position = fire.position;
			playerController.actor.characherMeshModel.mesh.x += 100;
			ashes.y = -150;
			
			waterReflection = new PlanarReflectionTexture()
			
			
			
			waterMethod = new SimpleWaterNormalMethod((vfs.getFile('waternormals') as BitmapTexture), (vfs.getFile('waternormals') as BitmapTexture));
			var fresnelMethod:FresnelSpecularMethod = new FresnelSpecularMethod();
			fresnelMethod.normalReflectance = .3;
			
			var waterMaterial:TextureMaterial = new TextureMaterial(new BitmapTexture(new BitmapData(512, 512, true, 0xaa404070)));
			waterMaterial.alphaBlending = true;
			//waterMaterial.lightPicker = sceneSettings.globalLight;
			waterMaterial.repeat = true;
			waterMaterial.addMethod(new PlanarReflectionMethod(waterReflection));
			//waterMaterial.normalMethod = waterMethod;
			
			//waterMaterial.addMethod(new EnvMapMethod(waterReflection));
			//waterMaterial.specularMethod = fresnelMethod;
			//waterMaterial.gloss = 100;
			//waterMaterial.specular = 1;
			
			
			
			water = new Mesh(new PlaneGeometry(5000, 5000, 1, 1, true, false), waterMaterial);
			
			
			scene.addChild(water);
			
			water.y -= 485;
			mist.y = -455;
			
			
			waterReflection.plane = new Plane3D(1, 1, 0, 0);
			var planeDelta:Number = 0//-15;
			waterReflection.plane.fromPoints(new Vector3D(1, -(water.y-planeDelta), 0), new Vector3D(0, -(water.y-planeDelta), 0), new Vector3D(0, -(water.y-planeDelta), 1));
			
			
			
			npc1.characherMeshModel.mesh.position = playerController.mesh.position;
			npc1.characherMeshModel.mesh.x -= 100;
			npc1.characherMeshModel.mesh.z += 100;
			npc1.characherMeshModel.mesh.y = m.getHeightAt(npc1.characherMeshModel.mesh.x, npc1.characherMeshModel.mesh.z) + m.y; 
			npc1.characherMeshModel.mesh.lookAt(fire.position);
			npc1.animationController.playAnimation(new AnimationModel('idle2'));
			
			npc2.characherMeshModel.mesh.position = playerController.mesh.position;
			npc2.characherMeshModel.mesh.x -= 55;
			npc2.characherMeshModel.mesh.z -= 95;
			npc2.characherMeshModel.mesh.y = m.getHeightAt(npc2.characherMeshModel.mesh.x, npc2.characherMeshModel.mesh.z) + m.y; 
			npc2.characherMeshModel.mesh.lookAt(fire.position);
			npc2.animationController.playAnimation(new AnimationModel('idle2', 155 + Math.random() * 200, 0.5));
			
			
			npc3.characherMeshModel.mesh.position = playerController.mesh.position;
			npc3.characherMeshModel.mesh.x -= 145;
			npc3.characherMeshModel.mesh.z -= 100;
			npc3.characherMeshModel.mesh.y = m.getHeightAt(npc3.characherMeshModel.mesh.x, npc3.characherMeshModel.mesh.z) + m.y; 
			npc3.characherMeshModel.mesh.lookAt(fire.position);
			npc3.animationController.playAnimation(new AnimationModel('stand', 155 + Math.random() * 200, 0.5));
			
			npc4.characherMeshModel.mesh.position = playerController.mesh.position;
			npc4.characherMeshModel.mesh.x -= 245;
			npc4.characherMeshModel.mesh.z -= 40;
			npc4.characherMeshModel.mesh.y = m.getHeightAt(npc3.characherMeshModel.mesh.x, npc3.characherMeshModel.mesh.z) + m.y; 
			npc4.characherMeshModel.mesh.lookAt(fire.position);
			npc4.characherMeshModel.mesh.rotationX = 0;
			npc4.characherMeshModel.mesh.rotationZ = 0;
			npc4.animationController.playAnimation(new AnimationModel('stand'));
			
			playerController.charY = m.getHeightAt(playerController.mesh.x, playerController.mesh.z) + m.y; 
			playerController.mesh.y = m.getHeightAt(playerController.mesh.x, playerController.mesh.z) + m.y; 
			
			//waterReflection.position = water.position;
			//waterReflection.position.x -= 600;
			//waterReflection.position.z -= 600;
			//waterReflection.position.y += 150;
		
			new Sound(new URLRequest('https://dl.dropboxusercontent.com/u/11377077/ashes/ambient.mp3')).play(0, 999, new SoundTransform(0.1));
			
			fireSound = new Sound3D(new Sound(new URLRequest('https://dl.dropboxusercontent.com/u/11377077/ashes/campfire.mp3')), playerController.mesh, null, 0.6, 1000);
			fireSound.play();
			
			scene.addChild(fireSound);
			fireSound.position = fire.position;
			
			_bloomFilter = new BloomFilter3D( 2, 2, 0.5, 0, 4 );
		//	view.filters3d = [ _bloomFilter ];
			
			_flares = new Vector.<FlareObject>;
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare10').bitmapData), 2.2, -0.01, 147.9 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare11').bitmapData), 5, 0, 30.6 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare7').bitmapData), 1, 0, 25.5 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare7').bitmapData), 3, 0, 17.85 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare12').bitmapData), 0.4, 0.32, 22.95 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare6').bitmapData), 1, 0.68, 20.4 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare2').bitmapData), 1.25, 1.1, 48.45 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare3').bitmapData), 1.75, 1.37, 7.65 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare4').bitmapData), 2.75, 1.85, 12.75 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare8').bitmapData), 0.5, 2.21, 33.15 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare6').bitmapData), 4, 2.5, 10.4 ) );
			_flares.push( new FlareObject( new Bitmap(vfs.getFile('lensflare/flare7').bitmapData), 6, 2.66, 50 ) );
			
			
			scene.addChild(ashes);
			scene.addChild(fire);
			scene.addChild(mist);
			scene.addChild(clouds);
			
			
			
			scene.addChild(skyController.skyBox);
			scene.addChild(terrainBuilder.terrain);
			
			scene.addChild(playerController.actor.characherMeshModel.mesh);
			scene.addChild(npc1.characherMeshModel.mesh);
			scene.addChild(npc2.characherMeshModel.mesh);
			scene.addChild(npc3.characherMeshModel.mesh);
			scene.addChild(npc4.characherMeshModel.mesh);
			
			ashes.animator.start();
			fire.animator.start();
			
			water.shaderPickingDetails = true;
			water.mouseChildren = true;
			water.mouseEnabled = true;
			water.pickingCollider = new AutoPickingCollider();
			water.addEventListener(MouseEvent3D.MOUSE_DOWN, onTerrainClicked);
			
			//(playerController.mesh.animator as SkeletonAnimator).autoUpdate =true
			playerController.actor.animationQuality = -0.5;
			npc1.animationQuality = npc2.animationQuality = npc3.animationQuality = npc4.animationQuality = 0.2;
			
			mobiles.push(npc1, npc2, npc3, npc4, playerController.actor);
			
			lightning();
			
			for (var i:int = 0; i < fire.particleMeshes.length; i++)
			{
				fire.particleMeshes[i].material['addMethod'](terrainBuilder.fogMethod);
			}
		}
		
		private var lowTarget:ParticleGroup;
		private var low:ObjectContainer3D;
		private var terrainBuilder:TerrainBuilder;
		private var keyboard:KeyBoardController;
		
		private function LowUntarget():void 
		{
			if (lowTarget)
			{
				
				//lowTarget.dispose();
				//lowTarget = null;
			}
		}
		
		private function LowTarget():void 
		{
			if (!lowTarget)
			{
				lowTarget = (vfs.getFile('particles/LowTarget') as ParticleGroup).clone() as ParticleGroup;
				lowTarget.animator.start();
				scene.addChild(lowTarget);
			}
			
		}
		
		private function onCast():void 
		{
			if (low || !lowTarget)
				return;
				
			low = new ObjectContainer3D();
			
			var loweffect:ParticleGroup = (vfs.getFile('particles/LordOfWermillion') as ParticleGroup).clone() as ParticleGroup;
			
			low.y = 1500;
			low.x = lowTarget.x;
			low.z = lowTarget.z;
			
			loweffect.animator.start();
			
			low.addChild(loweffect);
			
			scene.addChild(low);
		}
		
		private function lightning(e:TimerEvent = null):void 
		{
			if(lightnings)
				lightnings.dispose();
				
			lightnings = (vfs.getFile('particles/Ligtnings') as ParticleGroup).clone() as ParticleGroup;
			lightnings.y = 
			lightnings.x = -100 + Math.random() * 200;
			lightnings.y = 3300 + -100 + Math.random() * 200;
			
			lightnings.animator.stop();
			lightnings.animator.start();
			lightnings.rotationZ = Math.random() * 360;
			
			scene.addChild(lightnings);
		}
		
		private function updateBloom():void {
			// Evaluate alignment with the sun.
			var pos:Vector3D = view.camera.position.clone();
			pos.normalize();
			var proj:Number = -pos.dotProduct( Vector3D.X_AXIS );
			if( proj < 0 ) proj = 0;
			proj = Math.pow( proj, 12 );
			// Use value to update bloom strength and sun size.
			_bloomFilter.exposure = 10 * proj;
		}
		
		private function updateFlares():void {
			// Evaluate flare visibility.
			
			var sunScreenPosition:Vector3D = view.project( new Vector3D(2650, 3600, 8000).add(playerController.mesh.position) );
			var xOffset:Number = sunScreenPosition.x - view.width / 2;
			var yOffset:Number = sunScreenPosition.y - view.height / 2;
			var earthScreenPosition:Vector3D = view.project( new Vector3D(0, 990, 0) );
			var earthRadius:Number = 1 * (view.height + 150) / earthScreenPosition.z;
			var flareVisibleOld:Boolean = _flareVisible;
			var delta:Number = 280;
			var sunInView:Boolean = sunScreenPosition.x > -delta && sunScreenPosition.x < view.width + delta && sunScreenPosition.y > -delta && sunScreenPosition.y < view.height +delta && sunScreenPosition.z > -delta;
			var sunOccludedByEarth:Boolean = Math.sqrt( xOffset * xOffset + yOffset * yOffset ) < earthRadius;
			_flareVisible = sunInView && !sunOccludedByEarth;
			// Update flare visibility.
			var flareObject:FlareObject;
			if( _flareVisible != flareVisibleOld) {
				for each ( flareObject in _flares ) {
					if ( _flareVisible )
					{
						flareObject.sprite.alpha = 0;
						
						if(!view.stage.contains(flareObject.sprite))
							view.stage.addChild( flareObject.sprite );
						
						flareObject.sprite.visible = true;
					}
					else if(view.stage.contains(flareObject.sprite))
						//view.stage.removeChild( flareObject.sprite );
						flareObject.sprite.visible = false;
						
						//trace(sunScreenPosition);
					//flareObject.sprite.alpha = 
				}
			}
			// Update flare position.
			if( true ) {
				var flareDirection:Point = new Point( xOffset, yOffset );
				var alp:Number = 1 - ((Math.abs(xOffset) + Math.abs(yOffset)) / 600);
				
				if (alp > 0.6)
					alp = 0.6;
					
				if (alp < 0)
					alp = 0;
				
					
				for each ( flareObject in _flares ) {
					flareObject.sprite.alpha = alp;
					flareObject.sprite.x = sunScreenPosition.x - flareDirection.x * flareObject.position - flareObject.sprite.width / 2;
					flareObject.sprite.y = sunScreenPosition.y - flareDirection.y * flareObject.position - flareObject.sprite.height / 2;
				}
			}
		}
		
		public function renderWater():void
		{
			if(water.worldBounds.isInFrustum(camera.camera.frustumPlanes, camera.camera.frustumPlanes.length))
				waterReflection['render'](view);
		}
		
		public function render():void
		{
			
			if (low)
			{
				low.y -= 80;
				
				if (low.y < -400)
				{
					
					var lowHit:ParticleGroup = (vfs.getFile('particles/LowHit') as ParticleGroup).clone() as ParticleGroup;
					lowHit.x = low.x;
					lowHit.z = low.z;
					
					lowHit.y = terrainBuilder.terrain.getHeightAt(low.x, low.z) + terrainBuilder.terrain.y;
					lowHit.animator.start();
					scene.addChild(lowHit);
					
					
					if (lowHit.y < water.y)
						lowHit.y = water.y  +1;
					
					low = null
				}
			}
			
			if (lowTarget)
			{
				
				lowTarget.y = terrainBuilder.terrain.getHeightAt(lowTarget.x, lowTarget.z) + terrainBuilder.terrain.y;
				if (lowTarget.y < water.y)
					lowTarget.y = water.y  +1;
			}
			
			//waterMethod.water1OffsetX += .0001;
			//waterMethod.water1OffsetY += .0001;
			//waterMethod.water2OffsetX -= .0007;
			//waterMethod.water2OffsetY -= .0006;
			
			var fireR:Number = -50 + Math.random() * 100;
			fireLight.fallOff = 250 + fireR/10;
			fireLight.radius = 85 + fireR;
			fireLight.position = fire.position;
			fireLight.y += 120;
			charLight.position = playerController.actor.characherMeshModel.mesh.position;
			charLight.y = playerController.actor.characherMeshModel.mesh.y + 80;
			if (DimensionalMath.distance(charLight.position, fire.position) < 400)
				charLight.y += (DimensionalMath.distance(charLight.position, fire.position) - 400) ;
			//charLight.showBounds = true;
			
			
			playerController.render();
			//reflection.render(view);
			
		
				
			updateFlares();
			updateBloom();
			//fireSound.update();
			
			var frameTime:Date = new Date();
			var t:Number = frameTime.getTime();
			
			var l:int = mobiles.length;
			for (var i:int = 0; i < l; i++)
			{
				mobiles[i].update(t, camera.camera);
			}
			
			camera.render();
		}
		
		private function onTerrainClicked(e:MouseEvent3D):void 
		{
			
			if (keyboard.isKeyDown(Keyboard.NUMBER_1) && lowTarget)
			{
				
				lowTarget.x = e.localPosition.x;
				
				lowTarget.z = e.localPosition.z;
				
			}
			else
				playerController.moveTo(e.localPosition);
		}
		
	}
	}
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.geom.Point;

class FlareObject
{
	public var sprite:Bitmap;
	public var size:Number;
	public var position:Number;
	public var opacity:Number;

	private const FLARE_SIZE:Number = 134;

	public function FlareObject( sprite:Bitmap, size:Number, position:Number, opacity:Number ) {
		this.sprite = new Bitmap( new BitmapData( sprite.bitmapData.width, sprite.bitmapData.height, true, 0xFFCCCCFF ) );
		this.sprite.bitmapData.copyChannel( sprite.bitmapData, sprite.bitmapData.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA );
		this.sprite.alpha = opacity / 140;
		this.sprite.smoothing = true;
		this.sprite.scaleX = this.sprite.scaleY = size * FLARE_SIZE / sprite.width;
		this.size = size;
		this.position = position;
		this.opacity = opacity;
	}
}



