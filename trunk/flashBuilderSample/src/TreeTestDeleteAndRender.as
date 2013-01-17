package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	
	import cn.flashk.controls.Alert;
	import cn.flashk.controls.Button;
	import cn.flashk.controls.ComboBox;
	import cn.flashk.controls.Label;
	import cn.flashk.controls.ProgressBar;
	import cn.flashk.controls.Tree;
	import cn.flashk.controls.VScrollBar;
	import cn.flashk.controls.events.ListEvent;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.UISet;
	import cn.flashk.controls.support.BaseTreeItemRender;
	import cn.flashk.ui.UI;
	

	[SWF(frameRate = "30" , width = "800" , height = "500" , backgroundColor = "0xFFFFFF")]
	public class TreeTestDeleteAndRender extends Sprite
	{
		private var _tree:Tree;
		private var _xml:XML;
		private var _count:int=0;
		private var _progress:ProgressBar;
		private var _label:Label;
		private var _label2:Label;
		private var _combo:ComboBox;
		private var _colorCount:int=-1;
		private var _color2Count:int=-1;
		
		public function TreeTestDeleteAndRender()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.x = 50;
			this.y =5;
			UI.init(this.stage);
			UISet.listIconSmooth = false;
			DefaultStyle.font = "SimSun,Arial,Verdana";
			DefaultStyle.fontExcursion = 2;
			
//			SkinLoader.eventDispatcher.addEventListener(SkinLoader.SKIN_LOADED,start)
//			SkinLoader.loadSkinFile("skin.swf");
			SkinManager.changeActionSkin(9);
			start();
		}
		private function start(event:Event=null):void
		{
			
			
			var btn:Button = new Button();
			btn.label = "更换样式";
			btn.y = 450;
			this.addChild(btn);
			btn.addEventListener(MouseEvent.CLICK,onBtnClickSkin);
			
			
			btn = new Button();
			btn.label = "更换平面样式";
			btn.setXY(90,450);
//			this.addChild(btn);
			btn.addEventListener(MouseEvent.CLICK,onBtnClick2);
			
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
				
			this.addChild(_tree);
			_tree.dataProvider = _xml;
			
			btn = new Button();
			btn.label = "成批插入";
			btn.x = 350;
			btn.addEventListener(MouseEvent.CLICK,onBtnClick);
			this.addChild(btn);
			
			UI.creatButton("全部展开",this,openAll,350,30);
			UI.creatButton("全部收起",this,closeAll,350,60);
			UI.creatButton("碎片插入",this,onBtnClick3,350,90);
			UI.creatButton("删除单个",this,onBtnClickDel,350,120);
			
			
			
			_label = new Label();
			_label.x = 200;
			_label.y = 450;
			this.addChild(_label);
			
			
			_label2 = new Label();
			_label2.x = 400;
			_label2.y = 450;
			this.addChild(_label2);
			
			_combo = new ComboBox();
			_combo.addItem({label:1,value:1});
			_combo.addItem({label:10,value:10});
			_combo.addItem({label:50,value:50});
			_combo.addItem({label:100,value:100});
			_combo.addItem({label:300,value:300});
			_combo.addItem({label:500,value:500});
			_combo.addItem({label:1000,value:1000});
			_combo.addItem({label:1500,value:1500});
			_combo.addItem({label:2000,value:2000});
			this.addChild(_combo);
			_combo.x = 500;
			_combo.selectedIndex = 7;
			
			VScrollBar.isDargDisableStageMouseChildren = true;
			
			
			return;
			
			_progress = new ProgressBar();
			this.addChild(_progress);
			_progress.y = 500;
			_progress.x = 20;
//			_progress.value = 0.01;
//			_progress.showText = "请稍后";
//			_progress.indeterminate = true;
			
			var ldr:URLLoader = new URLLoader();
			_progress.source = ldr;
			_progress.textColor = 0xFF0000;
//			_progress.targetLoader(ldr);
			ldr.load(new URLRequest("http://img2.niutuku.com/desk/1208/2127/ntk-2127-46012.jpg"));
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
//			_tree.updateAfterOperateXML();
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
		
		protected function onBtnClick(event:MouseEvent):void
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
			if(needUpdate)
			{
//				_tree.updateAfterOperateXML();
			}
			
		}
		
		protected function onBtnClick3(event:MouseEvent):void
		{
			var t:int = getTimer();
			for(var i:int=1;i<_combo.selectedItem.value+1;i++)
			{
				_count++;
				var node:XML =
					<item label="玩家"  id="51"/>
				
				node.@label = "玩家"+_count;
				
				_tree.addItemChildIn(node,_xml.item[0].item[0]);
			}
			trace("***",getTimer()-t);
		}
		
		
		protected function onBtnClickSkin(event:MouseEvent=null):void
		{
			
			_colorCount++;
			_colorCount = _colorCount%71;
			SkinManager.changeActionSkin(_colorCount);
			_label.text = "当前样式索引: "+_colorCount;
		}
		
		
		protected function onBtnClick2(event:MouseEvent):void
		{
			_color2Count++;
			_color2Count = _color2Count%71;
			SkinManager.changeActionSkin(_color2Count+100);
			_label.text = "当前样式索引: "+_color2Count;
		}
	}
}