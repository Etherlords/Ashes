package mvc.mainscene.logic 
{
	import away3d.materials.SkyBoxMaterial;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import flash.display.BitmapData;
	import resources.VFSManager;
	/**
	 * ...
	 * @author Nikro
	 */
	public class SkyboxController 
	{
		public var skyTexture:BitmapCubeTexture;
		
		[Inject]
		public var vfs:VFSManager
		
		public var skyBox:SkyBox
		
		public var skyName:String = 'skybox/grimnight_';
		
		public function SkyboxController() 
		{
			inject(this);
		}
		
		public function build():void
		{
			
			skyTexture = new BitmapCubeTexture
																		(
																			vfs.getFile(skyName + 'posX') as BitmapData, vfs.getFile(skyName+'negX') as BitmapData, 
																			vfs.getFile(skyName + 'posY') as BitmapData, vfs.getFile(skyName+'negY') as BitmapData, 
																			vfs.getFile(skyName + 'posZ') as BitmapData, vfs.getFile(skyName+'negZ') as BitmapData
																		);
			//var skyMaterial:SkyBoxMaterial = new SkyBoxMaterial(skyTexture);
			skyBox = new SkyBox(skyTexture);
			
		}
	}

}