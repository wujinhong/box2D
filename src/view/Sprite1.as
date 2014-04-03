package view
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Sprite1 extends Sprite
	{
		public function Sprite1()
		{
			super();
			//			addEventListener(Event.ENTER_FRAME, eventHandler );
		}
		
		public function eventHandler(event:Event):void
		{
			trace( "Sprite1 event fired" );
		}
		
		public static function raceGDP():void
		{
			var population_cn:Number = 13.5404;
			var population_us:Number = 3.15250;
			var pop:Number = population_cn / population_us;
			var exchange:Number = 1.02;//未来汇率增长变化
			var rate_usa:Number = 0, rate_cn:Number = 1.076;//平均增长率
			var rate_cn_low:Number = 1.075, rate_usa_top:Number = 1.03;//最慢增长率
			var rate_cn_top:Number = 1.077, rate_usa_low:Number = 1.02;//最快增长率
			var cn:Number = 90386.6, usa:Number = 161979.6;
			
			var rate_usa_vec:Vector.<Number> = new <Number>[ -0.26,3.40,//美国近十几年GDP增长率
				2.87,4.11,2.55,3.79,4.51,4.40,4.87,4.17,1.09,1.83,2.55,
				3.48,3.08,2.66,1.91,-0.36,-3.53,3.02,1.70,2.20,1.9 ];
			for (var j:int = 0; j < rate_usa_vec.length; j++) 
			{
				rate_usa += rate_usa_vec[ j ];
			}
			rate_usa /= rate_usa_vec.length;
			rate_usa /= 100;
			rate_usa += 1;
			
			var year:uint = 0;
			var all_cn:Number = cn, all_usa:Number = usa;
			
			
			year = 0;
			all_cn = cn, all_usa = usa;
			while( all_cn < all_usa )
			{
				year++;
				all_cn *= rate_cn_low;
				all_usa *= rate_usa_top;
			}
			trace( "最慢" + year + "年后中国的GDP：" + toPrecision( all_cn ) + "超过美国的GDP:" + toPrecision( all_usa ) );
			
			year = 0;
			all_cn = cn, all_usa = usa;
			while( all_cn < all_usa )
			{
				year++;
				all_cn *= rate_cn;
				all_usa *= rate_usa;
			}
			trace( "最有可能" + year + "年后中国的GDP：" + toPrecision( all_cn ) + "超过美国的GDP:" + toPrecision( all_usa ) );
			
			year = 0;
			all_cn = cn, all_usa = usa;
			while( all_cn < all_usa )
			{
				year++;
				all_cn *= ( rate_cn_top * exchange );
				all_usa *= rate_usa_low;
			}
			trace( "最快" + year + "年后中国的GDP：" + toPrecision( all_cn ) + "超过美国的GDP:" + toPrecision( all_usa ) );
			
			/********人均*************/
			year = 0;
			all_cn = cn, all_usa = usa;
			while( all_cn / pop < all_usa )
			{
				year++;
				all_cn *= rate_cn_low;
				all_usa *= rate_usa_top;
			}
			trace( "最慢" + year + "年后人均超过美国。中国的GDP：" + toPrecision( all_cn ) + "，美国的GDP:" + toPrecision( all_usa ) );
			
			year = 0;
			all_cn = cn, all_usa = usa;
			while( all_cn / pop < all_usa )
			{
				year++;
				all_cn *= rate_cn;
				all_usa *= rate_usa;
			}
			trace( "最有可能" + year + "年后人均超过美国。中国的GDP：" + toPrecision( all_cn ) + "，美国的GDP:" + toPrecision( all_usa ) );
			
			year = 0;
			all_cn = cn, all_usa = usa;
			while( all_cn / pop < all_usa )
			{
				year++;
				all_cn *= ( rate_cn_top * exchange );
				all_usa *= rate_usa_low;
			}
			trace( "最快" + year + "年后人均超过美国。中国的GDP：" + toPrecision( all_cn ) + "，美国的GDP:" + toPrecision( all_usa ) );
			/********人均*************/
		}
		private static function toPrecision( num:Number, p:uint=1 ):String
		{
			return new Number( num ).toFixed( p );
		}
	}
}