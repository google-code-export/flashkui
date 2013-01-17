package cn.flashk.controls.skin
{
	import cn.flashk.controls.TextArea;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.ColorConversion;
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import cn.flashk.controls.managers.SkinThemeColor;
	
	public class TextAreaSkin extends ActionDrawSkin
	{
		private var tar:TextArea;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function TextAreaSkin()
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as TextArea;
			target.addChildAt(shape, 0);
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			shape.graphics.lineStyle(1,SkinThemeColor.border,styleSet["borderAlpha"],true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			shape.graphics.beginFill(ColorConversion.transformWebColor(styleSet["backgroundColor"]),styleSet["backgroundAlpha"]);
			var ew:Number = styleSet["ellipse"];
			var eh:Number = styleSet["ellipse"];
			var bw:Number = styleSet["ellipse"];
			var bh:Number = styleSet["ellipse"];
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0, 0, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
			shape.filters = DefaultStyle.filters;
		}
		
	}
}