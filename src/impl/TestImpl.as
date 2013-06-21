package impl
{
	public class TestImpl
	{
		private static var _instance:TestImpl;
		private var s:String = "";
		public var str:String = "123";
		public function TestImpl()
		{
//			dizzy();
		}
		
		public static function get():TestImpl
		{
			if ( null == _instance ) 
			{
				_instance = new TestImpl();
			}
			return _instance;
		}
		private function dizzy():void
		{
			trace(123);
		}
		public function dizzy():void
		{
			trace(123);
		}
	}
}