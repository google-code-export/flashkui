package cn.flashk.controls 
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.modeStyles.TextInputStyle;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.TextInputSkin;
	import cn.flashk.controls.skin.sourceSkin.TextInputSourceSkin;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.XString;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * TextInput 组件是单行文本组件，其中包含本机 ActionScript TextField 对象。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class TextInput extends UIComponent
	{
		protected var txt:TextField;
		protected var _tipText:String;
		protected var tf:TextFormat;
		
		public function TextInput() 
		{
			super();
			
			_compoWidth = 120;
			_compoHeight = 23;
			txt = new TextField();
			txt.background = false;
			txt.type = TextFieldType.INPUT;
			txt.x = 5;
			txt.y = 3;
			txt.height = 20;
			txt.addEventListener(FocusEvent.FOCUS_IN, checkTextFocusIn);
			txt.addEventListener(FocusEvent.FOCUS_OUT, checkTextFocusOut);
			this.addChild(txt);
			new TextInputStyle(styleSet);
			tf = new TextFormat();
			tf.align = TextFormatAlign.LEFT;
			tf.size = DefaultStyle.fontSize;
			tf.color = styleSet[TextInputStyle.TEXT_COLOR];
			tf.font = DefaultStyle.font;
			txt.defaultTextFormat = tf;
			setSize(_compoWidth, _compoHeight);
			this.dispatchEvent(new Event(Event.INIT));
		}
		
		override protected function updateSkinBefore():void
		{
			styleSet[ ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH ] = DefaultStyle.ellipse;
			styleSet[ ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT ] = DefaultStyle.ellipse;
			styleSet[ ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH ] = DefaultStyle.ellipse;
			styleSet[ ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT ] = DefaultStyle.ellipse;
		}
		/**
		 * 设置最大可以输入的中文数，一个中文按照两个英文字母计算，所以如果设置为 10则可以输入10个中文，20个英文，如果从剪切板复制过来，则进行截断
		 * @param max
		 * 
		 */
		public function set maxChineseChars(max:uint):void
		{
			XString.setInputMaxChars(txt,max*2);
		}
		
		public function get textField():TextField {
			return txt;
		}
		
		public function set text(value:String):void {
			if(value == null) value = "";
			txt.text = value;
		}
		
		public function get text():String {
			return txt.text;
		}
		
		public function set restrict(value:String):void {
			txt.restrict = value;
		}
		
		public function set tipText(value:String):void {
			_tipText = value;
			txt.text = _tipText;
			tf.color = styleSet[TextInputStyle.TIP_TEXT_COLOR];
			txt.setTextFormat(tf);
		}
		
		override public function setDefaultSkin():void {
			setSkin(TextInputSkin);
		}
		
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.TEXT_INPUT));
		}
		
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:TextInputSourceSkin = new TextInputSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void {
			super.setSize(newWidth, newHeight);
			txt.width = _compoWidth -10;
		}
		
		override public function setStyle(styleName:String, value:Object):void {
			super.setStyle(styleName, value);
			switch(styleName) {
				case TextInputStyle.TEXT_COLOR:
					break;
			}
		}
		
		protected function checkTextFocusIn(event:FocusEvent):void {
			if (txt.text == _tipText) {
				txt.text = "";
			}
		}
		
		protected function checkTextFocusOut(event:FocusEvent):void {
			if (txt.text == "") {
				if(_tipText != null && _tipText != "")
				{
					txt.text = _tipText;
					tf.color = styleSet[TextInputStyle.TIP_TEXT_COLOR];
					txt.setTextFormat(tf);
				}
			}
		}
		
	}
}