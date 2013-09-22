package utils.configuration 
{
	import core.ioc.Context;
	import utils.configuration.Bean;
	/**
	 * ...
	 * @author Nikro
	 */
	public class BeanTest 
	{
		private var bean:Bean;
		
		public function BeanTest() 
		{
			
		}
		
		[Before]
		public function setUp():void
		{
			var context:Context = new Context();
			bean = new Bean();
		}
		
		[Test]
		public function testReadBean():void
		{	
			var intOperatorConfig:XML = <bean id="StaticIntOperator" class="utils.io.IntOperator"/>
			
			bean.read(intOperatorConfig);
			
			var config:XML = 	<bean id="Header" class="utils.io.StreamOperator">
									<add class="utils.io.IntOperator" with="addSerializer"/>
									<add instance="StaticIntOperator" with="addSerializer"/>
								</bean>
			
			bean.read(config);
		}
		
	}

}