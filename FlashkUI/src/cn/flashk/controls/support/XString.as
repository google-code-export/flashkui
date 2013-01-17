package cn.flashk.controls.support
{
	import flash.events.TextEvent;
	import flash.text.TextField;

	public class XString
	{
		/**
		 * （起始位置）汉字的编码范围是19968~40869  (0x4E00- 0x9FA5)
		 */		
		public static const chineseStartAt:uint = 0x4E00;
		/**
		 * 中文编码范围 结束位置   40869
		 */
		public static const chineseEndAt:uint = 0x9FA5;
		
		/**
		 * 计算字符长度，中文按照两个字符计算 
		 * @param str
		 * @return 
		 * 
		 */
		public static function getLength(str:String):uint 
		{   
			var len:uint = 0;
			for (var i:int = 0; i<str.length; i++) {
				var code:Number = str.charCodeAt(i);
				len += (code<0x4E00 || code > 0x9FA5)  ? 1 : 2; 
			}
			return len;
		}
		
		/**
		 * 限制输入文本框的最大输入字符数，与 maxChars不同的是，中文按照两个字符来计算
		 * @param target TextField对象
		 * @param max 最大字符数
		 * 
		 */
		public static function setInputMaxChars(target:TextField,max:uint):void
		{
			target.maxChars = max;
			target.addEventListener(TextEvent.TEXT_INPUT,checkTextInput);
		}
		
		/**
		 * 移除 setInputMaxChars的事件侦听，以便进行垃圾回收
		 * @param target
		 * 
		 */
		public static function removeInputMaxCharsListener(target:TextField):void
		{
			target.removeEventListener(TextEvent.TEXT_INPUT,checkTextInput);
		}
		
		/**
		 * 从指定索引中截取指定个数的字符串返回，中文按照两个字符串计算 
		 * @param str
		 * @param length 要提取的个数，如果超过字符串最后一个，则只提取到末尾
		 * @param startIndex 开始位置
		 * @return 
		 * 
		 */
		public static function sliceString(str:String,length:int,startIndex:uint=0):String
		{
			var output:String="";
			if(length <= 0 ) return output;
			var nowLen:uint=0;
			var index:uint=startIndex;
			while(nowLen<=length)
			{
				output += str.slice(index,index+1);
				index++;
				var code:Number = str.charCodeAt(index);
				nowLen += (code<0x4E00 || code > 0x9FA5)  ? 1 : 2; 
				if(index==str.length)
				{
					nowLen = length+1;
				}
			}
			return output;
		}
		
		private static function checkTextInput(event:TextEvent):void
		{
			var txt:TextField = event.currentTarget as TextField;
			if(XString.getLength(txt.text+event.text)>txt.maxChars)
			{
				event.preventDefault();
				txt.appendText( sliceString(event.text,txt.maxChars-getLength(txt.text)) );
			}
		}
		
	}
}