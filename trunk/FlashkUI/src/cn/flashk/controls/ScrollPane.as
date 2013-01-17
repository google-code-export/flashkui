package cn.flashk.controls
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.managers.StyleManager;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ListSkin;
	import cn.flashk.controls.skin.sourceSkin.ListSourceSkin;
	import cn.flashk.controls.skin.sourceSkin.SourceSkin;
	import cn.flashk.controls.support.ColorConversion;
	import cn.flashk.controls.support.UIComponent;

	/**
	 * ScrollPane 组件在一个可滚动区域中呈现显示对象和 JPEG、GIF 与 PNG 文件，以及 SWF 文件。 可以使用滚动窗格来限制这些媒体类型所占用的屏幕区域。
	 *  滚动窗格可以显示从本地磁盘或 Internet 加载的内容。 在创作过程中和运行时，您都可以使用 ActionScript 设置此内容。  
	 * @author flashk
	 * 
	 */
	public class ScrollPane extends UIComponent
	{
		protected var _box:Sprite;
		protected var _vscrollBar:VScrollBar;
		protected var _hscrollBar:HScrollBar;
		protected var _ldr:Loader;
		protected var _scrollDrag:Boolean = true;
		protected var _isNeedClip:Boolean = true;
		protected var _imageSmooth:Boolean
		
		public function ScrollPane()
		{
			super();
			
			_compoWidth = 480;
			_compoHeight = 320;
			styleSet["ellipse"] = 0;
			styleSet["borderColor"] = ColorConversion.transUintToWeb(SkinThemeColor.border);
			styleSet["borderAlpha"] = 0.5;
			styleSet["backgroundColor"] = "#FDFDFD";
			styleSet["backgroundAlpha"] = 1.0;
			styleSet["textPadding"] = 5;
			styleSet["iconPadding"] = 5;
			_ldr = new Loader();
			_ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,onFileLoaded);
			_box = new Sprite();
			_box.x = _box.y =1;
			this.addChild(_box);
			_vscrollBar = new VScrollBar();
			_vscrollBar.smoothNum = StyleManager.listScrollBarSmoothNum;
			_vscrollBar.updateSize(100);
			_vscrollBar.smoothScroll = true;
			_vscrollBar.mousemouseWheelDelta = 1;
			_vscrollBar.visible = false;
			this.addChild(_vscrollBar);
			_hscrollBar = new HScrollBar();
			_hscrollBar.updateSize(100);
			this.addChild(_hscrollBar);
			setSize(_compoWidth,_compoHeight);
		}
		
		public function get hscrollBar():HScrollBar
		{
			return _hscrollBar;
		}

		public function get vscrollBar():VScrollBar
		{
			return _vscrollBar;
		}

		public function get imageSmooth():Boolean
		{
			return _imageSmooth;
		}
		
		/**
		 * Loader加载器，可以对此对象监听各个加载事件 
		 * @return 
		 * 
		 */
		public function get loader():Loader
		{
			return _ldr;
		}

		/**
		 * 对于外部加载的图像，放大时是否开启反锯齿 平滑
		 * @param value
		 * 
		 */
		public function set imageSmooth(value:Boolean):void
		{
			_imageSmooth = value;
		}

		/**
		 * 指示当用户在滚动窗格中拖动内容时是否发生滚动。 
		 * @param value
		 * 
		 */
		public function set scrollDrag(value:Boolean):void
		{
			_scrollDrag = value;
		}
		
		protected function onFileLoaded(event:Event):void
		{
			var con:DisplayObject = _ldr.content;
			_box.addChild(con);
			if(_ldr.content is Bitmap)
			{
				Bitmap(_ldr.content).smoothing = _imageSmooth;
			}
			if(_ldr.contentLoaderInfo.height > _compoHeight || _ldr.contentLoaderInfo.width > _compoWidth)
			{
				_isNeedClip = true;
				resetTarget();
				_vscrollBar.updateSize(_ldr.contentLoaderInfo.height-1);
				_hscrollBar.updateSize(_ldr.contentLoaderInfo.width-1);
			}else
			{
				_isNeedClip = false;
				_box.scrollRect = null;
			}
		}
		
		private function resetTarget():void
		{
			_vscrollBar.setTarget(_box,_scrollDrag,_compoWidth-VScrollBar.defaultWidth-2,_compoHeight-VScrollBar.defaultWidth-2);
			_hscrollBar.setTarget(_box,_scrollDrag,_compoWidth-VScrollBar.defaultWidth-2,_compoHeight-VScrollBar.defaultWidth-2);
		}
		
		/**
		 * 内容的容器 
		 * @return 
		 * 
		 */
		public function get content():Sprite
		{
			return _box;
		}
		
		override public function setDefaultSkin():void {
			setSkin(ListSkin)
		}
		
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.LIST));
		}
		
		override public function hideSkin(isHide:Boolean=true):void
		{
			if(SkinManager.isUseDefaultSkin)
			{
				styleSet["borderAlpha"] = 0;
				styleSet["backgroundAlpha"] = 0;
				updateSkin();
			}else
			{
				SourceSkin(skin).sc9Bitmap.visible = !isHide;
			}
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
		
		override public function setSize(newWidth:Number, newHeight:Number):void {
			super.setSize(newWidth, newHeight);
			_vscrollBar.y = 1;
			_vscrollBar.x = int(_compoWidth - VScrollBar.defaultWidth-1);
			_vscrollBar.setSize(VScrollBar.defaultWidth,_compoHeight-2-VScrollBar.defaultWidth);
			_hscrollBar.y = _compoHeight;
			_hscrollBar.setSize(VScrollBar.defaultWidth,_compoWidth-VScrollBar.defaultWidth);
			if(_isNeedClip == false) return;
			resetTarget();
		}
		
		/**
		 * 加载外部图像或者swf。该方法的 request 参数只接受其 source 属性包含字符串、类或 URLRequest 对象的 URLRequest 对象。 
		 * @param request
		 * @param context
		 * 
		 */
		public function load(request:URLRequest,context:LoaderContext = null):void
		{
			_ldr.load(request,context);
		}
		
		public function loadBytes(bytes:ByteArray,context:LoaderContext = null):void
		{
			_ldr.loadBytes(bytes,context);
		}
		
		/**
		 * 添加一个显示对象到容器中
		 * @param displayObject
		 * @param index
		 * 
		 */
		public function addView(displayObject:DisplayObject,index:int=-1):void
		{
			if(index<0) index = _box.numChildren;
			_box.addChildAt(displayObject,index);
			resetTarget();
		}
		
		/**
		 * 通知pane容器已经改变了大小 
		 * @param viewWidth
		 * @param viewHeight
		 * 
		 */
		public function updateViewSize(viewWidth:Number=-1,viewHeight:Number=-1):void
		{
			if(viewWidth == -1) viewWidth = _box.width;
			if(viewHeight == -1) viewHeight = _box.height;
			_vscrollBar.updateSize(viewHeight-1);
			_hscrollBar.updateSize(viewWidth-1);
		}
		
	}
}