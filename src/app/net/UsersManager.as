package net 
{
	import characters.Actor;
	import display.builders.MD5ModelBuilder;
	import display.SceneController;
	import display.ViewController;

	public class UsersManager 
	{
		[Inject]
		public var sceneController:SceneController;
		
		[Inject]
		public var md5Builder:MD5ModelBuilder;
		
		private var charactersList:Object = { };
		
		public function UsersManager() 
		{
			inject(this);
		}
		
		public function getUser(id:String):Actor
		{
			return charactersList[id];
		}
		
		public function createNewUser(id:String):Actor
		{
			var view:ViewController = md5Builder.build('models/hellknigh/');
			var actor:Actor = new Actor(view);
			sceneController.addDisplayObject(actor);
			actor.id = id;
			charactersList[id] = actor;
			return actor;
		}
		
		public function removeUser(id:String):void
		{
			sceneController.removeDisplayObject(charactersList[id]);
			delete charactersList[id];
		}
		
	}

}