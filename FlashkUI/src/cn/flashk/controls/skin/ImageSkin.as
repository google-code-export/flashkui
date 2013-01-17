package cn.flashk.controls.skin
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	
	import cn.flashk.controls.Image;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.managers.SkinThemeColor;

	public class ImageSkin extends ActionDrawSkin
	{
		private var tar:Image;
		private var shape:Shape;
		private var mot:MotionSkinControl;
		private var styleSet:Object;
		
		public function ImageSkin()
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void
		{
			this.styleSet = styleSet;
			tar = target as Image;
			target.addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
			mot.resetAlpha = false;
		}
		
		public function get skinDisplayObject():DisplayObject {
			return shape;
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			SkinThemeColor.initImageFillStyle(shape.graphics,width,height);
			var ew:Number = DefaultStyle.ellipse;
			var eh:Number = DefaultStyle.ellipse;
			var bw:Number = DefaultStyle.ellipse;
			var bh:Number = DefaultStyle.ellipse;
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
		}
		
	}
}