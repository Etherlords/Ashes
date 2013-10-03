package display.builders 
{
	import away3d.animators.nodes.SkeletonClipNode;
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import away3d.entities.Mesh;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.PhongSpecularMethod;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import display.ViewController;
	import mvc.mainscene.model.SceneSettings;
	import resources.MD5MeshResource;
	import resources.VFSManager;
	/**
	 * ...
	 * @author Nikro
	 */
	public class MD5ModelBuilder implements IModelBuilder
	{
		
		[Inject]
		public var vfs:VFSManager;
		
		[Inject]
		private var sceneSettings:SceneSettings;
		
		
		
		private var initilizedModels:Object = { };
		
		
		public static const DIFFUSE:String = 'diffuse';
		public static const SPECULAR:String = 'specular';
		public static const NORMALS:String = 'normals';
		public static const ALBEDO:String = 'albedo';
		public static const MESH:String = 'mesh';
		
		public function MD5ModelBuilder() 
		{
			inject(this);
		}
		
		public function build(path:String):ViewController
		{
			var mesh:Mesh;
			
			var resource:MD5MeshResource = vfs.getFile(path + MESH) as MD5MeshResource;
			
			if (!(path in initilizedModels))
			{
				mesh = resource.mesh;
				
				var material:TextureMaterial = new TextureMaterial(vfs.getFile(path + DIFFUSE) as BitmapTexture);
				material.specularMap = vfs.getFile(path + SPECULAR) as BitmapTexture
				material.normalMap = vfs.getFile(path + NORMALS) as BitmapTexture
				//material.lightPicker = sceneSettings.globalLight;
				material.specular = 0.6;
				
				
				material.specularMethod = new FresnelSpecularMethod(true, new PhongSpecularMethod());
				var spc:FresnelSpecularMethod = material.specularMethod as FresnelSpecularMethod;
				spc.fresnelPower = 1;
				spc.normalReflectance = .1;
				
				material.ambientTexture = vfs.getFile(path + ALBEDO) as BitmapTexture
				
				//material.addMethod(fog);
				
				mesh.material = material;
				mesh.castsShadows = false;
				
				if (resource.skeleton)
				{
					
					var animator:SkeletonAnimator = new SkeletonAnimator((resource.animationSet as SkeletonAnimationSet), resource.skeleton);
					var animSet:SkeletonAnimationSet = animator.animationSet as SkeletonAnimationSet;
					//mesh.animator = animator;
					animSet.addAnimation(vfs.getFile(path + 'walk7') as SkeletonClipNode)
					animator.updatePosition = false;
				}
				
				/*var animator:SkeletonAnimator = new SkeletonAnimator((resource.animationSet as SkeletonAnimationSet), resource.skeleton);
				var animSet:SkeletonAnimationSet = animator.animationSet as SkeletonAnimationSet;
				mesh.animator = animator;
				
				animSet.addAnimation(vfs.getFile(path + 'walk7') as SkeletonClipNode)
				animSet.addAnimation(vfs.getFile(path + 'walk7left') as SkeletonClipNode)
				animSet.addAnimation(vfs.getFile(path + 'idle2') as SkeletonClipNode)
				animSet.addAnimation(vfs.getFile(path + 'stand') as SkeletonClipNode)
				animSet.addAnimation(vfs.getFile(path + 'initial') as SkeletonClipNode)*/
				
				initilizedModels[path] = true;
			}
			
			mesh = resource.mesh.clone() as Mesh;
			//mesh.animator['autoUpdate'] = true;
			//mesh.animator['play']('walk7');
			//mesh.animator['updatePosition'] = false;
			//mesh.scale(0.25);

			var viewController:ViewController = new ViewController(mesh);
			
			return viewController;
		}
		
	}

}