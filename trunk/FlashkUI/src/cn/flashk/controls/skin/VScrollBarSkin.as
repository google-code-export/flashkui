package cn.flashk.controls.skin 
{
	import flash.display.Sprite;
	
	import cn.flashk.controls.VScrollBar;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;

	/**
	 * ...
	 * @author flashk
	 */
	public class VScrollBarSkin extends ActionDrawSkin
	{
		public var arrowUp:Sprite;
		public var arrowDown:Sprite;
		public var bar:Sprite;
		public var scroller:Sprite;
		
		private var tar:VScrollBar;
		private var mot:MotionSkinControl;
		private var styleSet:Object;
		
		public function VScrollBarSkin() 
		{
			arrowUp = new Sprite();
			arrowDown = new Sprite();
			bar = new Sprite();
			bar.alpha = 0.5;
			bar.x = 1;
			scroller = new Sprite();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as VScrollBar;
			target.addChildAt(scroller, 0);
			target.addChildAt(arrowUp, 0);
			target.addChildAt(arrowDown, 0);
			target.addChildAt(bar, 0);
			mot = new MotionSkinControl(arrowUp, arrowUp);
			new MotionSkinControl(arrowDown, arrowDown);
			var smo:MotionSkinControl = new MotionSkinControl(scroller, scroller);
			smo.showDown = false;
			smo.filtersDown = [];
		}
		
		override public function reDraw():void {
			arrowUp.graphics.clear();
			var width:Number;
			var height:Number;
			var ratios:Array;
			var ew:Number = DefaultStyle.scrollBarRound;
			var eh:Number = DefaultStyle.scrollBarRound;
			width= tar.compoWidth - 3;
			height= width;
			arrowUp.graphics.beginFill(0, 0);
			arrowUp.graphics.drawRect(0, 0, width+2, height + 2);
			SkinThemeColor.initScrollerFillStyle(arrowUp.graphics,width,height);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(arrowUp.graphics, 1+DefaultStyle.graphicsDrawOffset, 1+DefaultStyle.graphicsDrawOffset, width+1, height, ew, eh, ew, eh, ew, eh, ew, eh, ew, eh);
			arrowUp.graphics.beginFill(SkinThemeColor.arrowFillColor, 1);
			arrowUp.graphics.lineStyle(0.1, SkinThemeColor.border,0);
			arrowUp.graphics.moveTo(int(width / 2)+2.5, 4+2);
			arrowUp.graphics.lineTo(int(width / 2)+6.5, 8+2);
			arrowUp.graphics.lineTo(int(width / 2)-1.5, 8+2);
			arrowUp.graphics.endFill();
			arrowDown.graphics.clear();
			width= tar.compoWidth - 3;
			height= width;
			arrowDown.scaleY = -1;
			arrowDown.y = int(tar.compoHeight - tar.compoWidth+height+2);
			arrowDown.graphics.beginFill(0, 0);
			arrowDown.graphics.drawRect(0, 0, width+2, height + 2);
			SkinThemeColor.initScrollerFillStyle(arrowDown.graphics,width,height);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(arrowDown.graphics, 1+DefaultStyle.graphicsDrawOffset, -1+DefaultStyle.graphicsDrawOffset, width+1, height+1, ew, eh, ew, eh, ew, eh, ew, eh, ew, eh);
			arrowDown.graphics.beginFill(SkinThemeColor.arrowFillColor, 1);
			arrowDown.graphics.lineStyle(0.1, SkinThemeColor.border,0);
			arrowDown.graphics.moveTo(int(width / 2)+2.5, 4+1);
			arrowDown.graphics.lineTo(int(width / 2)+6.5, 8+1);
			arrowDown.graphics.lineTo(int(width / 2)-1.5, 8+1);
			arrowDown.graphics.endFill();
			bar.graphics.clear();
			height= tar.compoHeight;
			SkinThemeColor.initBarFillStyle(bar.graphics,width,height);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(bar.graphics, 0, 0, tar.compoWidth-1, height-1, ew, eh, ew, eh, ew, eh, ew, eh, ew, eh);
			bar.cacheAsBitmap = true;
			updateScrollder();
			
			arrowUp.filters = DefaultStyle.scrollbarFilter;
			arrowDown.filters = DefaultStyle.scrollbarFilter;
		}
		
		public function updateScrollder():void {
			if(scroller.y == 0 && arrowUp.visible == true){
				scroller.y = tar.compoWidth;
			}
			scroller.graphics.clear();
			var width:Number;
			var height:Number;
			var ratios:Array;
			var ew:Number = DefaultStyle.scrollBarRound;
			var eh:Number = DefaultStyle.scrollBarRound;
			width = tar.compoWidth - 3;
			var lessNum:Number;
			if (arrowUp.visible  == true) {
				lessNum =  tar.compoWidth;
			}else {
				lessNum = 0;
			}
			height =int( (tar.compoHeight - lessNum * 2) / (1+tar.maxScrollPosition / tar.clipSize));
			if (height < 30) {
				height = 30;
			}
			if(isNaN(tar.maxScrollPosition) || tar.maxScrollPosition <0){
				scroller.visible = false;
				return;
			}else{
				scroller.visible = true;
			}
			scroller.graphics.beginFill(0, 0);
			scroller.graphics.drawRect(0, 0, width+2, height + 2);
			SkinThemeColor.initScrollerFillStyle(scroller.graphics,width+1,height+2);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(scroller.graphics, 1+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width+1, height+2, ew, eh, ew, eh, ew, eh, ew, eh, ew, eh);
			scroller.graphics.beginFill(SkinThemeColor.scrollBarShapeColor1, SkinThemeColor.scrollBarShapeAlpha1);
			scroller.graphics.lineStyle(0, SkinThemeColor.border,0);
			scroller.graphics.drawRect(3 + 2, int(height / 2) - 2, width - 7, 2);
			scroller.graphics.drawRect(3 + 2, int(height / 2) - 2+3, width - 7, 2);
			scroller.graphics.drawRect(3 + 2, int(height / 2) - 2+6, width - 7, 2);
			scroller.graphics.beginFill(SkinThemeColor.scrollBarShapeColor2, SkinThemeColor.scrollBarShapeAlpha2);
			scroller.graphics.drawRect(3 + 2, int(height / 2) - 0, width - 7, 1);
			scroller.graphics.drawRect(3 + 2, int(height / 2) +3, width - 7, 1);
			scroller.graphics.drawRect(3 + 2, int(height / 2) +6, width - 7, 1);
			
			scroller.filters = DefaultStyle.scrollbarFilter;
		}
		
	}
}