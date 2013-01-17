package cn.flashk.controls
{
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.support.UIComponent;

	/**
	 * Label 组件将显示单行纯文本或 HTML 格式的文本，这些文本的对齐和大小格式可进行设置。
	 * 若要显示文本背景，请对background对象进行操作 
	 * @author as
	 * 
	 */
	public class Label extends UIComponent
	{
		private var _textField:TextField;
		private var _textFormat:TextFormat;
		private var _background:Shape;
		
		public function Label()
		{
			_compoWidth =300;
			_compoHeight = 20;
			_textField = new TextField();
			selectable = false;
			_textFormat = new TextFormat();
			_textFormat.font = DefaultStyle.font;
			_textField.defaultTextFormat = _textFormat;
			_background = new Shape();
			setSize(_compoWidth,_compoHeight);
			this.addChild(_background);
			this.addChild(_textField);
		}

		public function get background():Shape
		{
			return _background;
		}

		public function set background(value:Shape):void
		{
			if(_background && _background.parent)
			{
				_background.parent.removeChild(_background);
			}
			_background = value;
			this.addChildAt(_background,0);
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
		
		/**
		 * 文本是否加粗显示 
		 * @param value
		 * 
		 */
		public function set bold(value:Boolean):void
		{
			_textFormat.bold = value;
			_textField.setTextFormat(_textFormat);
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
		
		public function set text(value:String):void
		{
			_textField.text = value;
			_textField.setTextFormat(_textFormat);
			if(_textField.textWidth>_compoWidth-2)
			{
				setSize(_textField.textWidth+2,_compoHeight);
			}
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
		
		public function get textHeight():Number
		{
			return _textField.textHeight;
		}
		
		public function get textWidth():Number
		{
			return _textField.textWidth;
		}
		
		public function set selectable(value:Boolean):void
		{
			_textField.selectable = value;
			if(value == true)
			{
				this.mouseChildren = true;
			}else
			{
				this.mouseChildren = false;
			}
			this.mouseEnabled = false;
		}
		
		public function get selectable():Boolean
		{
			return _textField.selectable;
		}
		
		public function set wordWrap(value:Boolean):void
		{
			_textField.wordWrap = value;
		}
		
		public function get wordWrap():Boolean
		{
			return _textField.wordWrap;
		}
		
		public function set condenseWhite(value:Boolean):void
		{
			_textField.condenseWhite = value;
		}
		
		public function get condenseWhite():Boolean
		{
			return _textField.condenseWhite;
		}
		
		public function set autoSize(value:String):void
		{
			_textField.autoSize = value;
		}
		
		public function get autoSize():String
		{
			return _textField.autoSize;
		}
		
		public override function setSize(newWidth:Number, newHeight:Number):void
		{
			super.setSize(newWidth,newHeight);
			_textField.width = newWidth;
			_textField.height = newHeight;
		}
		
	}
}