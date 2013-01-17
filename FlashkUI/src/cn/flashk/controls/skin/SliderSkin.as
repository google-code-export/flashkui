package cn.flashk.controls.skin
{
	import cn.flashk.controls.Slider;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.support.ColorConversion;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	public class SliderSkin extends ActionDrawSkin
	{
		public var sliderNum:uint;
		
		private var shape:Sprite;
		private var styleSet:Object;
		private var tar:Slider;
		private var mot:MotionSkinControl;
		private var mot2:MotionSkinControl;
		private var sliders:Array = [];
		private var space:Shape;
		
		public function SliderSkin()
		{	
			shape = new Sprite();
			space = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			var sli:Sprite;
			this.styleSet = styleSet;
			styleSet["sliderUnableColor"] = "#FFFFFF";
			tar = target as Slider;
			if(sliders[0] == null){
				target.addChildAt(shape, 0);
				sli = new Sprite();
				sli.y = 2;
				sliders[0] = sli;
				mot = new MotionSkinControl(sli, sli);
				sli.addEventListener(Event.ADDED_TO_STAGE,initView);
				target.addChildAt(sli, 1);
				target.addChildAt(space,1);
			}
			if(tar.thumbCount == 2){
				sli = new Sprite();
				sli.y = 2;
				sli.x = tar.compoWidth;
				sliders[1] = sli;
				mot2 = new MotionSkinControl(sli, sli);
				target.addChildAt(sli, 2);
				target.addChildAt(space,1);
			}
		}
		
		protected function initView(event:Event):void
		{
			event.currentTarget.removeEventListener(Event.ADDED_TO_STAGE,initView);
			if(tar.thumbCount == 1)
			{
				try{
					updateSliderSpace();
				}catch(e:Error){
					
				}
			}
		}
		
		public function getSliderByIndex(index:uint):Sprite{
			return Sprite(sliders[index]);
		}
		
		public function get bar():Sprite{
			return shape;
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -1;
			shape.graphics.beginFill(0,0);
			shape.graphics.drawRect(-5,-4,width+9,height+8);
			SkinThemeColor.initFillStyle(shape.graphics,width,height);
			var ew:Number = 30;
			var eh:Number = 30;
			var bw:Number = 30;
			var bh:Number = 30;
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0-5+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width+9, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
			drawSliver(Sprite(sliders[0]));
			if(tar.thumbCount == 2){
				drawSliver(Sprite(sliders[1]));
			}
		}
		
		public function drawSliver(sp:Sprite):void{
			sp.graphics.clear();
			var width:Number = 4.5;
			var height:Number = height;
			sp.graphics.beginFill(0,0);
			sp.graphics.drawCircle(0,0,width+3);
			sp.graphics.endFill();
			SkinThemeColor.initFillStyle(sp.graphics,width,width,45);
			sp.graphics.drawCircle(0,0,width);
		}
		
		public function get spaceView():DisplayObject
		{
			return space;
		}
		
		public function updateSliderSpace():void{
			space.graphics.clear();
			if(tar.thumbCount == 2){
				space.graphics.beginFill(ColorConversion.transformWebColor(styleSet["sliderUnableColor"]),1-DefaultStyle.sliderNoAlpha);
				var xs:Array = tar.values;
				space.graphics.drawRect(-5,0,Sprite(sliders[0]).x+5,tar.compoHeight);
				space.graphics.drawRect(Sprite(sliders[1]).x,0,tar.compoWidth-Sprite(sliders[1]).x+5,tar.compoHeight);
			}else
			{
				space.graphics.beginFill(ColorConversion.transformWebColor(styleSet["sliderUnableColor"]),1-DefaultStyle.sliderNoAlpha);
				 space.x = 0;
				 var sx:Number = Sprite(sliders[0]).x+5;
				space.graphics.drawRect(sx,0,tar.compoWidth-sx+5,tar.compoHeight);
			}
		}
		
	}
}