package 
{

	import net.DataReaderTest;
	import utils.CastTest;
	import utils.configuration.BeanTest;
	import utils.configuration.ConfiguratorTest;
	import utils.io.DoubleTest;
	import utils.io.IntTest;
	import utils.io.PointTest;
	import utils.io.StreamOperatorTest;
	import utils.io.UTFStringOperatorTest;
	
	
	[Suite] 
	[RunWith("org.flexunit.runners.Suite")]
	public class SampleSuite
	{
		
		public var intTest:IntTest;
		public var doubleTest:DoubleTest;
		public var pointTest:PointTest;
		public var utfStringOperator:UTFStringOperatorTest;
		public var streamTest:StreamOperatorTest;
		
		public var dateReaderTest:DataReaderTest;
		
		public var castTest:CastTest;
		
		public var beanTest:BeanTest;
		public var configTest:ConfiguratorTest;
	}

}