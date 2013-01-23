package cn.flashk.controls.support
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import cn.flashk.controls.Tree;
	import cn.flashk.controls.managers.StyleManager;
	import cn.flashk.controls.managers.UISet;

	/**
	 * 默认树渲染器，如果自定义渲染器需要从 BaseTreeItemRender 以使用节点和管理展开功能
	 * @author flashk
	 * 
	 */
	public class TreeItemRender extends BaseTreeItemRender
	{
		protected var _isNeedSetText:Boolean = true;
		
		public override function destory():void
		{
			super.destory();
		}

		public function TreeItemRender()
		{
			super();
			this.mouseChildren = true;
		}
		
		public override function set index(value:int):void
		{
			super.index = value;
			
			if(value%2==0){
				_mouseOutAlpha = StyleManager.treeIndex1Alpha;
			}else
			{
				_mouseOutAlpha = StyleManager.treeIndex2Alpha;
			}
			if(_selected == false)
			{
				if(bg) bg.alpha = _mouseOutAlpha;
			}
		}
		
		override public function set data(value:Object):void{
			super.data = value;
			var isSetIcon:Boolean = false;
			if(_isNeedSetText)
			{
				txt.htmlText = String(xml.@label);
				txt.width = txt.textWidth + 5;
			}
			padding =Number(_list.getStyleValue("textPadding")) + level*levelSpace;
			var iconSet:XMLList = xml.attribute(_list.iconField.slice(1));
			if(iconSet.length()>0){
				var iconBD:BitmapData = Tree(_list).iconGetFunction(iconSet[0]) as BitmapData;
				if(iconBD != null){
					setIcon(iconBD,true);
					isSetIcon = true;
				}
			}
			if(xml.children().length()>0){
				if(isSetIcon == false){ 
					setIcon(tree.floderIcon,true);
				}
				openBp = new Bitmap(tree.closedIcon);
				openSprite = new Sprite();
				openSprite.graphics.beginFill(0,0);
				openSprite.graphics.drawRect(-13,0,23,23);
				openSprite.x = bp.x - 10;
				//
				setOpenClickEvent();
				//
				openBp.y = int((25-openBp.height)/2);
				openBp.smoothing = UISet.listIconSmooth;
				openSprite.addChild(openBp);
				this.addChild(openSprite);
			}else{
				if(isSetIcon == false){ 
					setIcon(tree.nodeIcon,true);
				}
			}
			txt.cacheAsBitmap = UISet.treeItemTextFieldCatch;
			this.cacheAsBitmap = UISet.treeRenderCatch;
		}
		
		protected override  function showOver(event:MouseEvent=null):void
		{
			super.showOver(event);
			if(_selected == false){
				if(bg)  bg.alpha = StyleManager.treeOverAlpha;
			}
		}
		
		protected override  function showOepnOver(event:MouseEvent):void{
			openSprite.filters = StyleManager.treeOpenIconOverFilter;
		}
		
		protected override  function showOepnOut(event:MouseEvent):void{
			openSprite.filters = null;
		}
		
	}
}