package 
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.ClickAbleAlphaBitmap;
	import cn.flashk.controls.ComboBox;
	import cn.flashk.controls.DataGrid;
	import cn.flashk.controls.HScrollBar;
	import cn.flashk.controls.Image;
	import cn.flashk.controls.LinkText;
	import cn.flashk.controls.List;
	import cn.flashk.controls.RadioButton;
	import cn.flashk.controls.Slider;
	import cn.flashk.controls.TabBar;
	import cn.flashk.controls.TextArea;
	import cn.flashk.controls.TextInput;
	import cn.flashk.controls.TileList;
	import cn.flashk.controls.ToggleButton;
	import cn.flashk.controls.ToolRadioButton;
	import cn.flashk.controls.Tree;
	import cn.flashk.controls.VScrollBar;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.StyleManager;
	import cn.flashk.controls.modeStyles.ButtonMode;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.modeStyles.LayoutStyle;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.image.BitmapDataText;
	
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author flashk
	 */
	public class Test extends Sprite 
	{
		private var bu:Button;
		private var ck:CheckBox;
		private var ra:RadioButton;
		private var to:ToggleButton;
		private var fil:CheckBox;
		private var n:uint;
		private var testBD:BitmapData
		private var til:TileList;
		
		public var left_btn:SimpleButton;
		public var right_btn:SimpleButton;
		
		private var uldr:URLLoader;
		private var tree:Tree ;
		
		private var xml:XML;
		
		private var textArea:TextArea;
		
		public function Test():void {
			SkinThemeColor.userDefaultColor(uint(Math.random() * 69));
			n = 32;
			//15
			SkinThemeColor.userDefaultColor(n);
			//StyleManager.setThemeGradientMode(uint(Math.random() * 2) + 1);
			//DefaultStyle.filters =  [new GlowFilter(0xFFFFFF, 1, 16, 16, 1.0, 1, true)];
			
			var vscr:VScrollBar = new VScrollBar();
			vscr.x = 610;
			vscr.y = 29-5;
			vscr.smoothNum = 4;
			vscr.hideArrow = true;
			vscr.setSize(10, 360);
			vscr.setTarget(a_mc, true, 500, 360);
			vscr.updateSkin();
			this.addChild(vscr);
			
			
			var vscr2:HScrollBar = new HScrollBar();
			vscr2.x = 53;
			vscr2.y = 615+20-16-30;
			//vscr2.rotation = -90;
			vscr2.smoothNum = 8;
			vscr2.setTarget(b_mc, true, 400, 360);
			vscr2.setSize(17, 400);
			vscr2.scaleX = -1;
			this.addChild(vscr2);
			
			var cb:ClickAbleAlphaBitmap = new ClickAbleAlphaBitmap();
			cb.bitmapData = new PNGset1();
			cb.x = 680;
			cb.y = 69;
			cb.ableHandCursor = true;
			var glow:GlowFilter  = new GlowFilter(0xFF3300,0.7);
			cb.overFilters = [glow];
			cb.addEventListener(MouseEvent.CLICK, showState);
			this.addChild(cb);
			
			var tb:TabBar = new TabBar();
			tb.y = 610;
			tb.x = 50;
			tb.labels = ["我的", "你得", "色板", "样式"];
			tb.icons = [IconS1,IconS2,IconS3,IconS4]
			tb.contents = [tabView1_mv, tabView2_mv, tabView3_mv, tabView4_mv];
			tb.setSize(440,24);
			this.addChild(tb);
			
			var ti:TextInput = new TextInput();
			ti.x = 50;
			ti.y = 20;
			ti.tipText = "请输入账号";
			ti.restrict = "0-9";
			this.addChild(ti);
			
			bu = new Button();
			bu.x = 50;
			bu.y = 53;
			bu.label = "确定";
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 7);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 7);
			this.addChild(bu);
			
			ck = new CheckBox();
			ck.x = 150;
			ck.y = 53;
			fil = ck;
			fil.label = "按钮使用内发光效果";
			//fil.selected = true;
			fil.addEventListener(Event.CHANGE, changeThemeSel);
			ck.setSize(130, 21);
			this.addChild(ck);
			
			
			ck = new CheckBox();
			ck.x = 150;
			ck.y = 83;
			ck.label = "主题不使用颜色均分";
			ck.addEventListener(Event.CHANGE, changeThemeSel);
			ck.setSize(130, 21);
			this.addChild(ck);
			
			ra = new RadioButton();
			ra.x = 150;
			ra.y = 113;
			this.addChild(ra);
			
			
			ra = new RadioButton();
			ra.x = 150;
			ra.y = 143;
			ra.selected = true;
			this.addChild(ra);
			
			
			ra = new RadioButton();
			ra.x = 150;
			ra.y = 173;
			ra.selected = true;
			ra.isOutSkinHide = true;
			this.addChild(ra);
			
			var tra:ToolRadioButton;
			tra = new ToolRadioButton();
			tra.x = 150;
			tra.y = 203;
			tra.icon = IconSet1;
			this.addChild(tra);
			
			tra = new ToolRadioButton();
			tra.x = 150;
			tra.y = 233;
			tra.icon = IconSet1;
			this.addChild(tra);
			
			tra = new ToolRadioButton();
			tra.x = 150;
			tra.y = 263;
			tra.icon = IconSet1;
			this.addChild(tra);
			
			tra = new ToolRadioButton();
			tra.x = 150;
			tra.y = 293;
			tra.icon = IconSet1;
			tra.mode = ButtonMode.JUST_ICON;
			tra.setSize(25,bu.compoHeight);
			tra.setStyle(ButtonStyle.ICON_OVER, IconSet2);
			tra.setStyle(ButtonStyle.ICON_DOWN, IconSet3);
			this.addChild(tra);
			
			tra = new ToolRadioButton();
			tra.x = 150;
			tra.y = 323;
			tra.icon = IconSet1;
			tra.selected = true;
			tra.mode = ButtonMode.JUST_ICON;
			tra.setSize(25,bu.compoHeight);
			tra.setStyle(ButtonStyle.ICON_OVER, IconSet2);
			tra.setStyle(ButtonStyle.ICON_DOWN, IconSet3);
			this.addChild(tra);
			
			tra = new ToolRadioButton();
			tra.x = 150;
			tra.y = 353;
			tra.icon = IconSet1;
			tra.mode = ButtonMode.JUST_ICON;
			tra.setSize(25,bu.compoHeight);
			tra.setStyle(ButtonStyle.ICON_OVER, IconSet2);
			tra.setStyle(ButtonStyle.ICON_DOWN, IconSet3);
			this.addChild(tra);
			
			
			bu = new Button();
			bu.x = 50;
			bu.y = 83;
			bu.icon = IconSet1;
			this.addChild(bu);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 3.5);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 3.5);
			
			
			bu = new Button();
			bu.x = 50;
			bu.y = 113;
			bu.icon = IconSet1;
			bu.mode = ButtonMode.JUST_ICON;
			bu.setSize(25, bu.compoHeight);
			bu.setStyle(ButtonStyle.ICON_OVER, IconSet2);
			bu.setStyle(ButtonStyle.ICON_DOWN, IconSet3);
			this.addChild(bu);
			
			
			bu = new Button();
			bu.x = 90;
			bu.y = 113;
			bu.icon = IconSet1;
			bu.mode = ButtonMode.JUST_ICON;
			bu.isOutSkinHide = true;
			bu.setSize(25,bu.compoHeight);
			this.addChild(bu);
			
			
			bu = new Button();
			bu.x = 50;
			bu.y = 143;
			bu.label = "确定";
			bu.setStyle(ButtonStyle.TEXT_COLOR, "#009000");
			bu.setStyle(ButtonStyle.TEXT_OVER_COLOR, "#fdfa00");
			this.addChild(bu);
			
			
			bu = new Button();
			bu.x = 50;
			bu.y = 173;
			bu.label = "更改主题";
			bu.setStyle(ButtonStyle.TEXT_COLOR, "#333333");
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 10);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 10);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH, 10);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT, 10);
			bu.addEventListener(MouseEvent.CLICK, changeTheme);
			this.addChild(bu);
			
			bu = new Button();
			bu.x = 50;
			bu.y = 203;
			bu.label = "确定";
			//bu.setStyle(ButtonStyle.TEXT_COLOR, "#FFFFFF");
			bu.setSize(50,bu.compoHeight);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 10);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 10);
			bu.enabled = false;
			this.addChild(bu);
			
			
			bu = new Button();
			bu.x = 50;
			bu.y = 233;
			bu.label =" "
			this.addChild(bu);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 4.5);
			bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 4.5);
			
			
			to = new ToggleButton();
			to.x = 50;
			to.y = 263;
			to.label ="可选按钮"
			this.addChild(to);
			to.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 3.5);
			to.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 3.5);
			
			var sl:Slider = new Slider();
			sl.x = 639;
			sl.y =650;
			sl.showTick(10);
			this.addChild(sl);
			
			
			sl= new Slider();
			sl.x = 639.5;
			sl.y =620;
			sl.snapInterval = 1;
			sl.setMotion(1,1);
			this.addChild(sl);
			
			sl= new Slider();
			sl.x = 639;
			sl.y =680;
			sl.setSliderMode(2);
			sl.showTick(10);
			this.addChild(sl);
			
			sl= new Slider();
			sl.x = 639.5;
			sl.y =710;
			sl.minSpaceNum = 30;
			sl.snapInterval = 1;
			sl.thumbCount = 2;
			sl.setMotion(1);
			sl.setStyle("sliderUnableColor","#000000");
			this.addChild(sl);
			
			var list:List = new List();
			list.x = 1100;
			list.y = 50;
			var item:Object;
			item = new Object();
			item.label ="测试";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			item.icon = IconS1;
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			list.addItemAt(item,0);
			item = new Object();
			item.label ="测试3";
			list.addItemAt(item,2);
			this.addChild(list);
			
			//
			var dg:DataGrid = new DataGrid();
			dg.x = 1000;
			dg.y = 400;
			dg.columnWidths = [-30,-30,-40];
			dg.labels = ["标题","时间","大小"];
			dg.dataField = ["label","label2","title"];
			dg.sortByNumberTypes = [ false,true,false];
			item = new Object();
			item.label ="a-------";
			item.label2 ="OK";
			item.title ="my god";
			dg.addItemAt(item,0);
			item = new Object();
			item.label ="b";
			item.label2 ="OK";
			item.title ="my god";
			dg.addItemAt(item,0);
			item = new Object();
			item.label ="B";
			item.label2 ="OK";
			item.title ="my god";
			dg.addItemAt(item,0);
			item = new Object();
			item.label ="c";
			item.label2 ="OK";
			item.title ="my god";
			dg.addItemAt(item,0);
			item = new Object();
			item.label ="d";
			item.label2 ="OK";
			item.title ="my god";
			dg.addItemAt(item,0);
			item = new Object();
			item.label ="e";
			item.label2 ="OK";
			item.title ="my god";
			dg.addItemAt(item,0);
			for(var i:int=0;i<20;i++){
				item = new Object();
				item.label ="测试";
				item.label2 =i;
				item.title ="my god";
				dg.addItemAt(item,0);
			}
			item = new Object();
			item.label ="f+++";
			item.label2 ="OK+++";
			item.title ="my god";
			dg.addItemAt(item,2);
			dg.allowMultipleSelection = true;
			this.addChild(dg);
			
			var cbo:ComboBox = new ComboBox();
			cbo.x= 1420;
			cbo.y =50;
			cbo.selectedIndex = 3;
			item = new Object();
			item.label ="测试";
			item.icon = IconS1;
			cbo.addItem(item);
			item = new Object();
			item.label ="测试1";
			item.icon = IconS2;
			cbo.addItemAt(item,0);
			item = new Object();
			item.label ="测试2";
			item.icon = IconS3;
			cbo.addItemAt(item,0);
			item = new Object();
			item.label ="测试3";
			item.icon = IconS2;
			cbo.addItemAt(item,0);
			item = new Object();
			item.label ="测试4";
			item.icon = IconS2;
			cbo.addItemAt(item,0);
			item = new Object();
			item.label ="测试5";
			item.icon = IconS4;
			cbo.addItemAt(item,0);
			item = new Object();
			item.label ="测试6";
			item.icon = IconS2;
			cbo.addItemAt(item,0);
			item = new Object();
			item.label ="测试7";
			item.icon = IconS2;
			cbo.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.icon = IconS2;
			cbo.addItemAt(item,0);
			
			this.addChild(cbo);
			
			var lt:LinkText = new LinkText();
			lt.x = 1420;
			lt.y = 250;
			lt.label ="访问Google";
			lt.setSize(80,20);
			lt.linkURL = "http://www.google.com";
			lt.setStyle("textColor","#FF3300");
			this.addChild(lt);
			


			
			var image:Image = new Image();
			this.addChild(image);
			image.x = 1650;
			image.y = 300;
			//image.setStyle(LayoutStyle.PADDING,3);
			image.zoomInContent = false;
			image.scaleContent = false;
			image.source = "s16.jpg";
			
			image = new Image();
			this.addChild(image);
			image.x = 1650;
			image.y = 430;
			//image.setStyle(LayoutStyle.PADDING,3);
			image.scaleContent = true;
			image.smoothing = true;
			image.source = "s16.jpg";
			//image.source = new testIcon();
			//image.backgroundAlpha = 0.1;
			//image.source = testIcon;
			//image.clip = true;
			til = new TileList();
			this.addChild(til);
			til.x = 1800;
			til.y = 50;
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			item = new Object();
			item.label ="测试8";
			item.source = IconS2;
			til.addItemAt(item,0);
			
			
			tree = new Tree();
			this.addChild(tree);
			tree.x = 1800;
			tree.y = 360;
			
			uldr = new URLLoader();
			uldr.addEventListener(Event.COMPLETE,initTree);
			uldr.load(new URLRequest("tree.xml"));
			
			right_btn.addEventListener(MouseEvent.CLICK,moveMe);
			left_btn.addEventListener(MouseEvent.CLICK,moveMe);
			moveMe({currentTarget:left_btn});
			this.stage.align="TL";
			
			var bd:BitmapData = new BitmapData(icon_mc.width,icon_mc.height,true,0x00FFFFFF);
			bd.draw(icon_mc);
			BitmapDataText.encodeBitmapDataToText(bd);
			
			bu = new Button();
			bu.x = 1670;
			bu.y = 553;
			bu.label = "全部展开";
			bu.addEventListener(MouseEvent.CLICK,testTree);
			this.addChild(bu);
			
			bu = new Button();
			bu.x = 1670;
			bu.y = 583;
			bu.label = "全部关闭";
			bu.addEventListener(MouseEvent.CLICK,testTree2);
			this.addChild(bu);
			
			textArea = new TextArea();
			this.addChild(textArea);
			textArea.x = 1800;
			textArea.y = 600;
			
			var uldr2:URLLoader = new URLLoader(new URLRequest("test.txt"));
			uldr2.addEventListener(Event.COMPLETE,initText);
		}
		private function initText(event:Event):void{
			textArea.text = URLLoader(event.currentTarget).data;
		}
		private function initTree(event:Event):void{
			xml = new XML(uldr.data);
			//tree.dataProvider = xml;
			tree.dataProvider = xml;
		}
		private function testTree(event:MouseEvent):void{
			//tree.expandChildrenOf(xml[0].children()[1],true);
			tree.expandChildrenOf(null,true);
		}
		private function testTree2(event:MouseEvent):void{
			//tree.expandChildrenOf(xml[0].children()[1],true);
			tree.expandChildrenOf(null,false);
		}
		protected function moveMe(event:Object):void
		{
			if(event.currentTarget == left_btn){
				this.x -= this.stage.stageWidth;
				left_btn.x += this.stage.stageWidth;
				right_btn.x += this.stage.stageWidth;
			}else{
				this.x += this.stage.stageWidth;
				left_btn.x -= this.stage.stageWidth;
				right_btn.x -= this.stage.stageWidth;
				
			}
			
			//this.removeChild(til);
		}
		private function changeTheme(event:MouseEvent):void {
			n = uint(Math.random() * 69);
			SkinThemeColor.userDefaultColor(n);
			trace("changeTheme", n);
			if (fil.selected == true){
				DefaultStyle.filters =  [new GlowFilter(0xFFFFFF, 1, 16, 16, 1.0, 1, true)];
			}else {
				DefaultStyle.filters =  [];
			}
			if (ck.selected == true){
				StyleManager.setThemeGradientMode(uint(Math.random() * 2) + 1);
				StyleManager.setThemeGradientMode(2);
			}else{
				StyleManager.setThemeGradientMode(1);
			}
			SkinManager.updateAllComponentsSkin();
		}
		private function changeThemeSel(event:Event):void {
			SkinThemeColor.userDefaultColor(n);
			trace("changeTheme", n);
			if (fil.selected == true){
				DefaultStyle.filters =  [new GlowFilter(0xFFFFFF, 1, 16, 16, 1.0, 1, true)];
			}else {
				DefaultStyle.filters =  [];
			}
			if (ck.selected == true){
				StyleManager.setThemeGradientMode(uint(Math.random() * 2) + 1);
				StyleManager.setThemeGradientMode(2);
			}else{
				StyleManager.setThemeGradientMode(1);
			}
			SkinManager.updateAllComponentsSkin();
		}
		private function showState(event:Event):void {
			if (ClickAbleAlphaBitmap(event.currentTarget).isMouseOnNoAlphaPixel == true) {
				a_txt.text = "在不透明区域";
			}else {
				a_txt.text = "在透明区域";
			}
		}
	}
	
}