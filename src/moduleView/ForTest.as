package moduleView
{
	import flash.display.GraphicsGradientFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;

	public class ForTest extends MovieClip
	{
		private var commands:Vector.<int> = Vector.<int>([1,2,2,2,2]);
		private var _data:Vector.<Number> = Vector.<Number>([132, 20, 46, 254, 244, 100, 20, 98, 218, 254]);
		private var _graphicsData:Vector.<IGraphicsData>;
		private var myPath:GraphicsPath;
		public function ForTest()
		{
			stop();
			
			commands = Vector.<int>([1,2,2,2,2]); 
			_data = Vector.<Number>([132, 20, 46, 254, 244, 100, 20, 98, 218, 254]); 
			
			this.graphics.beginFill( 0xFF0000, .6 );
			this.graphics.drawPath( commands, _data );
			this.drawGraphicsData();
//			this.graphics.drawTriangles();
			this.graphics.endFill();
		}
		
		private function drawGraphicsData():void
		{
			// establish the fill properties
			var myFill:GraphicsGradientFill = new GraphicsGradientFill();
			myFill.colors = [0xEEFFEE, 0x0000FF];
			myFill.matrix = new Matrix();
			myFill.matrix.createGradientBox(100, 100, 0);
			
			// establish the stroke properties,周围线条
			var myStroke:GraphicsStroke = new GraphicsStroke(2);
			myStroke.fill = new GraphicsSolidFill(0xFFFFFF);
			
			initMyPath();
			
			// populate the IGraphicsData Vector array
			_graphicsData = new Vector.<IGraphicsData>(3, true);
			_graphicsData[0] = myFill;
			_graphicsData[1] = myStroke;
			_graphicsData[2] = myPath;
			
			// render the drawing
			graphics.drawGraphicsData(_graphicsData);	
		}
		private function initMyPath():void
		{
			// establish the path properties
			var pathCommands:Vector.<int> = new Vector.<int>(5, true);
			pathCommands[0] = GraphicsPathCommand.MOVE_TO;
			pathCommands[1] = GraphicsPathCommand.LINE_TO;
			pathCommands[2] = GraphicsPathCommand.LINE_TO;
			pathCommands[3] = GraphicsPathCommand.LINE_TO;
			pathCommands[4] = GraphicsPathCommand.LINE_TO;
			
			var pathCoordinates:Vector.<Number> = new Vector.<Number>();
			pathCoordinates.push(10,10, 10,100, 100,100, 100,10, 10,10);
			pathCoordinates.fixed = true;
			myPath = new GraphicsPath(pathCommands, pathCoordinates);
		}
	}
}