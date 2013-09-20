package mvc.mainscene.logic 
{
	import away3d.containers.Scene3D;
	import away3d.extrusions.Elevation;
	import away3d.materials.methods.BasicDiffuseMethod;
	import away3d.materials.methods.DitheredShadowMapMethod;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.PhongSpecularMethod;
	import away3d.materials.methods.SoftShadowMapMethod;
	import away3d.materials.methods.TerrainDiffuseMethod;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import flash.display.BitmapData;
	import flash.display.Scene;
	import flash.net.FileReference;
	import mvc.mainscene.model.SceneSettings;
	import resources.VFSManager;
	/**
	 * ...
	 * @author Nikro
	 */
	public class TerrainBuilder 
	{
		private static var FLODER:String = 'terrain/';
		
		private static var BEACH:String =	FLODER + 'beach';
		private static var GRASS:String =	FLODER + 'grass_10';
		private static var ROCK:String =	FLODER + 'rock';
		private static var BLEND:String =	FLODER + 'terrain_splats';
		private static var ALBEDO:String =	FLODER + 'terrain_diffuse';
		private static var NORMALS:String =	FLODER + 'terrain_normals';
		private static var HEIGHT:String =	FLODER + 'terrain_heights';
		private var terrainMaterial:TextureMaterial;
		
		public var fogMethod:FogMethod;
		
		public var terrain:Elevation;
		
		
		[Inject]
		public var scene:Scene3D
		
		[Inject]
		public var vfs:VFSManager;
		
		[Inject]
		public var sceneSettings:SceneSettings;
		
		public function TerrainBuilder() 
		{
			inject(this);
			
			fogMethod = new FogMethod(500, 5500, 0x000033);
			
			addToContext(fogMethod);
		}
		
		public var blend:Array = [1, 25, 15, 10];
		
		public function resetBlendMethod():void
		{
			
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
			terrainMaterial.diffuseMethod = terrainMethod;
		}
		
		public function diffuseMethod(isUse:Boolean):void
		{
			if (!isUse)
				terrainMaterial.diffuseMethod = new BasicDiffuseMethod();
			else
				resetBlendMethod();
		}
		
		public function normal(isUse:Boolean):void
		{
			if (!isUse)
				terrainMaterial.normalMap = null;
			else
				terrainMaterial.normalMap = vfs.getFile(NORMALS) as BitmapTexture;
		}
		
		public function light(isUse:Boolean):void
		{
			if (!isUse)
				terrainMaterial.lightPicker = null;
			else
				terrainMaterial.lightPicker = sceneSettings.globalLight;
		}
		
		public function specular(isUse:Boolean):void
		{
			if (!isUse)
				terrainMaterial.specularMap = null;
			else
				terrainMaterial.specularMethod = new PhongSpecularMethod();
		}
		
		public function scale(scale:Number):void
		{
			terrain.scale(scale);
		}
		
		public function build():void
		{
			
			if (terrain)
				terrain.dispose();
				
		

			terrainMaterial = new TextureMaterial(vfs.getFile(ALBEDO) as BitmapTexture, true, true, true);
			
			normal(true);
			light(true);
			specular(true);
			
			terrainMaterial.ambient = 0.0
			terrainMaterial.specular = .05;
			//terrainMaterial.shadowMethod = new SoftShadowMapMethod(sceneSettings.globalLight.lights[0], 5);
			
			resetBlendMethod();
			
			terrain = new Elevation(terrainMaterial, (vfs.getFile(HEIGHT) as BitmapTexture).bitmapData, 5000, 300, 5000, 250, 250, 255, 0, false);
			
			terrain.y = 1000;
			
			terrain.scale(5);
			addToContext(terrain);
			
			
			//terrain.generateSmoothedHeightMap();
			
			
			//scene.addChild(terrain);
			//terrain = new Elevation(terrainMaterial, terrain._activeMap, 5000, 1300, 5000, 250, 250, 255, 0, false);
		
			
			//terrain.scale(5);
			
			
			terrainMaterial.addMethod(fogMethod);
			
			/*waterMethod = new SimpleWaterNormalMethod(Cast.bitmapTexture(WaterNormals), Cast.bitmapTexture(WaterNormals));
			fresnelMethod = new FresnelSpecularMethod();
			fresnelMethod.normalReflectance = .3;
			
			waterMaterial = new TextureMaterial(new BitmapTexture(new BitmapData(512, 512, true, 0xaa404070)));
			waterMaterial.alphaBlending = true;
			waterMaterial.lightPicker = lightPicker;
			waterMaterial.repeat = true;
			waterMaterial.normalMethod = waterMethod;
			waterMaterial.addMethod(new EnvMapMethod(cubeTexture));
			waterMaterial.specularMethod = fresnelMethod;
			waterMaterial.gloss = 100;
			waterMaterial.specular = 1;*/
			
		}
		
	}

}