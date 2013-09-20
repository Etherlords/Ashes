package characters.model 
{
	import away3d.animators.data.Skeleton;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;

	/**
	 * ...
	 * @author 
	 */
	public class CharacterMeshModel 
	{
		
		
		private var _mesh:ObjectContainer3D
		private var _skeleton:Skeleton;
		
		private var animationList:CharacterAnimationsModel
		
		public function CharacterMeshModel() 
		{
			
		}
		
		public function get mesh():ObjectContainer3D 
		{
			return _mesh;
		}
		
		public function set mesh(value:ObjectContainer3D):void 
		{
			_mesh = value;
		}
		
		public function get skeleton():Skeleton 
		{
			return _skeleton;
		}
		
		public function set skeleton(value:Skeleton):void 
		{
			_skeleton = value;
		}
		
	}

}