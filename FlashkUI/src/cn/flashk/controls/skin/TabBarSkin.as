package cn.flashk.controls.skin 
{
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	import cn.flashk.controls.TabBar;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;

	/**
	 * ...
	 * @author flashk
	 */
	public class TabBarSkin extends ActionDrawSkin
	{
		private var tar:TabBar
		private var mot:MotionSkinControl;
		private var shape:Shape
		private var styleSet:Object;
		
		public function TabBarSkin() 
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as TabBar;
			target.addChildAt(shape, 0);
			shape.x = 0.5;
			shape.y = 19.5;
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var colors:Array = SkinThemeColor.fillColors;
			var alphas:Array = [0.9, 1.0, 1.0, 1.0];
			var ratios:Array;
			shape.graphics.beginFill(0,0);
			shape.graphics.lineStyle(0,SkinThemeColor.border,0.5);
			shape.graphics.drawRect(0,0,tar.compoWidth,tar.compoHeight);
			var width:Number = tar.compoWidth - 0.35;
			var height:Number = 3;
			shape.graphics.lineStyle(1,0,0);
			shape.graphics.beginFill(SkinThemeColor.fillColors[SkinThemeColor.fillColors.length-1]);
			var ew:Number = 0;
			var eh:Number = 0;
			var bw:Number = 0;
			var bh:Number = 0;
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0, 0.5, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.transform.colorTransform = new ColorTransform(1,1,1,1,40,40,40,0);
			shape.cacheAsBitmap = true;
		}
		
	}
}