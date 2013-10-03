package mvc.mainscene.logic
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.math.Plane3D;
	import away3d.entities.Entity;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FresnelPlanarReflectionMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.SimpleWaterNormalMethod;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	import away3d.textures.PlanarReflectionTexture;
	import cameracontrollers.GameCamera;
	import characters.GroundCollider3D;
	import characters.Mobile;
	import characters.model.MoveData;
	import characters.PositionSetter3D;
	import core.ui.KeyBoardController;
	import display.ViewController;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import geom.PathMathematic;
	import mvc.mainscene.model.SceneSettings;
	import net.ConnectionManager;
	import resources.VFSManager;
	import utils.DimensionalMath;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class TestScene
	{
		private var sceneSettings:SceneSettings;
		
		private var camera:GameCamera;
		private var charLight:PointLight;
		private var waterMethod:SimpleWaterNormalMethod;
		private var mirroMaterial:ColorMaterial;
		
		private var waterReflection:PlanarReflectionTexture;
		
		[Inject]
		public var scene:Scene3D;
		
		[Inject]
		public var stage:Stage;
		
		[Inject]
		public var view:View3D;
		
		[Inject]
		public var vfs:VFSManager;
		
		private var mobiles:Vector.<Mobile> = new Vector.<Mobile>
		private var actors:Vector.<ViewController> = new Vector.<ViewController>
		
		private var water:Mesh;
		
		private var worldTimeController:WorldTimeController;
		private var pathMath:PathMathematic;
		private var meshBuilder:CharacterBuilder;
		private var connectionManager:ConnectionManager;
		private var terrainBuilder:TerrainBuilder;
		private var keyboardController:KeyBoardController;
		
		public function TestScene()
		{
			inject(this);
			
			initilize();
			
			connectionManager = new ConnectionManager();
			addToContext(connectionManager);
		}
		
		private function initilize():void
		{
			
			var m:Mesh;
			
			keyboardController = new KeyBoardController(stage);
			keyboardController.registerKeyDownReaction(Keyboard.SPACE, onSpacePress);
			worldTimeController = new WorldTimeController();
			addToContext(worldTimeController);
			pathMath = new PathMathematic();
			addToContext(pathMath);
			addToContext(this);
			
			camera = new GameCamera(stage)
			view.camera = camera.camera;
			addToContext(view.camera);
			var light1:DirectionalLight = new DirectionalLight(-0.46, -0.5, -1.35);
			//light1.lookAt(new Vector3D(-4645, -3024));
			
			light1.color = 0xAAAAFF;
			light1.ambientColor = 0xAAAAFF;
			
			light1.ambient = 0.5;
			light1.specular = 2;
			light1.diffuse = 1;
			
			var light:DirectionalLight = new DirectionalLight(0, -1, 1);
			light.color = 0xAAAAAA;
			light.ambient = 0;
			light.specular = 0;
			light.ambient = 0;
			light.diffuse = 1;
			
			light.castsShadows = false;
			light1.castsShadows = true;
			
			sceneSettings = new SceneSettings();
			sceneSettings.globalLight = new StaticLightPicker([light1, light]);
			
			addToContext(sceneSettings);
			
			skyController = new SkyboxController();
			terrainBuilder = new TerrainBuilder();
			meshBuilder = new CharacterBuilder();
			
			addToContext(terrainBuilder);
			
			skyController.build();
			terrainBuilder.build();
			
			addToContext(new GroundCollider3D(terrainBuilder.terrain));
			addToContext(new PositionSetter3D());
			
			m = terrainBuilder.terrain
			
			waterReflection = new PlanarReflectionTexture()
			
			waterMethod = new SimpleWaterNormalMethod((vfs.getFile('waternormals') as BitmapTexture), (vfs.getFile('waternormals') as BitmapTexture));
			var fresnelMethod:FresnelSpecularMethod = new FresnelSpecularMethod();
			fresnelMethod.normalReflectance = 4.1;
			fresnelMethod.fresnelPower = 15;
			
			var waterMaterial:TextureMaterial = new TextureMaterial(new BitmapTexture(new BitmapData(2, 2, false, 0x9999FF)), true, true);
			waterMaterial.alphaBlending = false;
			waterMaterial.lightPicker = new StaticLightPicker([light1]);
			//waterMaterial.repeat = true;
			//waterMaterial.ambientTexture = waterReflection;
			var ripples:FresnelPlanarReflectionMethod = new FresnelPlanarReflectionMethod(waterReflection, 1);
			ripples.fresnelPower = 0.6;
			waterMaterial.addMethodAt(ripples, 0);
			waterMaterial.normalMethod = waterMethod;
			//waterMaterial.addMethod(terrainBuilder.fogMethod);
			
			//waterMaterial.addMethod(new EnvMapMethod(waterReflection));
			waterMaterial.specularMethod = fresnelMethod;
			waterMaterial.gloss = 1500;
			waterMaterial.specular = 2;
			waterMaterial.alpha = 0.6;
			
			water = new Mesh(new PlaneGeometry(15000, 15000, 1, 1, true, false), waterMaterial);
			water.geometry.scaleUV(50, 50);
			
			scene.addChild(water);
			
			water.y = 1325;
			
			waterReflection.plane = new Plane3D(1, 1, 0, 0);
			var planeDelta:Number = 0 //-15;
			waterReflection.plane.fromPoints(new Vector3D(1, -(water.y - planeDelta), 0), new Vector3D(0, -(water.y - planeDelta), 0), new Vector3D(0, -(water.y - planeDelta), 1));
			
			scene.addChild(skyController.skyBox);
			scene.addChild(terrainBuilder.terrain);
		
		/*terrainBuilder.terrain.shaderPickingDetails = true;
		   terrainBuilder.terrain.mouseChildren = true;
		   terrainBuilder.terrain.mouseEnabled = true;
		   terrainBuilder.terrain.pickingCollider = new AutoPickingCollider();
		 terrainBuilder.terrain.addEventListener(MouseEvent3D.MOUSE_DOWN, onTerrainClicked);*/
		}
		
		public function showEffect(effectMoveData:MoveData, playerController:Mobile, spellid:String):void
		{
			trace(spellid);
			var actor:ViewController = meshBuilder.buildEffect(spellid);
			var controller:Mobile = new Mobile(actor);
			
			actor.y = playerController.actor.y + (-5 + Math.random() * 10);
			
			var delta:Number = spellid == "ball" ? 5000 : 15000;
			
			mobiles.push(controller);
			controller.moveData = effectMoveData;
			controller.moveData.travelTime = 1000;
			controller.moveData.startTime = worldTimeController.currentTime
			controller.endTime = controller.createTime + controller.moveData.travelTime + (spellid == "ball" ? 500 : 200);
			controller.update();
			controller.placeOnPosition();
			
			scene.addChild(controller.actor.displayObject);
		}
		
		private function onSpacePress():void
		{
			var fwd:Vector3D = playerController.actor.displayObject.forwardVector;
			
			//connectionManager.sendCastSpell(0, fwd.x * 1000, fwd.z * 1000);
			var ballId:String = keyboardController.isKeyDown(Keyboard.CONTROL) ? "ball" : (keyboardController.isKeyDown(Keyboard.SHIFT) ? 'ball3' : "ball2");
			
			var actor:ViewController = meshBuilder.buildEffect(ballId);
			
			var controller:Mobile = new Mobile(actor);
			
			actor.z = playerController.actor.z + (-5 + Math.random() * 10);
			
			var delta:Number = keyboardController.isKeyDown(Keyboard.CONTROL) ? 5000 : 15000;
			
			mobiles.push(controller);
			controller.moveData.setEndPoint(playerController.actor.x + fwd.x * delta + Math.random() * 100, playerController.actor.y + fwd.z * delta);
			controller.moveData.setStartPoint(playerController.actor.x + fwd.x, playerController.actor.y + fwd.z);
			controller.moveData.travelTime = 4000; // keyboardController.isKeyDown(Keyboard.CONTROL)? 1000:400;
			controller.moveData.startTime = worldTimeController.currentTime
			controller.endTime = controller.createTime + controller.moveData.travelTime + (keyboardController.isKeyDown(Keyboard.CONTROL) ? 500 : 200);
			controller.update();
			controller.placeOnPosition();
			
			scene.addChild(controller.actor.displayObject);
			
			connectionManager.sendCastSpell(ballId, controller.moveData.endPoint.x, controller.moveData.endPoint.y);
		}
		
		private function stop():void
		{
			pathMath.calculateCurrentPosition(playerController.moveData, playerController.moveData.startPoint);
			playerController.moveData.setEndPoint(playerController.moveData.startPoint.x, playerController.moveData.startPoint.y);
			playerController.moveData.startTime = worldTimeController.currentTime;
			playerController.moveData.travelTime = 0;
			connectionManager.sendMoveTo(playerController.moveData.endPoint.x, playerController.moveData.endPoint.y);
			lastMoveVecotr.setTo(0, 0, 0);
		}
		
		private var lastMoveVecotr:Vector3D = new Vector3D();
		private var skyController:SkyboxController;
		
		private function checkMoveing():void
		{
			if (!playerController)
				return;
			
			var player:ViewController = playerController.actor;
			var moveVector:Vector3D = new Vector3D();
			
			if (keyboardController.isKeyDown(Keyboard.W))
				moveVector.incrementBy(ViewController.FORWARD);
			
			if (keyboardController.isKeyDown(Keyboard.A))
				moveVector.incrementBy(ViewController.LEFT);
			
			if (keyboardController.isKeyDown(Keyboard.S))
				moveVector.incrementBy(ViewController.BACKWARD);
			
			if (keyboardController.isKeyDown(Keyboard.D))
				moveVector.incrementBy(ViewController.RIGHT);
			
			if (moveVector.x == 0 && moveVector.y == 0 && moveVector.z == 0)
			{
				if (!lastMoveVecotr.equals(moveVector))
				{
					stop();
					return;
				}
			}
			
			if (lastMoveVecotr.equals(moveVector))
				return;
			
			pathMath.calculateCurrentPosition(playerController.moveData, playerController.moveData.startPoint);
			playerController.moveData.setEndPoint(moveVector.x * 10000 + playerController.moveData.startPoint.x, moveVector.z * 10000 + playerController.moveData.startPoint.y);
			playerController.moveData.startTime = worldTimeController.currentTime
			
			var speed:Number = playerController.moveData.speed;
			var distance:Number = DimensionalMath.distance(playerController.moveData.startPoint, playerController.moveData.endPoint);
			playerController.moveData.travelTime = distance / speed * 1000;
			
			connectionManager.sendMoveTo(playerController.moveData.endPoint.x, playerController.moveData.endPoint.y);
			
			lastMoveVecotr.setTo(moveVector.x, moveVector.y, moveVector.z);
		}
		
		private function onKeyPressW(code:uint):void
		{
			return;
			trace('code', code);
			var forwardVector:Vector3D;
			if (code == Keyboard.W)
				forwardVector = ViewController.FORWARD
			else if (code == Keyboard.A)
				forwardVector = ViewController.LEFT
			else if (code == Keyboard.S)
				forwardVector = ViewController.BACKWARD
			else if (code == Keyboard.D)
				forwardVector = ViewController.RIGHT
			
			pathMath.calculateCurrentPosition(playerController.moveData, playerController.moveData.startPoint);
			playerController.moveData.setEndPoint(forwardVector.x * 10000, forwardVector.z * 10000);
			playerController.moveData.startTime = worldTimeController.currentTime
			
			var speed:Number = playerController.moveData.speed;
			var distance:Number = DimensionalMath.distance(playerController.moveData.startPoint, playerController.moveData.endPoint);
			playerController.moveData.travelTime = distance / speed * 1000;
			
			connectionManager.sendMoveTo(playerController.moveData.endPoint.x, playerController.moveData.endPoint.y);
		}
		
		public function setCameraTarget(target:ObjectContainer3D):void
		{
			camera.setTracingObject(target as Entity)
		}
		
		public function addPlayer():Mobile
		{
			var actor:ViewController = meshBuilder.build('models/hellknigh/');
			var controller:Mobile = new Mobile(actor);
			
			mobiles.push(controller);
			controller.moveData.setEndPoint(100, 100);
			controller.update();
			controller.placeOnPosition();
			controller.endTime = Number.MAX_VALUE;
			addActor(actor);
			
			if (mobiles.length == 1)
				setCameraTarget(actor.displayObject);
			
			return controller;
		}
		
		public function removePlayer(id:String):void
		{
			for (var i:int = 0; i < mobiles.length; i++)
			{
				if (mobiles[i].id == id)
				{
					var toRemove:Mobile = mobiles.splice(i, 1)[0];
					removeActor(toRemove.actor);
					return;
				}
			}
		}
		
		private function removeActor(actor:ViewController):void
		{
			scene.removeChild(actor.displayObject);
			for (var i:int = 0; i < actors.length; i++)
				if (actors[i] == actor)
				{
					actors.splice(i, 1);
					break;
				}
		}
		
		private function addActor(actor:ViewController):void
		{
			scene.addChild(actor.displayObject);
			actors.push(actor);
		}
		
		public function render():void
		{
			checkMoveing();
			worldTimeController.updateTime();
			
			//charLight.position = playerActor.characherMeshModel.mesh.position;
			//charLight.y = playerActor.characherMeshModel.mesh.y + 80;
			
			waterMethod.water1OffsetX += 0.0001;
			waterMethod.water2OffsetX += 0.0001;
			waterMethod.water2OffsetX -= 0.0005;
			waterMethod.water2OffsetY -= 0.0005;
			
			var frameTime:Date = new Date();
			var t:Number = frameTime.getTime();
			
			var l:int = mobiles.length;
			for (var i:int = 0; i < l; i++)
			{
				if (mobiles[i].endTime - worldTimeController.currentTime < 0)
				{
					scene.removeChild(mobiles[i].actor.displayObject);
					mobiles.splice(i, 1)
					
					l--;
					if (i == l)
						break;
				}
				
				mobiles[i].update();
				mobiles[i].actor.update(t);
			}
			
			camera.render();
		}
		
		public function get playerController():Mobile
		{
			if (mobiles.length > 0)
				return mobiles[0];
			else
				return null;
		}
		
		public function renderWater():void
		{
			waterReflection.render(view);
		}
		
		private function onTerrainClicked(e:MouseEvent3D):void
		{
			return;
			pathMath.calculateCurrentPosition(playerController.moveData, playerController.moveData.startPoint);
			playerController.moveData.setEndPoint(e.localPosition.x * terrainBuilder.terrain._scale, e.localPosition.z * terrainBuilder.terrain._scale);
			playerController.moveData.startTime = worldTimeController.currentTime
			
			var speed:Number = playerController.moveData.speed;
			var distance:Number = DimensionalMath.distance(playerController.moveData.startPoint, playerController.moveData.endPoint);
			playerController.moveData.travelTime = distance / speed * 1000;
			
			connectionManager.sendMoveTo(e.localPosition.x * terrainBuilder.terrain._scale, e.localPosition.z * terrainBuilder.terrain._scale);
		}
	
	}
}