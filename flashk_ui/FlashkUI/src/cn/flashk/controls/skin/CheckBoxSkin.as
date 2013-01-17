package cn.flashk.controls.skin 
{
	import flash.display.CapsStyle;
	import flash.display.DisplayObjectContainer;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.support.ColorConversion;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.managers.SkinThemeColor;

	/**
	 * ...
	 * @author flashk
	 */
	public class CheckBoxSkin extends ToggleDrawSkin
	{
		
		private var tar:CheckBox;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function CheckBoxSkin() 
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as CheckBox;
			DisplayObjectContainer(target).addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
			reDraw();
		}
		
		override public function updateToggleView(isSelect:Boolean):void {
			super.updateToggleView(isSelect);
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = 14;
			var height:Number = 14;
			SkinThemeColor.initFillStyle(shape.graphics,width,height);
			shape.graphics.lineStyle(1, SkinThemeColor.border,0.5,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 1+DefaultStyle.graphicsDrawOffset, 3+DefaultStyle.graphicsDrawOffset, width, height, ew, eh, ew, eh, ew, eh, ew,eh,ew,eh);
			if (tar.selected == true) {
				shape.graphics.lineStyle(1.5, ColorConversion.transformWebColor(DefaultStyle.checkBoxLineColor), 1);
				shape.graphics.moveTo(3+1, 9+1);
				shape.graphics.lineTo(7+1, 13+1);
				shape.graphics.lineTo(13+1, 4+1);
				shape.graphics.lineTo(7+1, 13+1);
				shape.graphics.moveTo(2+1, 8+1);
			}
			shape.filters = DefaultStyle.filters;
			shape.cacheAsBitmap = true;
		}
		
	}
}