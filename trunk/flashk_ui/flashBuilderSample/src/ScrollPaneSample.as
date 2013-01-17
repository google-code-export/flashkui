package
{
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	import cn.flashk.controls.ScrollPane;
	import cn.flashk.ui.UI;

	public class ScrollPaneSample extends Sprite
	{
		public function ScrollPaneSample()
		{
			UI.init(this.stage);
			this.stage.frameRate = 60;
			var spa:ScrollPane = new ScrollPane();
			spa.load(new URLRequest("test.jpg"));
			this.addChild(spa);
			spa.x = spa.y = 10;
			spa.vscrollBar.arrowClickStep = 100;
			spa.hscrollBar..arrowClickStep = 100;
			spa.vscrollBar.arrowFrameMoveSpeed  = 8;
			spa.hscrollBar.arrowFrameMoveSpeed  = 8;
		}
	}
}