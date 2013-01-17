package cn.flashk.controls
{
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SkinThemeColor;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * 
	 * NumericStepper 组件包括一个单行输入文本字段和一对用于逐一显示可能值的箭头按钮。还可使用向上箭头键和向下箭头增加减少这些值。。
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class NumericStepper extends TextInput
	{
		public var stepSize:Number = 1;
		private var _divisor:uint = 1;
		
		private var upBtn:Button;
		private var downBtn:Button;
		private var _maximum:Number = 100;
		private var _minimum:Number = 0;
		private var count:uint;
		private var id:int;
		private var sh:Shape;
		private var sh2:Shape;
		
		public function NumericStepper()
		{
			super();
			
			_compoWidth = 120;
			_compoHeight = 23;
			restrict = "0-9 . \\-";
			txt.addEventListener(FocusEvent.FOCUS_OUT,checkNum);
			upBtn = new Button();
			upBtn.setSize(17,12);
			upBtn.y = 0;
			downBtn = new Button();
			downBtn.setSize(17,11);
			downBtn.y = 12;
			upBtn.addEventListener(MouseEvent.CLICK,addNum);
			upBtn.addEventListener(MouseEvent.MOUSE_DOWN,upFrame);
			downBtn.addEventListener(MouseEvent.CLICK,lessNum);
			downBtn.addEventListener(MouseEvent.MOUSE_DOWN,downFrame);
			upBtn.label = "";
			downBtn.label = "";
			this.addChild(upBtn);
			this.addChild(downBtn);
			value = 0;
			if(SkinManager.isUseDefaultSkin == true){
				sh = new Shape();
				upBtn.icon = sh;
				sh2 = new Shape();
				downBtn.icon = sh2;
				updateSkinPro();
			}else{
				upBtn.useSkinSize = true;
				upBtn.setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.NUMERIC_STEPPER_UP));
				downBtn.useSkinSize = true;
				downBtn.setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.NUMERIC_STEPPER_DOWN));
			}
			setSize(_compoWidth,_compoHeight);
		}
		
		public function get divisor():uint
		{
			return _divisor;
		}

		/**
		 * 小数点后精确到多少位，如10精确到0.1（以0.1为单位），如100精确到0.01 
		 * @param valueDi
		 * 
		 */
		public function set divisor(valueDi:uint):void
		{
			_divisor = valueDi;
			value = value;
		}

		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			super.setSize(newWidth,newHeight);
			if(upBtn)
			{
				upBtn.x = downBtn.x = _compoWidth-15-2;
			}
		}
		
		protected function checkNum(event:Event=null):void
		{
			txt.text = Number(txt.text).toFixed(String(divisor).length-1);
			if(txt.text == "0.") txt.text = "0";
			if(Number(txt.text)> _maximum/divisor) txt.text = Number(_maximum/divisor).toFixed(String(divisor).length-1);
			if(Number(txt.text)< _minimum/divisor) txt.text = Number(_minimum/divisor).toFixed(String(divisor).length-1);
		}
		
		override protected function updateSkinPro():void{
			sh.graphics.beginFill(SkinThemeColor.arrowFillColor, 1);
			var a:Number =0;
			var b:Number = -7;
			sh.graphics.moveTo(int(2 / 2)+2.5+a, 4+2+b);
			sh.graphics.lineTo(int(2 / 2)+6.5+a, 8+2+b);
			sh.graphics.lineTo(int(2 / 2)-1.5+a, 8+2+b);
			sh2.graphics.beginFill(SkinThemeColor.arrowFillColor, 1);
			a = 0;
			b = -11;
			sh2.graphics.moveTo(int(2 / 2)+2.5+a, 12+2+b);
			sh2.graphics.lineTo(int(2 / 2)+6.5+a, 8+2+b);
			sh2.graphics.lineTo(int(2 / 2)-1.5+a, 8+2+b);
		}
		
		public function get upClickButton():Button{
			return upBtn;
		}
		
		public function get downClickButton():Button{
			return downBtn;
		}
		
		protected function upFrame(event:MouseEvent):void
		{
			id = setTimeout(upFrameMain,500);
		}
		
		private function upFrameMain():void{
			count =0;
			this.addEventListener(Event.ENTER_FRAME,addByFrame);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,clearUpFrame);
		}
		
		protected function clearUpFrame(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME,addByFrame);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,clearUpFrame);
		}
		
		protected function addByFrame(event:Event):void
		{
			count ++;
			if(count>1){
				count = 0;
				addNum();
			}
		}
		
		protected function downFrame(event:MouseEvent):void
		{
			id = setTimeout(downFrameMain,500);
		}
		
		private function downFrameMain():void{
			count =0;
			this.addEventListener(Event.ENTER_FRAME,lessByFrame);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,cleardownFrame);
		}
		
		protected function cleardownFrame(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME,lessByFrame);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,cleardownFrame);
		}
		
		protected function lessByFrame(event:Event):void
		{
			count ++;
			if(count>1){
				count = 0;
				lessNum();
			}
		}
		
		public function addNum(event:MouseEvent=null):void
		{
			var va:Number = Number(txt.text)*divisor;
			va += stepSize;
			if(va>_maximum )va = _maximum;
			txt.text = Number(va/divisor).toFixed(String(divisor).length-1);
			if(txt.text == "0.") txt.text = "0";
			if(event != null) clearTimeout(id);
		}
		
		public function lessNum(event:MouseEvent=null):void
		{
			var va:Number = Number(txt.text)*divisor;
			va -= stepSize;
			if(va<_minimum )va = _minimum;
			txt.text = Number(va/divisor).toFixed(String(divisor).length-1);
			if(txt.text == "0.") txt.text = "0";
			if(event != null) clearTimeout(id);
		}
		
		public function set maximum(value:Number):void{
			_maximum = value*divisor;
			checkNum();
		}
		
		public function get maximum():Number{
			return _maximum/divisor;
		}
		
		public function set minimum(value:Number):void{
			_minimum = value*divisor;
			if(value<0)
			{
				txt.restrict = "0-9 . \\-";
			}else
			{
				txt.restrict = "0-9 .";
			}
			checkNum();
		}
		
		public function get minimum():Number{
			return _minimum/divisor;
		}
		
		public function set value(va:Number):void{
			va = va *divisor;
			txt.text = Number(va/_divisor).toFixed(String(divisor).length-1);
			if(txt.text == "0.") txt.text = "0";
		}
		
		public function get value():Number{
			return Number(txt.text);
		}
		
	}
}