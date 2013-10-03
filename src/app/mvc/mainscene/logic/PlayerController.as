package mvc.mainscene.logic   
{
	import away3d.audio.SoundTransform3D;
	import away3d.entities.Mesh;
	import away3d.extrusions.Elevation;
	import characters.ViewController;
	import characters.AnimationController;
	import characters.model.AnimationModel;
	
	import flash.events.EventDispatcher;
	import flash.geom.Vector3D;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import utils.Angle;
	import utils.DimensionalMath;
	
	public class PlayerController extends EventDispatcher
	{
		private var stepsSound:SoundChannel;
		private var c:SoundLoaderContext;
		
		public var terrain:Elevation;
		
		
		public var actor:ViewController;
		
		protected var steps:Number;
		protected var movieVector:Vector3D;
		
		protected var angleBuff:Angle = new Angle();
		protected var characterAngle:Angle = new Angle();
		
		protected var delta:Number = 0;
		protected var angleto:Number = 0;
		protected var angleSteps:Number = 0;
		
		protected var animationController:AnimationController;
		
		protected var idleAnimation:AnimationModel = new AnimationModel('idle2');
	
		
		public var mesh:Mesh;
		
		
		public function PlayerController(terrain:Elevation, actor:ViewController) 
		{
			this.terrain = terrain;
			this.actor = actor;
			
			c = new SoundLoaderContext(100);
			
			
			
			initilize();
		}
		
		private function play():void
		{
			stop();
			
			if (!stepsSound)
			{
				var steps:Sound = new Sound(new URLRequest('https://dl.dropboxusercontent.com/u/11377077/ashes/steps.wav'), c);
				stepsSound = steps.play(1000 + (-100 + Math.random() * 200), 999, new SoundTransform(0.65));
			}
			else
			{
				var tr:SoundTransform = stepsSound.soundTransform;
				tr.volume = 0.65;
				stepsSound.soundTransform = tr
			}
		}
		
		private function stop():void
		{
			if (stepsSound)
			{
				var tr:SoundTransform = stepsSound.soundTransform;
				tr.volume = 0.0;
				stepsSound.soundTransform = tr
			}
		}
		
		protected function initilize():void 
		{
			idleAnimation.startTime = Math.random() * 2000;
			
			mesh = actor.characherMeshModel.mesh;
		}
		
		public function moveTo(newPosition:Vector3D):void
		{
			play();
			var xspeed:Number = 4.5;
			
			steps = DimensionalMath.distance(mesh.position, newPosition) / (2 * xspeed);
			
			movieVector = DimensionalMath.getMovieVector(mesh.position, newPosition, steps);
			
			mesh.lookAt(newPosition, new Vector3D(0, 1, 0));
			mesh.rotationZ = mesh.rotationX = 0;
			
			
			var walkAnim:AnimationModel = new AnimationModel('walk7');
			walkAnim.animationTimeScale = 1.5;// xspeed;
			walkAnim.startTime = 600;
			
			actor.animationController.playAnimation(walkAnim);
		}
		
		public var charY:Number = 0
		public function render(e:* = null):void
		{
			if (angleSteps > 0)
			{
				
				characterAngle.angle += angleto;
				mesh.rotationY = characterAngle.angle;
				
				angleSteps--;
			}
			
			
			if (steps > 0)
			{
				mesh.x += movieVector.x;
				mesh.z += movieVector.z;
				charY = Math.floor((terrain.getHeightAt(mesh.x, mesh.z) ) + terrain.y);
				
				steps--;
			}
			else
			{
				stop();
				if (!idleAnimation.isCurrentrlyPlaying)
				{
					if (actor.animationController.currentAnimation)
					{
						if (actor.animationController.currentAnimation.animationId != 'idle2' || actor.animationController.currentAnimation.animationId != 'walk7')
						{
							
							if(!actor.animationController.currentAnimation.isCurrentrlyPlaying)
								actor.animationController.playAnimation(idleAnimation);
						}
						else if(!idleAnimation.isCurrentrlyPlaying)
							actor.animationController.playAnimation(idleAnimation);
					}
					else if(!idleAnimation.isCurrentrlyPlaying)
						actor.animationController.playAnimation(idleAnimation);
						
					if (actor.animationController.currentAnimation.animationId == 'walk7')
						actor.animationController.playAnimation(idleAnimation);
				}
			}
			
			if(mesh.y != charY)
				mesh.y += (charY - mesh.y) / 1.5;
			
			
		}
		
		public function getActor():ViewController 
		{
			return actor;
		}
		
	}

}