package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.Slider;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.support.Scale9GridBitmap;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class SliderSourceSkin extends SourceSkin
	{
		private static var bd:BitmapData;
		private static var skin:DisplayObject;
		private static var bds:Array;
		private static var skinBG:DisplayObject;
		private static var bdsBG:Array;
		
		
		public var sliderNum:uint;
		
		private var sliders:Array = [];
		private var shape:Sprite;
		private var space:Shape;
		private var bp2:Scale9GridBitmap;
		private var isRun:Boolean = false;

		protected var tar:Slider;
		protected var bpBG:Scale9GridBitmap;
		private var spaceValue:Sprite;
		private var spaceMask:Shape;
		
		
		
		public function SliderSourceSkin()
		{
			shape = new Sprite();
			space = new Shape();
			bp2 = new Scale9GridBitmap();
			bpBG = new Scale9GridBitmap();
			spaceValue = SkinLoader.getSpriteFromSkinFile(SourceSkinLinkDefine.SLIDER_BACKGROUND_SPACE);
			spaceValue.mouseChildren = false;
			spaceValue.mouseEnabled = false;
			spaceMask = new Shape();
			spaceValue.mask = spaceMask;
		}
		
		public function get spaceView():DisplayObject
		{
			return spaceValue;
		}
		
		public function getSliderByIndex(index:uint):Sprite{
			return Sprite(sliders[index]);
		}
		
		public function get bar():Sprite{
			return shape;
		}
		
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			super.init(target,styleSet,Skin);
			var sli:Sprite;
			if(isRun == false){
				if(skin == null){
					skin = new Skin() as DisplayObject;
				}
				initBp(skin);
				tar = target as Slider;
				
				if(bds == null){
					bds = new Array();
					drawMovieClipToArray(skin as MovieClip,bds);
				}
				sli = new Sprite();
				sliders[0] = sli;
				sli.addChild(bp);
				
				bp.sourceBitmapData = bds[1] as BitmapData;
				tar.addChildAt(sli,0);
				tar.addChildAt(spaceValue,0);
				tar.addChildAt(spaceMask,0);
				bp.x = -int(bp.width/2);
				sli.addEventListener(MouseEvent.MOUSE_OVER,showOver);
				sli.addEventListener(MouseEvent.MOUSE_OUT,showOut);
				sli.addEventListener(MouseEvent.MOUSE_DOWN,showDown);
			}
			if(tar.thumbCount == 2){
				sli = new Sprite();
				sli.x = tar.compoWidth;
				sliders[1] = sli;
				sli.addChild(bp2);
				sli.addEventListener(MouseEvent.MOUSE_OVER,showOver2);
				sli.addEventListener(MouseEvent.MOUSE_OUT,showOut2);
				sli.addEventListener(MouseEvent.MOUSE_DOWN,showDown2);
				tar.addChildAt(space,1);
				tar.addChild(sli);
				bp2.sourceBitmapData  = bds[1] as BitmapData;
				bp2.x = -int(bp2.width/2);
				updateSliderSpace();
			}
			if(isRun == false){
				initBG();
				tar.addChildAt(shape, 0);
				shape.addChild(bpBG);
			}
			isRun = true;
		}
		
		private function initBG():void{
			var Skin:Class = SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.SLIDER_BACKGROUND);
			if(skinBG == null){
				skinBG = new Skin() as DisplayObject;
			}
			if(bdsBG == null){
				bdsBG = new Array();
				bd=new BitmapData(skinBG.width,skinBG.height,true,0);
				bd.draw(skinBG);
				bdsBG[1] = bd;
			}
			initBp2(bpBG,skinBG);
			bpBG.sourceBitmapData = bdsBG[1] as BitmapData;
		}
		
		protected function showDown(event:MouseEvent):void
		{
			bp.sourceBitmapData = bds[3] as BitmapData;
		}
		
		protected function showOut(event:MouseEvent=null):void
		{
			bp.sourceBitmapData = bds[1] as BitmapData;
		}
		protected function showOver(event:MouseEvent):void
		{
			bp.sourceBitmapData = bds[2] as BitmapData;
		}
		
		protected function showDown2(event:MouseEvent):void
		{
			bp2.sourceBitmapData = bds[3] as BitmapData;
		}
		
		protected function showOut2(event:MouseEvent=null):void
		{
			bp2.sourceBitmapData = bds[1] as BitmapData;
		}
		
		protected function showOver2(event:MouseEvent):void
		{
			bp2.sourceBitmapData = bds[2] as BitmapData;
		}
		
		override public function reDraw():void {
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -1;
			bpBG.width = width;
			bp.y = (tar.compoHeight-bp.height)/2;
			bp2.y = bp.y;
		}
		
		public function updateSliderSpace():void{
			spaceMask.graphics.clear();
			spaceMask.graphics.beginFill(0);
			if(tar.thumbCount == 2){
				spaceMask.graphics.drawRect(Sprite(sliders[0]).x,0,Sprite(sliders[1]).x-Sprite(sliders[0]).x,spaceValue.height);
			}else
			{
				var sx:Number = Sprite(sliders[0]).x+5;
				spaceMask.graphics.drawRect(-5,0,Sprite(sliders[0]).x+5,spaceValue.height);
			}
		}
	}
}