package characters.model.mobile 
{
	import away3d.entities.Mesh;
	import away3d.extrusions.Elevation;
	import display.ViewController;
	import flash.geom.Vector3D;
	import utils.DimensionalMath;
	/**
	 * ...
	 * @author Nikro
	 */
	public class PositionSetter3D 
	{
		
		public static const RAD_TO_DEGREE:Number = -180 / Math.PI;
		
		[Inject]
		public var groundCollider:GroundCollider3D;
		
		[Inject]
		public var terrain:Elevation;
		
		//public var currentPosition:Point = new Point();
		
		private static const angleMathHelper:Vector3D = new Vector3D();
		
		public function PositionSetter3D() 
		{
			inject(this);
		}
		
		public function applyPosition(actor:ViewController, position:Vector3D):Number
		{
			//currentPosition = position;
			angleMathHelper.x = actor.x;
			angleMathHelper.y = actor.y;
			
			//actor.displayObject.rotationY = (DimensionalMath.angle(angleMathHelper, position) * RAD_TO_DEGREE) + 90;
			//= (DimensionalMath.angle(angleMathHelper, position) * RAD_TO_DEGREE) ;
			
			//actor.displayObject.lookAt(angleMathHelper, Vector3D.Y_AXIS);
			//actor.displayObject.rotationZ = actor.displayObject.rotationX = 0;
			
			//if(actor.displayObject is Mesh)
			//	actor.z = groundCollider.getZOfPosition(position);
			//else
			//	actor.characherMeshModel.mesh.y = terrain.y;
				
			actor.x = position.x;
			actor.y = position.y;
			//Math.ceil
			var a:Number = ((DimensionalMath.angle(angleMathHelper, position) * RAD_TO_DEGREE) + 90);
			
			if (a < 0)
				a = 360 + a;
				
			if (a > 360)
				a = a - 360;
				
			//trace(a)
			return a;
		}
		
		
		
	}

}