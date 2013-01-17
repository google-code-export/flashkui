package cn.flashk.controls 
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.ButtonMode;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.RadioButtonSkin;
	import cn.flashk.controls.skin.sourceSkin.RadioButtonSourceSkin;
	import cn.flashk.controls.support.ColorConversion;
	import cn.flashk.controls.support.RadioButtonGroup;
	
	import flash.text.TextFormatAlign;
	
	/**
	 * 使用 RadioButton 组件可以强制用户只能从一组选项中选择一项。 
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.RadioButtonGroup
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class RadioButton extends ToggleButton
	{
		protected var _groupName:String;
		protected var _group:RadioButtonGroup;
		protected var _value:Object;
		
		public function RadioButton() 
		{
			super();
			
			label = "单选";
			styleSet[ ButtonStyle.TEXT_COLOR ] = DefaultStyle.checkBoxTextColor;
			styleSet[ ButtonStyle.TEXT_OVER_COLOR ] = DefaultStyle.checkBoxTextOverColor;
			styleSet[ ButtonStyle.TEXT_DOWN_COLOR ] = DefaultStyle.checkBoxTextColor;
			tf.align = TextFormatAlign.LEFT;
			txt.setTextFormat(tf)
			initTextColor();
			setSize(_compoWidth,_compoHeight);
			selected = false;
			groupName = "defaultRadioButtonGroup";
		}
		
		override public function setDefaultSkin():void {
			setSkin(RadioButtonSkin);
		}
		
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.RADIO_BUTTON));
		}
		
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:RadioButtonSourceSkin = new RadioButtonSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		
		public override function set selected(value:Boolean):void
		{
			super.selected = value;
			this.mouseEnabled = !value;
			this.mouseChildren = !value;
		}
		
		/**
		 * 单选按钮实例或组的组名。
		 */ 
		public function set groupName(value:String):void {
			_groupName = value;
			if (_group != null) {
				_group.removeRadioButton(this);
			}
			_group = RadioButtonGroup.getGroup(_groupName);
			_group.addRadioButton(this);
		}
		
		public function get groupName():String {
			return _groupName;
		}
		
		/**
		 * 此 RadioButton 所属的 RadioButtonGroup 对象。
		 */ 
		public function get group():RadioButtonGroup {
			return _group;
		}
		
		/**
		 * 与单选按钮关联的用户定义值。
		 */ 
		public function set value(val:Object):void {
			_value = val;
		}
		
		public function get value():Object {
			return _value;
		}
		
		override public function set label(value:String):void
		{
			super.label = value;
			txt.width = txt.textWidth + 10;
		}
		
		override public function updateSkin():void {
			super.updateSkin();
			styleSet[ ButtonStyle.TEXT_COLOR ] = DefaultStyle.checkBoxTextColor;
			styleSet[ ButtonStyle.TEXT_OVER_COLOR ] = DefaultStyle.checkBoxTextOverColor;
			styleSet[ ButtonStyle.TEXT_DOWN_COLOR ] = DefaultStyle.checkBoxTextColor;
			initTextColor();
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void {
			super.setSize(newWidth, newHeight);
			if (_mode == ButtonMode.JUST_ICON) {
				iconBD.x = int((_compoWidth - iconBD.width) / 2)+1;
			}else{
				txt.width = _compoWidth -16;
				txt.x = 17;
				txt.y = int((_compoHeight - txt.height) / 2);
				txt.y = txt.y + DefaultStyle.fontExcursion;
				var bak:Object = tf.color;
				tf.color = ColorConversion.transformWebColor(DefaultStyle.buttonTextDropColor);
				tf.color = bak;
			}
		}
		
	}
}