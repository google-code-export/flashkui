package cn.flashk.controls.skin 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	
	import cn.flashk.controls.Panel;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.managers.SkinThemeColor;

	/**
	 * ...
	 * @author flashk
	 */
	public class TitleSkin extends ActionDrawSkin
	{
		private var tar:Panel;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function TitleSkin() 
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as Panel;
			target.addChild(shape);
		}
		
		public function get skinDisplayObject():DisplayObject {
			return shape;
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.titleHeight;
			SkinThemeColor.initFillStyle(shape.graphics,width,height);
			shape.graphics.lineStyle(1, SkinThemeColor.border,0);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			var bw:Number = 0;
			var bh:Number = 0;
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0, 1, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
			shape.filters = DefaultStyle.filters;
		}
		
	}
}