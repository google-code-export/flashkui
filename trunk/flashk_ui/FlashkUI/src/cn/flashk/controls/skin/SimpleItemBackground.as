package cn.flashk.controls.skin
{
	import flash.display.Shape;
	import cn.flashk.controls.managers.SkinThemeColor;

	public class SimpleItemBackground extends Shape
	{
		private var _width:Number;
		private var _height:Number;
		
		public function SimpleItemBackground()
		{
		}
		
		public function setSize(newWidth:Number,newHeight:Number):void{
			_width = newWidth;
			_height = newHeight;
			this.graphics.clear();
			this.graphics.beginFill(SkinThemeColor.border,0.7);
			this.graphics.drawRect(0,0,_width,_height);
		}
		
	}
}