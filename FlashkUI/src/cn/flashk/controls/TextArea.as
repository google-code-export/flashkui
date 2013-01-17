package cn.flashk.controls
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.skin.TextAreaSkin;
	import cn.flashk.controls.skin.sourceSkin.ListSourceSkin;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.ColorConversion;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * TextArea 组件是一个带有边框和可选滚动条的多行文本字段。 TextArea 组件支持 Adobe Flash Player 的 HTML 呈现功能。 
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class TextArea extends UIComponent
	{
		private var txt:TextField;
		private var tf:TextFormat;
		private var hScrollBar:HScrollBar;
		private var _vScrollBar:VScrollBar;
		
		public function TextArea()
		{
			super();
			
			_compoWidth = 300;
			_compoHeight = 200;
			styleSet["ellipse"] = 0;
			styleSet["borderColor"] = ColorConversion.transUintToWeb(SkinThemeColor.border);
			styleSet["borderAlpha"] = 0.5;
			styleSet["backgroundColor"] = "#FDFDFD";
			styleSet["backgroundAlpha"] = 1.0;
			styleSet["textPadding"] = 3;
			txt = new TextField();
			txt.type = TextFieldType.INPUT;
			this.addChild(txt);
			txt.x = styleSet["textPadding"] ;
			txt.y = styleSet["textPadding"] ;
			txt.addEventListener(Event.CHANGE,checkViewScroll);
			txt.multiline = true;
			tf = new TextFormat();
			tf.align = TextFormatAlign.LEFT;
			tf.size = DefaultStyle.fontSize;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
			tf.font = DefaultStyle.font;
			txt.defaultTextFormat = tf;
			hScrollBar = new HScrollBar();
			this.addChild(hScrollBar);
			hScrollBar.x = 1;
			hScrollBar.updateSize(600);
			hScrollBar.clipSize = _compoWidth;
			hScrollBar.addEventListener("scroll",scrollTextH);
			_vScrollBar = new VScrollBar();
			_vScrollBar.y = 1;
			this.addChild(_vScrollBar);
			_vScrollBar.setTarget(txt);
			wordWrap = true;
			setSize(_compoWidth, _compoHeight);
			this.graphics.beginFill(0);
			checkViewScroll();
		}
		
		public function get vScrollBar():VScrollBar
		{
			return _vScrollBar;
		}
		
		public function get textField():TextField
		{
			return txt;
		}
		
		public function set wordWrap(value:Boolean):void
		{
			if(value==true)
			{
				hScrollBar.visible = false;
				txt.wordWrap = true;
			}else
			{
				hScrollBar.visible = true;
				txt.wordWrap = false;
			}
		}
		
		protected function scrollTextH(event:Event):void
		{
			txt.scrollH = int(hScrollBar.scrollPosition);
		}
		
		public function set htmlText(value:String):void
		{
			if(value == null) value = "";
			txt.htmlText = value;
			hScrollBar.maxScrollPosition = txt.maxScrollH;
			hScrollBar.updateSize(600);
			vScrollBar.updateSize();
			checkViewScroll();
		}
		
		public function get htmlText():String
		{
			return txt.htmlText;
		}
		
		public function set text(value:String):void{
			if(value == null) value = "";
			txt.text = value;
			hScrollBar.maxScrollPosition = txt.maxScrollH;
			hScrollBar.updateSize(600);
			vScrollBar.updateSize();
			checkViewScroll();
		}
		
		public function get text():String{
			return txt.text;
		}
		
		override public function setDefaultSkin():void {
			setSkin(TextAreaSkin)
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
		
		private function checkViewScroll(event:Event=null):void
		{
			if(txt.maxScrollH > 0)
			{
				hScrollBar.visible = true;
			}else
			{
				hScrollBar.visible = false;
			}
			if(txt.maxScrollV > 1)
			{
				vScrollBar.visible = true;
				txt.width = _compoWidth-17;
			}else
			{
				vScrollBar.visible = false;
				txt.width = _compoWidth-txt.x*2;
			}
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void 
		{
			super.setSize(newWidth, newHeight);
			hScrollBar.y = _compoHeight-1;
			hScrollBar.setSize(17,_compoWidth-2-17);
			_vScrollBar.x = _compoWidth-16;
			_vScrollBar.setSize(17,_compoHeight-2);
			if(vScrollBar.visible==true)
			{
				txt.width = newWidth-17;
			}else
			{
				txt.width = _compoWidth-txt.x*2;
			}
			if(hScrollBar.visible == true)
			{
				txt.height = newHeight-17;
			}else
			{
				txt.height = newHeight - txt.y;
			}
		}
		
	}
}