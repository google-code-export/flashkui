package
{
	import flash.display.Shape;
	
	import cn.flashk.controls.managers.UISet;
	import cn.flashk.controls.support.TreeItemRender;

	public class MyTreeRender extends TreeItemRender
	{
		private var sh:Shape;
		public function MyTreeRender()
		{
			super();
			this.graphics.beginFill(0xAAAAAA);
			this.graphics.drawRect(230,7,8,8);
		}
		override public function set data(value:Object):void
		{
			_isNeedSetText = false;
			super.data = value;
			txt.text = ":::  "+value.@label;
			txt.width = txt.textWidth + 5;
		}
		override public function get itemHeight():Number
		{
			return 24;
		}
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			super.setSize(newWidth,newHeight);
		}
	}
}