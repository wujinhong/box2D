package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.Dictionary;
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import view.Sprite1;
	import view.Sprite2;
	
	public class Test extends Sprite
	{
		public const WORLD_SCALE:Number = 30;
		public const timeStep:Number = 1/30;
		public const velIterations:int = 8;
		public const posIterations:int = 3;
		public const sleep:Boolean = true;
		
		public var sp1:Sprite1;
		public var sp2:Sprite2;
		private var strongRefDit:Dictionary = new Dictionary();
		private var weakRefDit:Dictionary = new Dictionary( true );
		public var i:int;
		public var s:Sprite;
		private var world:b2World;
		private var bodyDef:b2BodyDef;
		private var fixtureDef:b2FixtureDef;
		private var gravity:b2Vec2;
		public function Test()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			sp1 = new Sprite1();
			sp2 = new Sprite2();
			reference();
			box2D();
			Sprite1.raceGDP();
		}
		
		/**
		 *关于box two D 引擎 
		 */		
		private function box2D():void
		{
			gravity = new b2Vec2( 0, 9.81 );
			world = new b2World( gravity, sleep );
			bodyDef = new b2BodyDef();
			fixtureDef = new b2FixtureDef();
			
			circle( 320, 30, 25 );
			
			brick( 275, 435, 30, 30 );
			brick( 365, 435, 30, 30 );
			brick( 320, 405, 120, 30 );
			brick( 320, 375, 60, 30 );
			brick( 305, 345, 90, 30 );
			brick( 320, 300, 120, 60 );
			
			brick( 320, 912, 910, 20 );
			
			idol( 320, 228 );
			idol( 320, 242, Math.PI/4 );
			idol( 320, 242, -Math.PI/4 );
			
			debugDraw();
			
			addEventListener( Event.ENTER_FRAME, eventHandler );
		}
		private function circle( pX:Number, pY:Number, radius:Number=0 ):void
		{
			bodyDef.position.Set( pX/ WORLD_SCALE, pY / WORLD_SCALE );
			var circleShape:b2CircleShape = new b2CircleShape( radius / WORLD_SCALE );
			fixtureDef.shape = circleShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.8;
			fixtureDef.friction = 0.1;
			bodyDef.type = b2Body.b2_dynamicBody;
			var ball:b2Body = world.CreateBody( bodyDef );
			ball.CreateFixture( fixtureDef );
		}
		private function brick( pX:Number, pY:Number, w:Number, h:Number ):void
		{
			bodyDef.position.Set( pX / WORLD_SCALE, pY / WORLD_SCALE );
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox( w / 2 / WORLD_SCALE, h / 2 / WORLD_SCALE );
			fixtureDef.shape = polygonShape;
			bodyDef.type = b2Body.b2_staticBody;
			var floor:b2Body = world.CreateBody( bodyDef );
			floor.CreateFixture( fixtureDef );
		}
		private function idol( pX:Number, pY:Number, boxAngle:Number=0 ):void
		{
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.position.Set(pX/WORLD_SCALE,pY/WORLD_SCALE);
			var polygonShape:b2PolygonShape=new b2PolygonShape();
			polygonShape.SetAsBox(5/WORLD_SCALE,20/WORLD_SCALE);
			var bW:Number=5/WORLD_SCALE;
			var bH:Number=20/WORLD_SCALE;
			var boxPos:b2Vec2=new b2Vec2(0,10/WORLD_SCALE);
			polygonShape.SetAsOrientedBox( bW, bH, boxPos, boxAngle );
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theIdol:b2Body = world.CreateBody( bodyDef );
			theIdol.CreateFixture( fixtureDef );
		}
		/**
		 * debug draw
		 */
		private function debugDraw():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSpr:Sprite = new Sprite();
			addChild( debugSpr );
			debugDraw.SetSprite( debugSpr );
			debugDraw.SetDrawScale( WORLD_SCALE );
			debugDraw.SetFlags( b2DebugDraw.e_shapeBit );
			debugDraw.SetFillAlpha( .5 );
			world.SetDebugDraw( debugDraw );
		}
		/**
		 *强引用 与 弱引用 
		 */		
		private function reference():void
		{
			addChild( sp1 );
			addChild( sp2 );
			sp1.addEventListener( Event.ENTER_FRAME, sp2.eventHandler, false, 0, true );
			//			sp1.addEventListener( Event.ENTER_FRAME, sp2.eventHandler );
			s = sp2.s;
			removeChild( sp1 );
			removeChild( sp2 );
			weakRefDit[ sp1 ] = sp2;
			sp1 = null;
			sp2 = null;
			
			trace( "子控件个数：", numChildren, typeof( weakRefDit ) );
			System.gc();
			trace( "子控件个数：", numChildren, typeof( weakRefDit ) );
			if ( s == null ) 
			{
				trace( "s 为空 " );
				//				throw( new Error( "error in " ) );
			}
			else
			{
				trace( "s 不为空 " );
				//				throw( new Error( "s 不为空" ) );
			}
		}
		
		protected function eventHandler(event:Event):void
		{
			world.Step( timeStep, velIterations, posIterations );
			world.DrawDebugData();
			world.ClearForces();
			
			
			
			/*trace( "子控件个数：", numChildren, weakRefDit );
			trace( i, "Test event fired" );
			if ( i++ == 100 )
			{
			System.gc();
			}*/
		}
	}
}