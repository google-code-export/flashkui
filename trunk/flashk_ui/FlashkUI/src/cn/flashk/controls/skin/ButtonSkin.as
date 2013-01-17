package cn.flashk.controls.skin 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	
	import cn.flashk.controls.Button;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.managers.SkinThemeColor;

	/**
	 * ...
	 * @author flashk
	 */
	public class ButtonSkin extends ActionDrawSkin
	{
		private var tar:Button;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function ButtonSkin() 
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as Button;
			target.addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
		}
		
		public function get skinDisplayObject():DisplayObject {
			return shape;
		}
		
		override public function hideOutState():void {
			super.hideOutState();
			shape.alpha = 0;
			mot.setOutViewHide(true);
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			SkinThemeColor.initFillStyle(shape.graphics,width,height);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			var bw:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH];
			var bh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT];
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
			shape.filters = DefaultStyle.filters;
		}
		
	}
}