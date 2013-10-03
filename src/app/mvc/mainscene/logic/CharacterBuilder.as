package mvc.mainscene.logic 
{
	import away3d.animators.nodes.SkeletonClipNode;
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import away3d.entities.Mesh;
	import away3d.entities.ParticleGroup;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.PhongSpecularMethod;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import display.ViewController;
	
	import characters.model.CharacterMeshModel;
	import mvc.mainscene.model.SceneSettings;
	import resources.MD5MeshResource;
	import resources.VFSManager;
	/**
	 * ...
	 * @author Nikro
	 */
	public class CharacterBuilder 
	{
		[Inject]
		public var vfs:VFSManager;
		
		[Inject]
		public var sceneSettings:SceneSettings;
		
		[Inject]
		public var fog:FogMethod;
		
		public function CharacterBuilder() 
		{
			inject(this);
		}
		
		private var initilize:Boolean = false;
		
		public function build(path:String):ViewController
		{
			var mesh:Mesh;
			
			var resource:MD5MeshResource = vfs.getFile(path + 'mesh') as MD5MeshResource;
			
			if (!initilize)
			{
				mesh = resource.mesh;
				
				var material:TextureMaterial = new TextureMaterial(vfs.getFile(path + 'diffuse') as BitmapTexture);
				material.specularMap = vfs.getFile(path + 'specular') as BitmapTexture
				material.normalMap = vfs.getFile(path + 'normals') as BitmapTexture
				material.lightPicker = sceneSettings.globalLight;
				material.specular = 0.6;
				
				
				material.specularMethod = new FresnelSpecularMethod(true, new PhongSpecularMethod());
				var spc:FresnelSpecularMethod = material.specularMethod as FresnelSpecularMethod;
				spc.fresnelPower = 1;
				spc.normalReflectance = .1;
				
				material.ambientTexture = vfs.getFile(path + 'albedo') as BitmapTexture
				
				material.addMethod(fog);
				
				mesh.material = material;
				mesh.castsShadows = false;
			
				
				var animator:SkeletonAnimator = new SkeletonAnimator((resource.animationSet as SkeletonAnimationSet), resource.skeleton);
				var animSet:SkeletonAnimationSet = animator.animationSet as SkeletonAnimationSet;
				mesh.animator = animator;
				
				animSet.addAnimation(vfs.getFile(path + 'walk7') as SkeletonClipNode)
				animSet.addAnimation(vfs.getFile(path + 'walk7left') as SkeletonClipNode)
				animSet.addAnimation(vfs.getFile(path + 'idle2') as SkeletonClipNode)
				animSet.addAnimation(vfs.getFile(path + 'stand') as SkeletonClipNode)
				animSet.addAnimation(vfs.getFile(path + 'initial') as SkeletonClipNode)
			}
			
			
			mesh = resource.mesh.clone() as Mesh;

			var actor:ViewController = new ViewController(mesh);
			
			initilize = true;
			
			return actor;
		}
		
		public function buildEffect(effectName:String):ViewController
		{
			//C:\git\Ashes\asset\particles
			
			var effect:ParticleGroup = (vfs.getFile('particles/' + effectName) as ParticleGroup).clone() as ParticleGroup;
			effect.animator.start();
			var actor:ViewController = new ViewController(effect);
			
			return actor;
		}
		
	}

}