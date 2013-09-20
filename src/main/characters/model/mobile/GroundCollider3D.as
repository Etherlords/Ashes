package characters.model.mobile 
{
	import away3d.extrusions.Elevation;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Nikro
	 */
	public class GroundCollider3D 
	{
		
		private var waterLevel:Number = 1320;
		private var terrain:Elevation
		
		public function GroundCollider3D(terrain:Elevation) 
		{
			this.terrain = terrain;
			
		}
		
		public function getZOfPosition(position:Vector3D):Number 
		{
			var z:Number = terrain.getHeightAt(position.x, position.y) + terrain.y;
			
			if (z < waterLevel)
				return waterLevel;
			
			return z;
		}
		
	}

}