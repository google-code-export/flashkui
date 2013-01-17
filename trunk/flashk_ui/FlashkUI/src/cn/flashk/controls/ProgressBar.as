package cn.flashk.controls
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ProgressBarSkin;
	import cn.flashk.controls.skin.sourceSkin.ProgressBarSourceSkin;
	import cn.flashk.controls.support.ColorConversion;
	import cn.flashk.controls.support.UIComponent;
	
	[Style(name="ellipse", type="String")]
	[Style(name="borderAlpha", type="String")]
	[Style(name="backgroundAlpha", type="String")]
	[Style(name="motionWidth", type="String")]
	[Style(name="motionSpace", type="String")]
	[Style(name="motionAngle", type="String")]

	/**
	 * ProgressBar 组件显示内容的加载进度。 ProgressBar 通常用于显示图像和部分应用程序的加载状态。 加载进程可以是确定的也可以是不确定的。  
	 * @author flashk
	 * 
	 */
	public class ProgressBar extends UIComponent
	{
		protected var _value:Number;
		protected var _maximum:Number = 1;
		protected var _showMotion:Boolean = true;
		protected var _motionAlpha:Number = 0.5;
		protected var _motionSpeed:Number = 1.5;
		protected var _textField:TextField;
		protected var _textFormat:TextFormat;
		protected var _showText:String = "正在加载，已完成*%，请稍候..."
		protected var _textShowHeight:Number = 20;
		protected var _textSpaceY:Number = 5;
		protected var _toFixNum:uint = 1;
		protected var _target:Object;
		protected var _type:int;
		protected var _indeterminate:Boolean = false;
		
		
		public function ProgressBar()
		{
			super();
			
			_compoWidth = 270;
			_compoHeight = 7;
			styleSet["ellipse"] = 5;
			styleSet["borderColor"] = ColorConversion.transUintToWeb(SkinThemeColor.border);
			styleSet["borderAlpha"] = 0.5;
			styleSet["backgroundColor"] = "#FDFDFD";
			styleSet["backgroundAlpha"] = 1.0;
			styleSet["motionWidth"] = 10;
			styleSet["motionSpace"] = 5;
			styleSet["motionAngle"] = 30;
			this.mouseChildren = false;
			this.mouseEnabled = false;
			_textField = new TextField();
			_textField.selectable = false;
			_textField.height = _textShowHeight;
			this.addChild(_textField);
			_textFormat = new TextFormat();
			_textFormat.font = DefaultStyle.font;
			_textFormat.align = TextFormatAlign.CENTER;
			_textField.defaultTextFormat = _textFormat;
			setSize(_compoWidth,_compoHeight);
			value = 0;
		}
		
		public function get indeterminate():Boolean
		{
			return _indeterminate;
		}
		
		public override function setStyle(styleName:String, value:Object):void
		{
			super.setStyle(styleName,value);
			skin.reDraw();
		}

		public function set indeterminate(valueNum:Boolean):void
		{
			_indeterminate = valueNum;
			if(_indeterminate == true)
			{
				value = 0;
				_showMotion = true;
			}
		}
		
		override protected function updateSkinBefore():void
		{
			value = value;
		}

		public function get percentComplete():Number
		{
			return value*100/_maximum;
		}
		
		public function get toFixNum():uint
		{
			return _toFixNum;
		}
		
		public function set source(targetObj:Object):void
		{
			target = targetObj;
		}
		
		public function set target(targetObj:Object):void
		{
			_target = targetObj;
			var ldr:Loader = _target as Loader;
			if(ldr)
			{
				_type = 1;
				ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,updatePercent);
				ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,removeUpdate);
				this.addEventListener(Event.ENTER_FRAME,updatePercent);
			}else
			{
				var uldr:URLLoader = _target as URLLoader;
				if(uldr)
				{
					_type = 2;
					uldr.addEventListener(ProgressEvent.PROGRESS,updatePercent);
					uldr.addEventListener(Event.COMPLETE,removeUpdate);
					this.addEventListener(Event.ENTER_FRAME,updatePercent);
				}else 
				{
					var info:LoaderInfo = targetObj as LoaderInfo;
					if(info)
					{
						_type = 3;
						info.addEventListener(ProgressEvent.PROGRESS,updatePercent);
						info.addEventListener(Event.COMPLETE,removeUpdate);
						this.addEventListener(Event.ENTER_FRAME,updatePercent);
					}else
					{
						throw new Error("不受支持的类型。");
					}
				}
			}
		}
		
		public function targetLoader(loader:Loader):void
		{
			target = loader;
		}
		
		public function targetURLLoaderr(uldr:URLLoader):void
		{
			target = uldr;
		}
		public function targetContentLoaderInfo(info:LoaderInfo):void
		{
			target = info;
		}
		private function removeUpdate(event:Event):void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
			this.removeEventListener(Event.ENTER_FRAME,updatePercent);
			if(_type == 1)
			{
				Loader(_target).contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,updatePercent);
			}else if(_type == 2)
			{
				URLLoader(_target).removeEventListener(ProgressEvent.PROGRESS,updatePercent);
			}else
			{
				LoaderInfo(_target).removeEventListener(ProgressEvent.PROGRESS,updatePercent);
			}
		}
		
		protected function updatePercent(event:Event):void
		{
			var a:Number;
			var b:Number;
			if(_type == 1)
			{
				var ldr:Loader = _target as Loader;
				a = ldr.contentLoaderInfo.bytesLoaded;
				b = ldr.contentLoaderInfo.bytesTotal;
			}else if(_type==2)
			{
				var uldr:URLLoader = _target as URLLoader;
				a = uldr.bytesLoaded;
				b = uldr.bytesTotal;
			}else if(_type == 3)
			{
				var info:LoaderInfo = _target as LoaderInfo;
				a = info.bytesLoaded;
				b = info.bytesTotal;
			}else{
				a = 0;
				b = 1;
			}
			var c:Number;
			c = a/b;
			if(isNaN(c) || c <0 ) c = 0;
			if(c>1) c = 1;
			value = c*_maximum;
		}
		
		/**
		 * 文本颜色 
		 * @param color
		 * 
		 */
		public function set textColor(color:uint):void
		{
			_textField.textColor = color;
		}
		
		public function get textColor():uint
		{
			return _textField.textColor;
		}
		
		/**
		 * 百分比后面要显示多少位的小数点，默认为1位，可以设置为0以显示整数百分比
		 * @param value
		 * 
		 */
		public function set toFixNum(value:uint):void
		{
			_toFixNum = value;
		}

		public function get textSpaceY():Number
		{
			return _textSpaceY;
		}

		public function set textSpaceY(value:Number):void
		{
			_textSpaceY = value;
			_textField.y = _compoHeight+_textSpaceY;
		}

		public function get textShowHeight():Number
		{
			return _textShowHeight;
		}

		public function set textShowHeight(value:Number):void
		{
			_textShowHeight = value;
			_textField.height = value;
		}

		public function get showText():String
		{
			return _showText;
		}

		public function set showText(str:String):void
		{
			_showText = str;
			value = value;
		}

		public function get textFormat():TextFormat
		{
			return _textFormat;
		}
		
		public function set textFormat(value:TextFormat):void
		{
			_textFormat = value;
			_textField.defaultTextFormat = value;
			_textField.setTextFormat(value);
		}
		
		public function set text(value:String):void
		{
			_textField.text = value;
			_textField.setTextFormat(_textFormat);
		}
		
		public function get text():String
		{
			return _textField.text;
		}
		
		public function set htmlText(value:String):void
		{
			_textField.htmlText = value;
			_textField.setTextFormat(_textFormat);
		}
		
		public function get htmlText():String
		{
			return _textField.htmlText;
		}
		
		public function get textField():TextField
		{
			return _textField;
		}

		public function set textField(value:TextField):void
		{
			if(_textField.parent)
			{
				_textField.parent.removeChild(_textField);
			}
			_textField = value;
			this.addChild(_textField);
		}

		public function get motionSpeed():Number
		{
			return _motionSpeed;
		}

		/**
		 * 动画的移动速度 
		 * @param value
		 * 
		 */
		public function set motionSpeed(value:Number):void
		{
			_motionSpeed = value;
		}

		public function get motionAlpha():Number
		{
			return _motionAlpha;
		}

		/**
		 * 动画的透明度 
		 * @param value
		 * 
		 */
		public function set motionAlpha(value:Number):void
		{
			_motionAlpha = value;
		}

		public function get showMotion():Boolean
		{
			return _showMotion;
		}

		public function set showMotion(value:Boolean):void
		{
			_showMotion = value;
		}

		public function get maximum():Number
		{
			return _maximum;
		}

		public function set maximum(value:Number):void
		{
			_maximum = value;
		}

		override public function setDefaultSkin():void {
			setSkin(ProgressBarSkin)
		}
		
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.PROGRESS_BAR));
		}
		
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:ProgressBarSourceSkin = new ProgressBarSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		
		public function get value():Number
		{
			return _value;
		}

		/**
		 * 手动设定百分比 
		 * @param percent
		 * 
		 */
		public function set value(percent:Number):void
		{
			_value = percent;
			if(isNaN(value)) value = 0;
			if(value > _maximum) value = _maximum;
			if(SkinManager.isUseDefaultSkin == true){
				text = _showText.split("*%").join(Number(value*100/_maximum).toFixed(_toFixNum)+"%");
			}else
			{
				text = "";
			}
			skin.updateValue();
		}
		
		public override function setSize(newWidth:Number, newHeight:Number):void
		{
			super.setSize(newWidth,newHeight);
			_textField.width = newWidth;
			_textField.y = _compoHeight+_textSpaceY;
		}
		
	}
}