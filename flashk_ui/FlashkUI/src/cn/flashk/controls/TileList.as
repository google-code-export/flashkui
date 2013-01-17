package cn.flashk.controls
{
	import cn.flashk.controls.interfaces.ITileListItemRender;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.managers.StyleManager;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ListSkin;
	import cn.flashk.controls.skin.sourceSkin.ListSourceSkin;
	import cn.flashk.controls.support.TileListThumbnail;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * TileList用来显示一个类似于系统资源管理器一样的缩略图列表，列表中的项目按照网格排列
	 * 
	 * 默认显示缩略图的itemRender是cn.flashk.controls.support.TileListThumbnail
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.TileListThumbnail
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class TileList extends List
	{
		private var _verticalSpace:Number = 3;
		private var _horizontalSpace:Number = 7;
		
		public function TileList()
		{
			super();
			
			_compoWidth = 600;
			_compoHeight = 300;
			_snapNum = StyleManager.defaultTileListSnapNum;
			_itemRender = TileListThumbnail;
			_allowMultipleSelection = StyleManager.globalTileListAllowMultipleSelection;
			styleSet["textPadding"] = 10;
			styleSet["topPaddint"] = 5;
			styleSet["leftPaddint"] = 5;
			items.y = 1;
			_isSizeInit = false;
			scrollBar.mouseWellTarget = this;
			setSize(_compoWidth, _compoHeight);
		}
		/**
		 * 设置/获取 网格之间的横向间距
		 */ 
		public function set horizontalSpace(value:Number):void{
			_horizontalSpace = value;
		}
		
		public function get horizontalSpace():Number{
			return _horizontalSpace;
		}
		/**
		 * 设置/获取 网格之间的竖向间距
		 */
		public function set verticalSpace(value:Number):void{
			_verticalSpace = value;
		}
		
		public function get verticalSpace():Number{
			return _verticalSpace;
		}
		
		override public function setDefaultSkin():void {
			setSkin(ListSkin)
		}
		
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.LIST));
		}
		
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:ListSourceSkin = new ListSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		
		override protected function reAlign(event:Event):void
		{
			var itemT:ITileListItemRender;
			var max:uint;
			var nx:Number;
			var ny:Number;
			var scollLess:Number;
			if(_isNeedUpdate == true)
			{
				_isNeedUpdate = false;
				for(var i:int=0;i<items.numChildren;i++){
					itemT = items.getChildAt(i) as ITileListItemRender;
					items.getChildAt(i).visible = true;
					nx = itemT.itemWidth+_horizontalSpace;
					ny = itemT.itemHeight+_verticalSpace;
					if(i==0)
					{
						if(Math.floor(_compoWidth/nx)*Math.floor(_compoHeight/ny)>=items.numChildren)
						{
							scollLess = 0;
						}else
						{
							scollLess = 17
						}
						scrollBar.setTarget(items,false,_compoWidth-scollLess,_compoHeight-items.y-1);
					}
					max = uint((_compoWidth-scollLess)/nx);
					if(max == 0)
					{
						max = 1;
					}
					DisplayObject(itemT).x = styleSet["leftPaddint"] + i*nx%(max*nx);
					DisplayObject(itemT).y = styleSet["topPaddint"] + Math.floor(i/max)*ny;
				}
				scrollBar.snapNum = _snapNum;
				scrollBar.arrowClickStep = TileListThumbnail.defauleHeight+_verticalSpace;
				scrollBar.updateSize(Math.floor((items.numChildren-1)/max+1)*ny+styleSet["topPaddint"]+1);
			}
		}
		
	}
}