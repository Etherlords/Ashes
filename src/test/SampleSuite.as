package 
{
	import utils.io.DoubleTest;
	import utils.io.IntTest;
	import utils.io.PointTest;
	import utils.io.StreamOperatorTest;
	
	
	[Suite] 
	[RunWith("org.flexunit.runners.Suite")]
	public class SampleSuite
	{
		
		public var intTest:IntTest;
		public var doubleTest:DoubleTest;
		public var pointTest:PointTest;
		public var streamTest:StreamOperatorTest;
	}

}