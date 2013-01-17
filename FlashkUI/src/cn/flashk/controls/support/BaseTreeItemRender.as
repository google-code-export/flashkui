package cn.flashk.controls.support
{
	import cn.flashk.controls.List;
	import cn.flashk.controls.Tree;
	import cn.flashk.controls.events.TreeEvent;
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * 树单行渲染器的基类 。 如果自定义渲染器需要从 BaseTreeItemRender 以使用节点和管理展开功能
	 * @author flashk
	 * 
	 */
	public class BaseTreeItemRender extends ListItemRender
	{
		public static var maxCharEqus:uint = 35;
		public static var closeRefs:Array =[] ;
		
		private static var iconFolderStr:String = "";
		private static var iconItemStr:String;
		private static var icon3Str:String;
		private static var icon4Str:String;
		private static var closer:Object;
		
		public var closeBy:Object;
		public var closeIndex:int;
		public var level:int = 0;
		public var idStr:String;
		public var needCreatNew:Boolean;
		public var parentRender:BaseTreeItemRender;
		
		protected var tree:Tree;
		protected var xml:XML;
		protected var opens:Array=[];
		protected var isOpen:Boolean = false;
		protected var myCloseRefs:Array;
		protected var isRecord:Boolean = false;
		protected var myAllCose:Array;
		protected var myIndex:int;
		protected var levelSpace:Number = 18;
		protected var openSprite:Sprite;
		protected var openBp:Bitmap;
		
		public override function destory():void
		{
			super.destory();
			tree = null;
			opens = null;
			openBp = null;
			openSprite = null;
		}
		
		public function BaseTreeItemRender()
		{
			super();
			if(iconFolderStr == "")
			{
				//图标PNG数据
				//iconFolderStr = "15,11,0,0xe2a447xe2a447xe2a447xe2a447,zzz0xcf8838xyxyxyxyxcf8838,zz0,0xe29d47xsf0a4xsf0a4xse598xf9df8fxf5d281xedc17bxe29d47xe29d47xe29d47xe29d47xe29d47,0,0,0xdc9e44xsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxdc9e44,0,0,0xdc9744xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xc07b37,0,0,0xd49945xse9abxse9abxse9abxse9abxcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xce8d3fxse19exse19exse19excd8d43xse9a4xse9a4xse9a4xse9a4xse9a4xse9a4xse9a4xse9a4xf9df8fxcd8d43xc88839xse197xse197xcd8d43xse197xse197xse197xse197xse197xse197xse197xse197xf9df8fxcd8d43,0xc17c35xsdb8axcd8d43xsdb91xsdb91xsdb91xsdb91xsdb91xsdb91xsdb91xsdb91xf9df8fxcd8d43,0,0xb37132xcd8d43xsdb8axsdb8axsdb8axsdb8axsdb8axsdb8axsdb8axsdb8axf9df8fxcd8d43,z0xbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823e,z0,";
				iconFolderStr = "15,11,0,0xe2a447xe2a447xe2a447xe2a447,zzz0xcf8838xyxyxyxyxcf8838,zz0,0xe29d47xsf0a4xsf0a4xse598xf9df8fxf5d281xedc17bxe29d47xe29d47xe29d47xe29d47xe29d47,0,0,0xdc9e44xsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxdc9e44,0,0,0xdc9744xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xc07b37,0,0,0xd49945xse9abxse9abxe4b773xcd8e44xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43,7cc98a40,0xce8d3fxse19exebbf7axdba75exseba6xseca7xse9a4xse9a4xse9a4xse9a4xseaa6xsefa7xedc97a,aac9883f,2rrrxc88839xf5d086xdaa258xf7d68bxse89exse096xse197xse197xse197xse197xse79cxf5d889,d2cf964b,2dc17d39,0xc27d36xe1ac5fxecbe75xse79dxsda90xsdb91xsdb91xsdb91xsdb91xsde94xfade90,ecd9a85d,65c07e35,0,0xbc7b38xe0aa5exse796xsda89xsdb8axsdb8axsdb8axsdb8axsdc8bxfdde8d,fbe5be72,a4c17c35,z1cb67637xbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823e,e5be813d,z0,";			
				iconItemStr="12,15xb0b0b0xb1b1b1xb0b0b0xaeaeaexadadadxb0b0b0,f7b1b1b1,9dd4d4d4,1cededed,0,0,0xb3b3b3xe3e3e3xe3e3e3xdfdfdfxd3d3d3xc2c2c2xb4b4b4xb7b7b7,ebcacaca,3df7f7f7,0,0xb3b3b3xe5e5e5xe5e5e5xe4e4e4xe1e1e1xd5d5d5xc3c3c3xabababxf6f6f6,f1c4c4c4,31f5f5f5,0xb3b3b3xe7e7e7xe7e7e7xe7e7e7xe6e6e6xe3e3e3xd6d6d6xaeaeaexyxf6f6f6,dcc5c5c5,accccccxb5b5b5xebebebxeaeaeaxeaeaeaxe9e9e9xe8e8e8xd9d9d9xb7b7b7x949494x8e8e8ex999999,88ccccccxb7b7b7xeeeeeexeeeeeexedededxedededxecececxeaeaeaxd5d5d5xbdbdbdxaaaaaaxa0a0a0,f7a1a1a1xb7b7b7xeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexecececxd8d8d8xcbcbcbxc7c7c7xaaaaaaxb7b7b7xeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexedededxe9e9e9xdbdbdbxaeaeaexb7b7b7xeeefefxeeefefxeeefefxeeefefxeeefefxeeefefxefefefxefefefxefefefxe9e9e9xb3b3b3xb7b7b7xf0efefxf0efefxf0efefxf0efefxf0efefxf0efefxf2f2f2xf2f2f2xf2f2f2xefefefxb5b5b5xb7b7b7xf0f0f0xf0f0f0xf1f1f1xf2f2f2xf4f4f4xf5f5f5xf5f5f5xf5f5f5xf5f5f5xf4f4f4xb8b8b8xb7b7b7xf1f1f1xf1f1f1xf2f2f2xf4f4f4xf6f6f6xf7f7f7xf7f7f7xf7f7f7xf7f7f7xf5f5f5xb8b8b8xb7b7b7xf2f2f2xf2f2f2xf4f4f4xf6f6f6xf8f8f8xfafafaxfafafaxfafafaxfafafaxf9f9f9xbababaxb7b7b7xf3f4f4xf5f4f4xf5f6f6xf7f7f7xf8f8f8xf9f9f9xfafafaxfbfafbxfbfbfbxfbfbfbxbababa,dfc1c1c1x9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fxaaaaaa,";
				//icon3Str ="6,10,15555555,z0,0,8c646464,3060606z0,0,93656565,a5646464,47616161,z93656565,f1ebebeb,ccb3b3b3,61646464,3rrr,0,93656565,f6efefefxfcfcfc,cdb4b4b4,78646464,9555555,93656565,f6efefefxy,dbcdcdcd,9f636363,28606060,93656565,f6efefef,d4c0c0c0,93656565,1e5d5d5d,0,93656565,cfb7b7b7,84646464,115a5a5a,0,0,93656565,70646464,7494949,z47616161,z0,0,";
				icon3Str = "5,9,342c2c2c,z0,7d272727,8c232323,25rr0z8c232323xy,8c232323,25rrr,0,8c232323xyxy,8c232323,25rrr,8c232323xyxyxy,8c232323,8c232323xyxy,8c232323,25rrr,8c232323xy,8c232323,25rrr,0,7d272727,8c232323,25rr0z342c2c2c,z0,";
				icon4Str ="7,7,zzcrr0zzdrrr,6crr0z0,0,1crrr,d9rrrxrr0z0,1frrr,dfrrrx323232xrr0z22rrr,e2rrrx333333x626262xrrr,0,12rrr,e2rrrx353535x626262x626262xrrr,15rrr,73rrrxrrrxrrrxrrrxrrr,81rrr,";
			}
		}
		
		public override function set index(value:int):void
		{
			super.index = value;
			myIndex = value;
		}
		
		override public function set data(value:Object):void{
			_data = value;
			xml = value as XML;
			if(tree.floderIcon == null)
			{
				if(SkinManager.isUseDefaultSkin == false){
					tree.floderIcon = SkinLoader.getBitmapData(SourceSkinLinkDefine.TREE_FLODER_ICON);
					tree.nodeIcon = SkinLoader.getBitmapData(SourceSkinLinkDefine.TREE_NODE_ICON);
					tree.closedIcon = SkinLoader.getBitmapData(SourceSkinLinkDefine.TREE_CLOSED_ICON);
					tree.openedIcon = SkinLoader.getBitmapData(SourceSkinLinkDefine.TREE_OPENED_ICON);
				}
				if(tree.floderIcon == null){
					tree.floderIcon = BitmapDataText.decodeTextToBitmapData(iconFolderStr);
					tree.nodeIcon = BitmapDataText.decodeTextToBitmapData(iconItemStr);
					tree.closedIcon = BitmapDataText.decodeTextToBitmapData(icon3Str);
					tree.openedIcon = BitmapDataText.decodeTextToBitmapData(icon4Str);
				}
			}
		}
		
		override public function set list(value:List):void{
			super.list = value;
			tree = Tree(value);
			tree.allRender.push(this);
		}
		
		public override  function showSelect(event:MouseEvent=null):void
		{
			super.showSelect(event);
		}
		
		public function get opened():Boolean
		{
			return isOpen;
		}
		
		public function removeOneItem(node:XML):void
		{
			var a:Object = node;
			var len:int = opens.length;
			for(var i:int=0;i<len;i++)
			{
				if(opens[i].data == node)
				{
					if(opens[i].parent)
					{
						opens[i].parent.removeChild(opens[i]);
					}
					opens.splice(i,1);
					break;
				}
			}
			if(opens.length == 0)
			{
				needCreatNew = true;
			}
			if(isOpen == false)
			{
				len = myCloseRefs.length;
				var delIndexValue:int = int.MAX_VALUE;
				for(i = 0;i<myCloseRefs.length;i++)
				{
					if(myCloseRefs[i].ref.data == node)
					{
						delIndexValue = myCloseRefs[i].index;
						if(myCloseRefs[i].ref.parent)
						{
							myCloseRefs[i].ref.parent.removeChild(myCloseRefs[i].ref);
						}
						myCloseRefs.splice(i,1);
						break;
					}
				}
				len = myCloseRefs.length;
				for(i = 0;i<len;i++)
				{
					if(myCloseRefs[i].index >= delIndexValue)
					{
						myCloseRefs[i].index--;
					}
				}
			}
			if(isOpen == true && this.parent == null)
			{
				this.parentRender.removeOneItem(node);
			}
			tree.alignItems();
		}
		
		public function checkOpenNode(node:Object,childNodes:Object = null):void
		{
			if(_data == node){
				if(isOpen == false){
					openNode(null,childNodes);
				}
			}else{
				if(tree.isFindMode) 
				{
					if( xml.toXMLString().slice(0,maxCharEqus) == node.toXMLString().slice(0,maxCharEqus)){
						if(isOpen == false && xml.children().length() > 0){
							openNode(null,childNodes);
						}
					}
				}
				var len:int = opens.length;
				for(var i:int=0;i<len;i++){
					Object(opens[i]).checkOpenNode(node,childNodes);
				}
			}
		}
		
		public function checkCloseNode(node:Object):void{
			if(_data == node){
				if(isOpen == true){
					openNode();
				}
			}
		}
		
		public function expandChildrenOf(node:Object=null, isOpenNode:Boolean=true):void{
			if(_data == node || node == null){
				if(isOpenNode == true){
					if(xml.children().length() > 0 && isOpen == false){
						isOpen = false;
						openNode();
						if(node != null){
							for(var i:int=0;i<opens.length;i++){
								Object(opens[i]).expandChildrenOf(null,isOpenNode);
							}
						}
					}
				}else{
					if(xml.children().length() > 0  && isOpen == true){
						isOpen = true;
						openNode();
					}
				}
			}
		}
		
		public function addItemChildBefore(item:XML,beforeNode:XML):void
		{
			xml.insertChildBefore(beforeNode,item);
			creatOne(beforeNode.childIndex()-1);
		}
		
		public function addItemChildAfter(item:XML,afterNode:XML):void
		{
			xml.insertChildAfter(afterNode,item);
			creatOne(afterNode.childIndex()+1);
		}
		
		public function addItemChildIn(item:XML):void
		{
			var isNeedChange:Boolean;
			if(xml.children().length()==0)
			{
				isNeedChange = true;
			}
			xml.appendChild(item);
			if(isNeedChange)
			{
				data = xml;
			}
			creatOne(xml.children().length()-1);
		}
		
		protected function creatOne(indexAt:int):void
		{
			var xmlChildren:Object;
			var item:IListItemRender;
			var i:int = indexAt;
			var classRef:Class = tree.itemRender;
			var isHasPar:Boolean = false;
			if(this.parent != null)
			{
				myIndex= this.parent.getChildIndex(this);
				isHasPar = true;
			}
			xmlChildren = xml.children();
			var data:Object = xmlChildren[i];
			var key:String = this.idStr+":"+i+"_"+data.@label;
			item = tree.findInRenderCatch(key);
			var isIn:Boolean = true;
			if(item == null  || data.children().length() > 0 )
			{
				isIn = false;
				item = new classRef();
				item.list = List(this._list);
				Object(item).level = this.level+1;
				item.data =data ;
				tree.addedIndex = myIndex+i+1;
				Object(item).parentRender = this;
			}
			Object(item).idStr = this.idStr+":_"+this.level;
			if(isIn==false && data.toString() == "")
			{
				tree.pushRenderInCatch(item,key);
			}
			if(isHasPar == true && isOpen == true)
			{
				Tree(_list).addItemRenderAt(item,myIndex+i+1);
			}else
			{
				if(isOpen == false)
				{
					if(myCloseRefs && myCloseRefs.length>0)
					{
						var val:int = i+1;
						for(var j:int=0;j<myCloseRefs.length;j++)
						{
							if(myCloseRefs[j].index >= val)
							{
								myCloseRefs[j].index += 1;
							}
						}
						myCloseRefs.push( {ref:item,index:val} );
					}
				}else
				{
					checkParentRender(this,item,closeIndex+i+1);
				}
			}
			opens.push(item);
			item = null;
		}
		
		public function checkParentRender(target:BaseTreeItemRender,render:Object,index:int):void
		{
			if(isOpen == true || this.parent == null)
			{
				this.parentRender.checkParentRender(target,render,index);
			}else
			{
				pushRenderInCloseRef(render,index);
			}
		}
		
		protected function pushRenderInCloseRef(item:Object,val:int):void
		{
			val = val;
			for(var j:int=0;j<myCloseRefs.length;j++)
			{
				if(myCloseRefs[j].index >= val)
				{
					myCloseRefs[j].index += 1;
				}
			}
			myCloseRefs.push( {ref:item,index:val} );
		}
		
		public function record():void{
			myAllCose = [];
			for(var j:int=0;j<opens.length;j++){
				Object(opens[j]).record();
			}
			for( j=0;j<opens.length;j++){
				if(DisplayObject(opens[j]).parent != null){
					closeRefs.push([opens[j],DisplayObject(opens[j]).parent.getChildIndex(DisplayObject(opens[j]))]);
					myAllCose[j] = closeRefs[closeRefs.length-1];
				}
			}
		}
		
		public function removeMyOpen():void{
			for(var j:int=0;j<opens.length;j++){
				Object(opens[j]).removeMyOpen();
			}
			for( j=0;j<opens.length;j++){
				if(DisplayObject(opens[j]).parent != null){
					Tree(_list).removeItemRenderAt(opens[j] as IListItemRender);
				}
			}
		}
		
		public function reAlign():void
		{
			if(this.level != 0)  Object(this.parent.parent).reAlign();
		}
		
		protected function setOpenClickEvent():void
		{
			if(tree.isParentAutoClickOpen == false)
			{
				openSprite.addEventListener(MouseEvent.MOUSE_OVER,showOepnOver);
				openSprite.addEventListener(MouseEvent.MOUSE_OUT,showOepnOut);
				openSprite.addEventListener(MouseEvent.CLICK,openNode);
			}else
			{
				this.mouseChildren = false;
				this.addEventListener(MouseEvent.MOUSE_OVER,showOepnOver);
				this.addEventListener(MouseEvent.MOUSE_OUT,showOepnOut);
				this.addEventListener(MouseEvent.CLICK,openNode);
			}
		}

		protected function onTreeAddItem(event:TreeEvent):void
		{
			if(event.index < myIndex)
			{
				myIndex++;
			}
		}
	
		protected function onTreeAddRemove(event:TreeEvent):void
		{
			if(event.index < myIndex) myIndex--;
		}
		
		protected override  function showOver(event:MouseEvent=null):void
		{
			super.showOver(event);
		}
		
		protected function showOepnOver(event:MouseEvent):void
		{
		}
		
		protected function showOepnOut(event:MouseEvent):void
		{
		}
		
		protected function openNode(event:MouseEvent = null,myChildNodes:Object = null):void
		{
			isOpen = !isOpen;
			Tree(_list).setOpenState(_data,isOpen,this);
			var item:IListItemRender;
			myIndex= this.parent.getChildIndex(this);
			if(isOpen == true){
				if(openBp == null)
				{
					openBp = new Bitmap();
				}
				openBp.bitmapData = tree.openedIcon;
				if(isRecord == false){
					var xmlChildren:Object;
					if(myChildNodes == null)
					{
						xmlChildren = xml.children();
					}else
					{
						xmlChildren = myChildNodes;
					}
					var len:int = xmlChildren.length();
					var classRef:Class = tree.itemRender;
					for(var i:int=0;i<len;i++){
						var data:Object = xmlChildren[i];
						var key:String = this.idStr+":"+i+"_"+String(data.@label);
						var isHasChild:Boolean = data.hasComplexContent () ;
						item = tree.findInRenderCatch(key);
						var isIn:Boolean = true;
						if(item == null   || isHasChild == true)
						{
							isIn = false;
							item = new classRef();
							item.list = List(this._list);
							Object(item).level = this.level+1;
							item.data =data ;
							tree.addedIndex = myIndex+i+1;
							Object(item).parentRender = this;
						}else if(Object(item).needCreatNew==true)
						{
							isIn = false;
							item = new classRef();
							item.list = List(this._list);
							Object(item).level = this.level+1;
							item.data =data ;
							tree.addedIndex = myIndex+i+1;
							Object(item).parentRender = this;
						}
						Object(item).idStr = this.idStr+":_"+this.level;
						if(isIn==false && isHasChild == false)
						{
							tree.pushRenderInCatch(item,key);
						}
						Tree(_list).addItemRenderAt(item,myIndex+i+1);
						opens.push(item);
						item = null;
					}
				}else{
					myCloseRefs.sortOn("index",Array.NUMERIC);
					var lenRef:int = myCloseRefs.length;
					for(var m:int=0;m<lenRef;m++){
						item = myCloseRefs[m].ref as IListItemRender;
						Tree(_list).addItemRenderAt(item,this.parent.getChildIndex(this)+m+1);
					}
				}
				if(tree.isFindMode == true)
				{
					Tree(_list).dispatchEvent(new TreeEvent(TreeEvent.TREE_NODE_OPEN));
				}
			}else{
				openBp.bitmapData = tree.closedIcon;
				closeRefs = [];
				closer = this;
				record();
				myCloseRefs = [];
				var closerIndex:int = closer.parent.getChildIndex(closer);
				for(var j:int=0;j<closeRefs.length;j++){
					var closeItem:Object = closeRefs[j][0];
					closeItem.closeBy = closer;
					closeItem.closeIndex = closeItem.parent.getChildIndex(closeItem)-closerIndex;
					closeRefs[j][1] = closeRefs[j][1]- this.parent.getChildIndex(this);
					myCloseRefs[j] = {ref:closeRefs[j][0],index:closeRefs[j][1]};
				}
				isRecord = true;
				removeMyOpen();
				closeRefs=[];
				Tree(_list).dispatchEvent(new TreeEvent(TreeEvent.TREE_NODE_CLOSE));
			}
		}
		
	}
}