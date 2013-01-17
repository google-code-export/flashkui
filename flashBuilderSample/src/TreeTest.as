package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	
	import cn.flashk.controls.Button;
	import cn.flashk.controls.ComboBox;
	import cn.flashk.controls.Label;
	import cn.flashk.controls.ProgressBar;
	import cn.flashk.controls.Tree;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.UISet;
	import cn.flashk.ui.UI;

	[SWF(frameRate = "30" , width = "800" , height = "660" , backgroundColor = "0xFFFFFF")]
	public class TreeTest extends Sprite
	{
		private var _tree:Tree;
		private var _xml:XML;
		private var _count:int=0;
		private var _progress:ProgressBar;
		private var _label:Label;
		private var _combo:ComboBox;
		
		public function TreeTest()
		{
			this.x = this.y = 50;
			UI.init(this.stage);
			UISet.listIconSmooth = true;
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
			
			_tree = new Tree();
			_tree.isParentAutoClickOpen = true;
			_tree.setSize(300,400);
			_xml = 
				<data>
				<item label="房间" id="1">
					<item label="女" id="1">
						<item label="aaa"  id="51"/>
						<item label="aaa"  id="51"/>
						<item label="aaa"  id="51"/>
						<item label="aaa"  id="51"/>
					</item>
					<item label="男" id="1">
						<item label="bbb"  id="51"/>
						<item label="bbb"  id="51"/>
						<item label="bbb"  id="51"/>
						<item label="bbb"  id="51"/>
						<item label="bbb"  id="51"/>
						<item label="bbb"  id="51"/>
					</item>
				</item>
				<item label="我的好友" id="1">
					<item label="玩家"  id="51"/>
				</item>
				<item label="陌生人" id="1">
					<item label="玩家"  id="51"/>
				</item>
				<item label="黑名单" id="1">
					<item label="玩家"  id="51"/>
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
			
			
			_label = new Label();
			_label.x = 100;
			_label.y = 450;
			this.addChild(_label);
			
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
			_combo.selectedIndex = 1;
			
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
		
		
		protected function onBtnClickSkin(event:MouseEvent=null):void
		{
			var n:uint = uint(Math.random() * 69);
			SkinManager.changeActionSkin(n);
			_label.text = "当前样式索引: "+n;
		}
	}
}