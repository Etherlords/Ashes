package utils.io 
{
	import flash.utils.ByteArray;
	import org.hamcrest.assertThat;
	/**
	 * ...
	 * @author Nikro
	 */
	public class IntTest 
	{
		private var input:ByteArray;
		private var output:ByteArray;
		private var intProcessor:Int;
		
		public function IntTest() 
		{
			
		}
		
		[Before]
		public function before():void
		{
			input = new ByteArray();
			output = new ByteArray();
			
			intProcessor = new Int();
		}
		
		[Test(description="Int serialize fail")]
		public function testSerialize():void
		{
			input.writeInt(1234);
			input.position = 0;
			assertThat(intProcessor.serialize(input), 1234);
			
		}
		
		[Test(description="Int deserialize fail")]
		public function testDeserialize():void
		{
			intProcessor.value = 4321;
			intProcessor.deserialize(output);
			output.position = 0;
			
			assertThat(output.readInt(), 4321);
		}
		
	}

}