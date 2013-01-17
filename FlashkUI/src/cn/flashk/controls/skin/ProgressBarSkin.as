package cn.flashk.controls.skin
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.events.Event;
	
	import cn.flashk.controls.ProgressBar;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.support.ColorConversion;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	
	public class ProgressBarSkin  extends ActionDrawSkin
	{
		private var tar:UIComponent;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var shapeBar:Shape;
		private var styleSet:Object;
		private var progressBar:ProgressBar;
		private var motion:Shape;
		private var mask:Shape;
		private var mask2:Shape;
		private var d:Number;
		
		public function ProgressBarSkin()
		{
			shape = new Shape();
			shapeBar = new Shape();
			motion = new Shape();
			mask = new Shape();
			mask2 = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as UIComponent;
			progressBar = target as  ProgressBar;
			target.addChildAt(shape, 0);
			target.addChildAt(motion,1);
			target.addChildAt(shapeBar,2);
			target.addChildAt(mask,3);
			target.addChildAt(mask2,4);
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
			mask.graphics.clear();
			mask.graphics.beginFill(0);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(mask.graphics, 0, 0, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			motion.graphics.clear();
			var b:Number = styleSet["motionWidth"] ;
			var a:Number = styleSet["motionSpace"] ;
			var c:Number = styleSet["motionAngle"] ;
			motion.alpha = progressBar.motionAlpha;
			motion.graphics.beginFill(SkinThemeColor.border,progressBar.motionAlpha);
			d = progressBar.compoHeight/Math.tan(c* Math.PI/180);
			var e:Number = 0;
			if(c==90 || c== -90) 
			{
				e = (b+a)*2;
			}
			for(var mx:Number = 0;mx<progressBar.compoWidth+Math.abs(d)*2+e;mx+=(a+b))
			{
				motion.graphics.moveTo(mx,progressBar.compoHeight);
				motion.graphics.lineTo(mx+b,progressBar.compoHeight);
				motion.graphics.lineTo(mx+b+d,1);
				motion.graphics.lineTo(mx+d,1);
				motion.graphics.lineTo(mx,progressBar.compoHeight);
			}
			motion.mask = mask;
			motion.addEventListener(Event.ENTER_FRAME,moveMotion);
		}
		
		public function updateValue():void
		{
			if(progressBar.value/progressBar.maximum >= 1)
			{
				motion.removeEventListener(Event.ENTER_FRAME,moveMotion);
			}else
			{
				motion.addEventListener(Event.ENTER_FRAME,moveMotion);
			}
			var ew:Number = styleSet["ellipse"];
			var eh:Number = styleSet["ellipse"];
			var bw:Number = styleSet["ellipse"];
			var bh:Number = styleSet["ellipse"];
			var width:Number = tar.compoWidth;
			var height:Number = tar.compoHeight;
			var barWidht:Number = tar.compoWidth * progressBar.value/progressBar.maximum;
			if(barWidht<ew*2)
			{
				mask2.graphics.clear();
				mask2.graphics.beginFill(0);
				RoundRectAdvancedDraw.drawAdvancedRoundRect(mask2.graphics, 0, 0, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
				mask2.visible = true;
				shapeBar.mask = mask2;
			}else
			{
				shapeBar.mask = null;
				mask2.visible = false;
			}
			shapeBar.graphics.clear();
			if(progressBar.value >0)
			{
				width = barWidht;
				height = tar.compoHeight;
				SkinThemeColor.initFillStyle(shapeBar.graphics,width,height);
				RoundRectAdvancedDraw.drawAdvancedRoundRect(shapeBar.graphics, 0+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
				shapeBar.cacheAsBitmap = true;
			}
		}
		
		protected function moveMotion(event:Event):void
		{
			motion.x -= progressBar.motionSpeed;
			if(motion.x < -styleSet["motionWidth"]-styleSet["motionSpace"]-d)
			{
				motion.x = 0-d;
			}
		}
		
	}
}