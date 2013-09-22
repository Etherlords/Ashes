package  
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class Test extends Sprite 
	{
		
		public function Test() 
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
									
									<notabean/>
									<notevenbean/>
									
								</config>
							
						
			var b:String = 'bean';
			trace(configSource.children().(name() == 'bean').length())
			trace(configSource.(name() == 'bean').length())
		}
		
	}

}