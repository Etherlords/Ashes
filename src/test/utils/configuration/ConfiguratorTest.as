package utils.configuration 
{
	import core.ioc.Context;
	import org.hamcrest.assertThat;
	import org.hamcrest.assertThatBoolean;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ConfiguratorTest 
	{
		private var bean:Bean;
		
		public function ConfiguratorTest() 
		{
			
		}
		
		[Before]
		public function setUp():void
		{
			var context:Context = new Context();
			bean = new Bean();
		}
		
		[Test]
		public function testConfigure():void
		{	
			var configSource:XML = 
								<config>
	
									<bean class="utils.io.IntOperator" id="IntOperator"/>
									<bean class="utils.io.DoubleOperator" id="DoubleOperator"/>
									<bean class="utils.io.PointOperator" id="PointOperator"/>
									
									<bean id="Header" class="utils.io.StreamOperator">
										<add instance="IntOperator" with="addSerializer"/>
										<add instance="IntOperator" with="addSerializer"/>
										<add instance="DoubleOperator" with="addSerializer"/>
									</bean>
									
								</config>
							
			var config:InternalXMLConfig = new InternalXMLConfig(configSource);
							
			var configuration:Configuration = new Configuration();
			configuration.processConfig(config);
			
			assertThat('check IntOperator in context', Boolean(Context.instance.getObjectById('IntOperator')));
			assertThat('check DoubleOperator in context', Boolean(Context.instance.getObjectById('DoubleOperator')));
			assertThat('check PointOperator in context', Boolean(Context.instance.getObjectById('PointOperator')));
		}
		
	}

}