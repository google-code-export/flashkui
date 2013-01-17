package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.ProgressBar;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class ProgressBarSourceSkin  extends SourceSkin
	{
		private static var bd:BitmapData;
		private static var skin:DisplayObject;
		private var progressBar:ProgressBar;
		private var _ui:MovieClip;
		private var tar:UIComponent;
		
		public function ProgressBarSourceSkin()
		{
			super();
		}
		
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			tar = target;
			progressBar = target as  ProgressBar;
			_ui = new Skin() as MovieClip;
			progressBar.addChildAt(_ui,0);
		}
		
		public function updateValue():void {
			var frame:uint = progressBar.value/progressBar.maximum*100;
			if(frame<1)
			{
				frame = 1;
			}
			if(frame >100)
			{
				frame = 100;
			}
			if(_ui.currentFrame != frame)
			{
				_ui.gotoAndStop(frame);
			}
			try
			{
				TextField(_ui.getChildByName("info_txt")).text = progressBar.showText;
			} 
			catch(error:Error) 
			{
				
			}
			try
			{
				TextField(_ui.getChildByName("per_txt")).text = Number(progressBar.value/progressBar.maximum*100).toFixed(progressBar.toFixNum)+"%";
			} 
			catch(error:Error) 
			{
				
			}
		}
		
	}
}