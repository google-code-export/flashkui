package cn.flashk.controls.skin
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	
	import cn.flashk.controls.ToolTip;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.managers.SkinThemeColor;
	
	public class ToolTipSkin extends ActionDrawSkin
	{
		private var tar:ToolTip;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function ToolTipSkin() 
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as ToolTip;
			target.addChildAt(shape, 0);
		}
		
		public function get skinDisplayObject():DisplayObject {
			return shape;
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			SkinThemeColor.initFillStyle(shape.graphics,width,height);
			var ew:Number = styleSet["ellipse"];
			var eh:Number = styleSet["ellipse"];
			var bw:Number = styleSet["ellipse"];
			var bh:Number = styleSet["ellipse"];
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0+DefaultStyle.graphicsDrawOffset, 0.5+DefaultStyle.graphicsDrawOffset, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
		}
		
	}
}