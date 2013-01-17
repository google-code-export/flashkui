package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import cn.flashk.controls.ComboBox;
	import cn.flashk.controls.data.ListItem;
	import cn.flashk.ui.UI;
	
	[SWF(frameRate = "30" , width = "810" , height = "510" , backgroundColor = "0xffffff")]
	public class AutoBuildSample extends Sprite
	{
		private var _ldr:Loader;
		
		public function AutoBuildSample()
		{
			_ldr = new Loader();
			_ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,build);
			_ldr.load(new URLRequest("UINameSample.swf"));
			this.addChild(_ldr);
		}
		
		protected function build(event:Event):void
		{
			//自动构建
			UI.autoBuild(_ldr.content as Sprite);
			
			var cb:ComboBox = Sprite(Sprite(Sprite(_ldr.content).getChildByName("all_sp")).getChildByName("content_sp")).getChildByName("e_comboBox") as ComboBox;
			for(var i:int=1;i<10;i++)
			{
				var item:ListItem = new ListItem();
				item.label = "数据"+i;
				cb.addItem(item);
			}
		}
	}
}