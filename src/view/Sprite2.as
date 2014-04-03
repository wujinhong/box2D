package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Sprite2 extends Sprite
	{
		public var i:int;
		
		public var s:Sprite;
		
		public function Sprite2()
		{
			super();
			s = new Sprite();
			addEventListener(Event.ENTER_FRAME, eventHandler2 );
		}
		
		private function eventHandler2(event:Event):void
		{
//			trace( "Sprite2 in event fired" );
//			throw( new Error( "error in " ) );
		}
		public function eventHandler(event:Event):void
		{
//			trace( "Sprite2 out event fired" );
//			throw( new Error( "error out " ) );
		}
	}
}