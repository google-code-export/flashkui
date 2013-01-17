package cn.flashk.controls.skin 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	
	import cn.flashk.controls.RadioButton;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.support.ColorConversion;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.managers.SkinThemeColor;

	/**
	 * ...
	 * @author flashk
	 */
	public class RadioButtonSkin extends ToggleDrawSkin
	{
		private var tar:RadioButton;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function RadioButtonSkin() 
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as RadioButton;
			DisplayObjectContainer(target).addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
			shape.x = 0.5;
			shape.y = 2;
			reDraw();
		}
		
		override public function updateToggleView(isSelect:Boolean):void {
			super.updateToggleView(isSelect);
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = 15;
			var height:Number = 15;
			SkinThemeColor.initFillStyle(shape.graphics,width,height);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			shape.graphics.drawCircle(8, 7, 7);
			if (tar.selected == true) {
				shape.graphics.beginFill(ColorConversion.transformWebColor(DefaultStyle.checkBoxLineColor), 1);
				shape.graphics.lineStyle(1, SkinThemeColor.border,0);
				shape.graphics.drawCircle(8, 7, 3);
			}
			shape.filters = DefaultStyle.filters;
			shape.cacheAsBitmap = true;
		}
		
	}
}