package utils.io 
{
	import flash.utils.ByteArray;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	/**
	 * ...
	 * @author Nikro
	 */
	public class IntTest 
	{
		private var input:ByteArray;
		private var output:ByteArray;
		private var processor:IntOperator;
		
		public function IntTest() 
		{
			
		}
		
		[Before]
		public function before():void
		{
			input = new ByteArray();
			output = new ByteArray();
			
			processor = new IntOperator();
		}
		
		[Test(description="Int serialize fail")]
		public function testSerialize():void
		{
			input.writeInt(1234);
			input.position = 0;
			
			assertThat('check buffer size', processor.serialize(input), equalTo(TypesSize.INT_SIZE));
			assertThat('check serialization value', processor.value, equalTo(1234));
		}
		
		[Test(description="Int deserialize fail")]
		public function testDeserialize():void
		{
			processor.value = 4321;
			var readedSize:int = processor.deserialize(output);
			output.position = 0;
			
			assertThat('check buffer size', readedSize, equalTo(TypesSize.INT_SIZE));
			assertThat('check desirialization value', output.readInt(), equalTo(4321));
		}
		
	}

}