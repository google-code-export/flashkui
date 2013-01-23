package cn.flashk.controls.support
{
	import cn.flashk.controls.List;
	import cn.flashk.controls.events.ListEvent;
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.managers.StyleManager;
	import cn.flashk.controls.managers.UISet;
	import cn.flashk.controls.skin.sourceSkin.ListItemSourceSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	public class ListItemRender extends Sprite implements IListItemRender
	{
		protected var tf:TextFormat;
		protected var _data:Object;
		protected var txt:TextField;
		protected var bg:Shape;
		protected var _height:Number;
		protected var _width:Number;
		protected var _list:Object;
		protected var _selected:Boolean = false;
		protected var bp:Bitmap;
		protected var padding:Number;
		protected var _isUseMyselfPadding:Boolean = false;
		protected var skin:ListItemSourceSkin;
		protected var iconDis:DisplayObject;
		protected var _mouseOutAlpha:Number;
		protected var _click:SimpleButton;
		protected var _clickArea:Shape;
		protected var _index:int;
		protected var _needResetTextColor:Boolean = true;

		public function get index():int
		{
			return _index;
		}

		public function get mouseOutAlpha():Number
		{
			return _mouseOutAlpha;
		}

		public function set mouseOutAlpha(value:Number):void
		{
			_mouseOutAlpha = value;
		}

		public function destory():void
		{
			_list = null;
			txt = null;
			iconDis = null;
			bg = null;
			_data = null;
			bp = null;
			this.removeEventListener(MouseEvent.DOUBLE_CLICK,onRenderDoubleClick);
			this.removeEventListener(MouseEvent.CLICK,onRenderClick);
		}
		
		public function ListItemRender()
		{
			txt = new TextField();
			_height = List.defaultItemHeight;
			txt.mouseEnabled = false;
			this.mouseChildren = false;
			txt.y = 2;
			txt.x = 20;
			txt.y = int((_height-19)/2);
			txt.y = txt.y + DefaultStyle.fontExcursion;
			tf = new TextFormat();
			tf.font = DefaultStyle.font;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
			this.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,showOut);
			txt.defaultTextFormat =tf ;
			this.addChild(txt);
			txt.height = _height-2;
			if(SkinManager.isUseDefaultSkin == true){
				bg = new Shape();
				this.addChildAt(bg,0);
			}else{
				skin = new ListItemSourceSkin();
				skin.init2(this,{},SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.LIST_ITEM_BACKGROUND));
				skin.space = 1;
				_clickArea = new Shape();
				_click = new SimpleButton();
				_click.hitTestState = _clickArea;
				_click.useHandCursor = false;
				this.addChildAt(_clickArea,0);
			}
		}
		
		public function setMouseAble(value:Boolean):void
		{
			this.mouseChildren = value;
			this.mouseEnabled = value;
			if(value == false)
			{
				this.removeEventListener(MouseEvent.MOUSE_OVER,showOver);
				this.removeEventListener(MouseEvent.MOUSE_OUT,showOut);
			}
		}
		
		public function set index(value:int):void
		{
			_index = value;
			if(value%2==0){
				_mouseOutAlpha = StyleManager.listIndex1Alpha;
			}else
			{
				_mouseOutAlpha = StyleManager.listIndex2Alpha;
			}
			if(_selected == false)
			{
				if(bg) bg.alpha = _mouseOutAlpha;
			}
		}
		
		protected function showOver(event:MouseEvent=null):void
		{
			if(_selected == false){
				if(bg)  bg.alpha = StyleManager.listOverAlpha;
				if(_needResetTextColor)
				{
					tf.color = SkinThemeColor.itemMouseOverTextColor;
					txt.setTextFormat(tf);
				}
				if(skin != null){
					skin.showState(1);
				}
			}
		}
		
		public function showSelect(event:MouseEvent=null):void
		{
			if(bg)  bg.alpha = StyleManager.listClickAlpha;
			if(_needResetTextColor)
			{
				tf.color = SkinThemeColor.itemOverTextColor;
				txt.setTextFormat(tf);
			}
			txt.defaultTextFormat =tf ;
			if(skin != null){
				skin.showState(2);
			}
		}
		
		protected function showOut(event:MouseEvent =null):void
		{
			if(_selected == false){
				if(bg) bg.alpha = _mouseOutAlpha;
				if(_needResetTextColor)
				{
					tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
					txt.setTextFormat(tf);
				}
			
				txt.defaultTextFormat =tf ;
				if(skin != null){
					skin.showState(0);
				}
			}
		}
		
		public function set list(value:List):void{
			_list = value;
			if(value.itemDoubleClickEnabled == true)
			{
				this.doubleClickEnabled = true;
				this.addEventListener(MouseEvent.DOUBLE_CLICK,onRenderDoubleClick);
			}
			this.addEventListener(MouseEvent.CLICK,onRenderClick);
		}
		
		protected function onRenderClick(event:MouseEvent):void
		{
			DisplayObject(_list).dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,this));
		}
		
		protected function onRenderDoubleClick(event:MouseEvent):void
		{
			DisplayObject(_list).dispatchEvent(new ListEvent(ListEvent.ITEM_DOUBLE_CLICK,this));
		}
		
		public function set data(value:Object):void{
			_data = value;
			txt.text = _data.label;
			txt.width = txt.textWidth + 5;
			if(_data.icon != null){
				setIcon(_data.icon,List(_list).useIconWidth);
			}
			txt.cacheAsBitmap = UISet.listItemTextFieldCatch;
			this.cacheAsBitmap = UISet.listRenderCath;
		}
		
		public function setIcon(iconRef:Object,isUseMyselfPadding:Boolean = false):void{
			iconDis = null;
			_isUseMyselfPadding = isUseMyselfPadding;
			if(bp == null){
				bp = new Bitmap();
			}
			if(iconRef is String)
			{
				try{
					iconRef = getDefinitionByName(String(iconRef)) as Class;
				}catch(e:Error)
				{
					if(_list && _list.loaderInfo)
					{
						iconRef = _list.loaderInfo.applicationDomain.getDefinition(String(iconRef)) as Class;
					}
				}
			}
			if(iconRef is Class){
				var icon:Object = new iconRef();
				if(icon is BitmapData)
				{
					bp.bitmapData = icon as BitmapData;
				}else
				{
					iconDis = icon as DisplayObject;
				}
			}
			if(iconRef is BitmapData){
				bp.bitmapData = iconRef as BitmapData;
			}
			bp.smoothing = UISet.listIconSmooth;
			this.addChild(bp);
			if(isUseMyselfPadding == false){
				bp.x = Number(_list.getStyleValue("iconPadding"));
			}else{
				bp.x = padding;
				if(iconDis)
				{
					txt.x = bp.x + iconDis.width;
				}else
				{
					txt.x = bp.x + bp.width+2;
				}
			}
			bp.y = int((_height - bp.height)/2);
			if(bp.y<0) bp.y = 0;
			if(iconDis)
			{
				this.addChild(iconDis);
				this.removeChild(bp);
			}
		}
		
		public function get data():Object{
			return _data;
		}
		
		public function get itemHeight():Number{
			return _height;
		}
		
		public function setSize(newWidth:Number, newHeight:Number):void{
			_width = newWidth;
			if(_isUseMyselfPadding == false){
				txt.x = Number(_list.getStyleValue("textPadding"));
			}
			if(_selected == true){
				showSelect();
			}
			if(skin != null){
				skin.setSize(newWidth,newHeight);
			}
			if(SkinManager.isUseDefaultSkin == false){
				_clickArea.graphics.clear();
				_clickArea.graphics.beginFill(0,0);
				_clickArea.graphics.drawRect(0,0,newWidth,List.defaultItemHeight);
			}else
			{
				bg.graphics.clear();
				if(SkinThemeColor.listBackgroundFillColors.length>1)
				{
					var mat:Matrix;
					mat = new Matrix();
					mat.createGradientBox(newWidth, _height, SkinThemeColor.listBackgroundFillAngle* Math.PI / 180);
					bg.graphics.beginGradientFill(GradientType.LINEAR, SkinThemeColor.listBackgroundFillColors, SkinThemeColor.listBackgroundFillAlphas, SkinThemeColor.listBackgroundFillRatios, mat);
				}else
				{
					bg.graphics.beginFill(SkinThemeColor.listBackgroundFillColors[0],SkinThemeColor.listBackgroundFillAlphas[0]);
				}
				if(DefaultStyle.listBackgroundEllipse == 0)
				{
					bg.graphics.drawRect(1,0,newWidth-1,_height);
				}else
				{
					var el:Number = DefaultStyle.listBackgroundEllipse;
					RoundRectAdvancedDraw.drawAdvancedRoundRect(bg.graphics, 1, 0, newWidth-1, _height, el, el,el,el,el,el,el,el,el,el);
				}
			}
		}
		
		public function set selected(value:Boolean):void{
			_selected = value;
			if(_selected == true){
				showSelect();
			}else{
				showOut();
			}
		}
		
		public function get selected():Boolean{
			return _selected;
		}
		
	}
}