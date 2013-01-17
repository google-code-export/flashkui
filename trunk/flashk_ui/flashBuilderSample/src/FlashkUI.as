package
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import cn.flashk.controls.Alert;
	import cn.flashk.controls.Button;
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.ComboBox;
	import cn.flashk.controls.Label;
	import cn.flashk.controls.List;
	import cn.flashk.controls.NumericStepper;
	import cn.flashk.controls.ProgressBar;
	import cn.flashk.controls.RadioButton;
	import cn.flashk.controls.Slider;
	import cn.flashk.controls.TabBar;
	import cn.flashk.controls.TextInput;
	import cn.flashk.controls.TileList;
	import cn.flashk.controls.Tree;
	import cn.flashk.controls.data.ListItem;
	import cn.flashk.controls.events.ListEvent;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.proxy.CustomListItem;
	import cn.flashk.ui.UI;
	
	[SWF(frameRate = "30" , width = "1000" , height = "500" , backgroundColor = "0xffffff")]
	public class FlashkUI extends Sprite
	{
		private var _tileList:TileList;
		private var _list:List;
		private var _treeData:XML;
		private var _count:int=0;
		private var _colorCount:int=-1;
		private var _color2Count:int=-1;
		private var _tabs:TabBar;
		private var _tab1SP:Sprite;
		private var _tab2SP:Sprite;
		private var _tab3SP:Sprite;
		private var _tab4SP:Sprite;
		private var _coIn1:TextInput;
		private var _rad1:TextInput;
		private var _alp1:TextInput;
		private var _ang1:NumericStepper;
		private var _checkAuto:CheckBox;
		private var _colors2:ComboBox;
		private var _bu:Button;
		private var _tree:Tree;
		private var _xml:XML;
		private var _label:Label;
		private var _label2:Label;
		private var _combo:ComboBox;
		private var _bd:BitmapData;
		private var _pro1:ProgressBar;
		private var _pro2:ProgressBar;
		private var _pro3:ProgressBar;
		private var _pro4:ProgressBar;
		private var _pro5:ProgressBar;
		private var _pro6:ProgressBar;
		private var _fpsCombo:ComboBox;
		private var _pcount:int = 0;
		
		private function initSetSkin():void
		{
			_coIn1 = new TextInput();
			_coIn1.setSize(210,_coIn1.compoHeight);
			_coIn1.setXY(0,30);
			_tab2SP.addChild(_coIn1);
			_checkAuto = new CheckBox();
			_checkAuto.label = "使用新主题自动替换当前样式设定值";
			_checkAuto.selected = true;
			_tab2SP.addChild(_checkAuto);
			_checkAuto.setXY(530,0);
			
			_rad1 = new TextInput();
			_rad1.setSize(150,_rad1.compoHeight);
			_rad1.setXY(0,60);
			_tab2SP.addChild(_rad1);
			
			_alp1 = new TextInput();
			_alp1.setSize(210,_alp1.compoHeight);
			_alp1.setXY(0,90);
			_tab2SP.addChild(_alp1);
			
			_ang1 = new NumericStepper();
			_ang1.setXY(0,120);
			_ang1.minimum = -360;
			_tab2SP.addChild(_ang1);
			
			UI.creatButton("修改皮肤",_tab2SP,onModifeClick,400,380);
			
			_colors2 = new ComboBox();
			_colors2.setSize(110,_colors2.compoHeight);
			var i:int;
			var item:ListItem;
			for(i=-1;i<80;i++)
			{
				item = new ListItem();
				if(i==-1)
				{
					item.label = "选择一个主题";
					item.value = -1;
					
				}else
				{
					item.label = "主题"+i;
					item.value = i;
					if(i==79) item.value = 80;
				}
				_colors2.addItem(item);
			}
			_colors2.setXY(10,60);
			_colors2.rowCount = 15;
			_colors2.addEventListener(Event.CHANGE,changeColor2);
			this.addChild(_colors2);
			
			UI.creatButton("下一个主题",this,onNextClick,10,20,110,23);
			
			_fpsCombo = new ComboBox();
			item = new ListItem();
			item.label = "30FPS";
			item.value= 30;
			_fpsCombo.addItem(item);
			item = new ListItem();
			item.label = "45FPS";
			item.value= 45;
			_fpsCombo.addItem(item);
			item = new ListItem();
			item.label = "60FPS";
			item.value= 60;
			_fpsCombo.addItem(item);
			_fpsCombo.setXY(10,100);
			_fpsCombo.setSize(110,_fpsCombo.compoHeight);
			this.addChild(_fpsCombo);
			_fpsCombo.addEventListener(Event.CHANGE,onFPSChange);
			
			_pro1 = new ProgressBar();
			_pro2 = new ProgressBar();
			_pro2.y = 50;
			_pro2.showText = "请稍候。。。";
			_pro3 = new ProgressBar();
			_pro3.toFixNum = 0;
			_pro3.y = 100;
			_pro3.showText = "*% 图片下载中。。。";
			_pro4 = new ProgressBar();
			_pro4.y = 150;
			_pro4.setStyle("ellipse",0);
			_pro5 = new ProgressBar();
			_pro5.y =200;
			_pro5.toFixNum = 2;
			_pro5.setStyle("ellipse",0);
			_pro5.setStyle("motionAngle",90);
			_pro5.setStyle("motionWidth",6);
			_pro5.setStyle("motionSpace",3);
			
			_pro6 = new ProgressBar();
			_pro6.y = 250;
			_pro6.showText = "正在处理音频数据";
			_pro6.setStyle("motionAngle",-30);
			_tab3SP.addChild(_pro1);
			_tab3SP.addChild(_pro2);
			_tab3SP.addChild(_pro3);
			_tab3SP.addChild(_pro4);
			_tab3SP.addChild(_pro5);
			_tab3SP.addChild(_pro6);
			this.addEventListener(Event.ENTER_FRAME,updateProgress);
		}
		
		private function onNextClick(event:Event):void
		{
			if(_colors2.selectedIndex<_colors2.dropdown.length-1)
			{
				_colors2.selectedIndex = _colors2.selectedIndex+1;
			}else
			{
				_colors2.selectedIndex = 0;
			}
			changeColor2(event);
		}
		
		protected function onFPSChange(event:Event):void
		{
			this.stage.frameRate = _fpsCombo.selectedItem.value;
		}
		
		
		protected function updateProgress(event:Event):void
		{
			_pcount++;
			_pro1.value = _pcount/1000;
			_pro3.value = _pcount/1000;
			_pro4.value = _pcount/1000;
			_pro5.value = _pcount/1000;
			if(_pcount >1050)
			{
				_pcount = 0;
			}
		}
		
		protected function changeColor2(event:Event):void
		{
			if(_colors2.selectedItem.value == -1) return;
			SkinManager.changeActionSkin(_colors2.selectedItem.value);
			updteSet();
		}
		
		private function getColorArrs(str:String):Array
		{
			var arr:Array;
			arr = _coIn1.text.split(",");
			var i:int;
			for(i=0;i<arr.length;i++)
			{
				arr[i] = uint("0x"+String(arr[i]).slice(1));
			}
			return arr;
			
		}
		
		private function getNumberArr(str:String):Array
		{
			var arr:Array;
			arr = str.split(",");
			var i:int;
			for(i=0;i<arr.length;i++)
			{
				arr[i] = Number(arr[i]);
			}
			return arr;
		}
		
		private function onModifeClick(event:MouseEvent):void
		{
			SkinThemeColor.fillColors = getColorArrs(_coIn1.text);
			SkinThemeColor.fillRatios = getNumberArr(_rad1.text);
			SkinThemeColor.fillAlphas = getNumberArr(_alp1.text);
			SkinThemeColor.fillAngle = _ang1.value;
			var a:Class = SkinThemeColor;
			SkinManager.updateAllComponentsSkin();
		}
		
		private function updteSet():void
		{
			if(_checkAuto.selected==true)
			{
				var i:int;
				var str:String;
				str = "";
				for(i=0;i<SkinThemeColor.fillColors.length;i++)
				{
					str += ",#"+uint(SkinThemeColor.fillColors[i]).toString(16);
				}
				str = str.toUpperCase();
				_coIn1.text = str.slice(1);
				_rad1.text = SkinThemeColor.fillRatios.join(",");
				_alp1.text = SkinThemeColor.fillAlphas.join(",");
				_ang1.value = SkinThemeColor.fillAngle;
			}
		}
		
		public function FlashkUI()
		{
			var t:int;
			_tab1SP = new Sprite();
			_tab2SP = new Sprite();
			_tab3SP = new Sprite();
			_tab4SP = new Sprite();
			UI.init(this.stage);
//			UISet.isScrollBarHideArrow = true;
//			UI.autoBuild();
		
			_bd = new BitmapData(14,14,true,0x00FFFFFF);
			_bd.setPixel32(5,5,0xFF000000);
			_bd.setPixel32(7,7,0xFF000000);
			_bd.setPixel32(5,7,0xFF000000);
			_bd.setPixel32(5,9,0xFF000000);
			_bd.setPixel32(12,5,0xFFFF6600);
			_bd.setPixel32(12,7,0xFF00FF00);
			_bd.setPixel32(10,7,0xFF0000FF);
			_bd.setPixel32(12,9,0xFF000000);
			
			this.x = this.y = 5;
			SkinThemeColor.userDefaultColor(32);
			
			_tabs =new TabBar();
			_tabs.setSize(845,450);
			_tabs.x = 130;
			this.addChild(_tabs);
			_tabs.addTab("按钮",_tab1SP);
			_tabs.addTab("DIY风格",_tab2SP);
			_tabs.addTab("进度条",_tab3SP);
			_tabs.addTab("树",_tab4SP);
			_tab1SP.x = _tab1SP.y=15;
			_tab2SP.x = _tab2SP.y=15;
			_tab3SP.x = _tab3SP.y=15;
			
			_bu = new Button();
			_bu.x = 550;
			_bu.y = 23;
			_bu.label = "确定";
			_bu.enabled = false;
			_tab1SP.addChild(_bu);
			
			_bu = new Button();
			_bu.x = 550;
			_bu.y = 53;
			_bu.label = "确定";
			_bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 7);
			_bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 7);
			_tab1SP.addChild(_bu);
			
			_bu = new Button();
			_bu.x = 550;
			_bu.y = 83;
			_bu.icon = _bd;
			_tab1SP.addChild(_bu);
			_bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 3.5);
			_bu.setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 3.5);
			
			var radion:RadioButton;
			radion = new RadioButton();
			radion.label = "选项1";
			radion.setXY(230,60);
			_tab1SP.addChild(radion);
			radion = new RadioButton();
			radion.label = "选项2";
			radion.setXY(230,85);
			_tab1SP.addChild(radion);
			
			var checkBox:CheckBox;
			checkBox = new CheckBox();
			checkBox.label = "勾选1";
			checkBox.setXY(230,120);
			_tab1SP.addChild(checkBox);
			checkBox = new CheckBox();
			checkBox.label = "勾选2";
			checkBox.setXY(230,145);
			_tab1SP.addChild(checkBox);
			
			var slider:Slider = new Slider();
			slider.y = 40;
			slider.snapInterval = 1;
			slider.minSpaceNum = 5;
			slider.thumbCount = 2;
			_tab1SP.addChild(slider);
			slider = new Slider();
			slider.y = 5;
			slider.snapInterval = 10;
			slider.minSpaceNum = 10;
			_tab1SP.addChild(slider);
			slider = new Slider();
			slider.y = 95;
			slider.snapInterval = 1;
			slider.minSpaceNum = 5;
			_tab1SP.addChild(slider);
			
			var combo:ComboBox = new ComboBox();
			var item:CustomListItem;
			for(var i:int=1;i<10;i++)
			{
				item = new CustomListItem();
				item.label = "数据"+i;;
				combo.addItem(item);
			}
			combo.y = 60;
			_tab1SP.addChild(combo);
			
			_tileList = new TileList();
			_tileList.setSize(600,228);
			for(i=1;i<51;i++)
			{
				item = new CustomListItem()
				item.label ="文件"+i;
				item.source = _bd;
				_tileList.addItem(item)
			}
			_list= new List();
			_list.snapNum = 2;
			_list.x = 620;
			_list.setSize(150,228);
			t = getTimer();
			for(i=1;i<101;i++)
			{
				item= new CustomListItem()
				item.label ="内容"+i;
				item.icon = _bd;
				_list.addItem(item)
			}
			trace(getTimer()-t);
			_tileList.y = _list.y = 180;
			_tab1SP.addChild(_tileList);
			_tab1SP.addChild(_list);
		
			var nums:NumericStepper = new NumericStepper();
//			nums.divisor = 10;
//			nums.maximum =500;
			nums.minimum = -100;
			nums.y = 110;
			_tab1SP.addChild(nums);
			
			var deleteNum2:NumericStepper = new NumericStepper();
			deleteNum2.value = -95;
			deleteNum2.minimum = -100;
			deleteNum2.setXY(0,450);
			this.addChild(deleteNum2);
			
			
			nums= new NumericStepper();
			nums.y = 140;
			nums.value = 15;
			nums.enabled = false;
			_tab1SP.addChild(nums);
		
			UI.creatButton("List1000",_tab1SP,listTest,650,150);
			
			initSetSkin();

			_tree = new Tree();
			_tree.itemDoubleClickEnabled = true;
			_tree.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,onDoubleClick);
			_tree.addEventListener(ListEvent.ITEM_CLICK,onItemClick);
			_tree.itemRender = MyTreeRender;
			//			_tree.itemRender = BaseTreeItemRender;
			_tree.isParentAutoClickOpen = true;
			_tree.setSize(300,400);
			_xml = 
				<data>
				<item label="房间" id="1">
					<item label="女" id="1">
						<item label="aaa1"  id="51"/>
						<item label="aaa2"  id="51"/>
						<item label="aaa3"  id="51"/>
						<item label="aaa4"  id="51"/>
					</item>
					<item label="男" id="1">
						<item label="bbb1"  id="51"/>
						<item label="bbb2"  id="51"/>
						<item label="bbb3"  id="51"/>
						<item label="bbb4"  id="51"/>
						<item label="bbb5"  id="51"/>
						<item label="bbb6"  id="51"/>
					</item>
				</item>
				<item label="我的好友" id="1">
					<item label="玩家a"  id="51"/>
				</item>
				<item label="陌生人" id="1">
					<item label="玩家b"  id="51"/>
				</item>
				<item label="黑名单" id="1">
					<item label="玩家c"  id="51"/>
				</item>
				</data>
				
			_tab4SP.addChild(_tree);
			_tree.dataProvider = _xml;
			var btn:Button;
			btn = new Button();
			btn.label = "成批插入";
			btn.x = 350;
			btn.addEventListener(MouseEvent.CLICK,onBtnClickF);
			_tab4SP.addChild(btn);
		
			UI.creatButton("全部展开",_tab4SP,openAll,350,30);
			UI.creatButton("全部收起",_tab4SP,closeAll,350,60);
			UI.creatButton("碎片插入",_tab4SP,onBtnClick3,350,90);
			UI.creatButton("删除单个",_tab4SP,onBtnClickDel,350,120);
			
			_label2 = new Label();
			_label2.x = 400;
			_label2.y = 400;
			_tab4SP.addChild(_label2);
		
			_combo = new ComboBox();
			_combo.addItem({label:1,value:1});
			_combo.addItem({label:10,value:10});
			_combo.addItem({label:50,value:50});
			_combo.addItem({label:100,value:100});
			_combo.addItem({label:300,value:300});
			_combo.addItem({label:500,value:500});
			_combo.addItem({label:1000,value:1000});
			_tab4SP.addChild(_combo);
			_combo.x = 500;
			_combo.selectedIndex = 2;
		}
		
		protected function onDoubleClick(event:ListEvent):void
		{
			Alert.show("用户双击项目："+ event.targetItem.data.@label);
		}
		
		protected function onItemClick(event:ListEvent):void
		{
			_label2.text = "用户单击项目："+ event.targetItem.data.@label;
		}
		
		private function onBtnClickDel(event:MouseEvent):void
		{
			var t:int = getTimer();
			_tree.removeOneItem(_xml.item[0].item[0].item[0]);
			delete _xml.item[0].item[0].item[0];
			if(_xml.item[0].item[0].children().length()==0)
			{
				trace("update************");
				_tree.updateWholeTreeNow();
			}
			trace("--",getTimer()-t);
		}
		
		private function openAll(event:MouseEvent):void
		{
			var t:int = getTimer();
			_tree.expandChildrenOf(null,true);
			trace("zk:",getTimer()-t);
		}
		
		private function closeAll(event:MouseEvent):void
		{
			_tree.expandChildrenOf(null,false);
		}
		
		protected function onBtnClickF(event:MouseEvent):void
		{
			if(_xml.item[0].item[0].children().length()==0)
			{
				var needUpdate:Boolean = true;
			}
			for(var i:int=1;i<_combo.selectedItem.value+1;i++)
			{
				_count++;
				var node:XML =
					<item label="玩家"  id="0"/>
				node.@label = "玩家"+_count;
				_tree.addItemChildIn(node,_xml.item[0].item[0],false);
			}
		}
		
		protected function onBtnClick3(event:MouseEvent):void
		{
			for(var i:int=1;i<_combo.selectedItem.value+1;i++)
			{
				_count++;
				var node:XML =
					<item label="玩家"  id="51"/>
				
				node.@label = "玩家"+_count;
				
				_tree.addItemChildIn(node,_xml.item[0].item[0]);
			}
		}
		
		private function changeWin8(event:MouseEvent):void
		{
			SkinManager.changeActionSkin(80);
			updteSet();
		}
		
		private function listTest(event:MouseEvent):void
		{
			var i:int = 0;
			var item:CustomListItem;
			_list.removeAll();
			for(i=1;i<1001;i++)
			{
				_count ++;
				item= new CustomListItem()
				item.label ="内容"+_count;
				_list.addItem(item)
			}
		}
		
		protected function onBtnClick(event:MouseEvent):void
		{
			_colorCount++;
			_colorCount = _colorCount%71;
			SkinManager.changeActionSkin(_colorCount);
			updteSet();
		}
	
		protected function onBtnClick2(event:MouseEvent):void
		{
			_color2Count++;
			_color2Count = _color2Count%71;
			SkinManager.changeActionSkin(_color2Count+100);
			updteSet();
		}
	}
}