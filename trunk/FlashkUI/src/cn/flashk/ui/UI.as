package cn.flashk.ui
{
    import cn.flashk.controls.Button;
    import cn.flashk.controls.CheckBox;
    import cn.flashk.controls.ComboBox;
    import cn.flashk.controls.DataGrid;
    import cn.flashk.controls.HScrollBar;
    import cn.flashk.controls.Image;
    import cn.flashk.controls.List;
    import cn.flashk.controls.NumericStepper;
    import cn.flashk.controls.Panel;
    import cn.flashk.controls.RadioButton;
    import cn.flashk.controls.Slider;
    import cn.flashk.controls.TabBar;
    import cn.flashk.controls.TextArea;
    import cn.flashk.controls.TextInput;
    import cn.flashk.controls.TileList;
    import cn.flashk.controls.Tree;
    import cn.flashk.controls.VScrollBar;
    import cn.flashk.controls.layout.Align;
    import cn.flashk.controls.managers.SkinThemeColor;
    import cn.flashk.controls.support.Tab;
    import cn.flashk.controls.support.UIComponent;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    /**
     * UI自动构建
     * @author flashk
     * 
     */
    public class UI
    {
        //最大嵌套循环次数
        private static var _maxStep:uint = 1000;
        private static var _stepCount:uint;
        private static var _addI:int;
        
        public function UI()
        {
        }

        public static function get maxStep():uint
        {
            return _maxStep;
        }

        public static function set maxStep(value:uint):void
        {
            _maxStep = value;
        }

        /**
         * 自动构建整个UI界面为组件，将循环检查此对象的所有子级，所有组件按照同样位置，同样大小，同样层级构建，替换规则参考buildOneDis函数
         * @param target
         * 
         */
        public static function autoBuild(target:Sprite):void
        {
            _stepCount = 0;
            buildOneSprite(target);
        }
		public static function init(stage:Stage):void
		{
			UIComponent.stage = stage;
			Align.stage = stage;
			SkinThemeColor.userDefaultColor(32);
		}
		/**
		 * 创建一个按钮 
		 * @param label
		 * @param parentSprite
		 * @param clickFunction
		 * @param x
		 * @param y
		 * @param width
		 * @param height
		 * @return 
		 * 
		 */
		public static function creatButton(label:String,parentSprite:Sprite,clickFunction:Function=null,x:Number=0,y:Number=0,width:Number=-1,height:Number=-1):Button
		{
			var btn:Button;
			btn = new Button();
			btn.label = label;
			parentSprite.addChild(btn);
			if(clickFunction != null)
			{
				btn.addEventListener(MouseEvent.CLICK,clickFunction);
			}
			btn.x = x;
			btn.y = y;
			if(width != -1 && height != -1)
			{
				btn.setSize(width,height);
			}
			return btn;
		}
        
        private static function buildOneSprite(sp:Sprite):void
        {
            _stepCount++;
            if(_stepCount>_maxStep)
            {
                return;
            }
            var i:int=0;
            for(i=0;i<sp.numChildren;i++)
            {
               buildOneDis(sp,i);
               i+=_addI;
            }
        }
        
        private static function buildOneDis(sp:Sprite,index:int):void
        {
            var name:String;
            var i:int;
            var controls:UIComponent;
            var needSetSize:Boolean = true;
            var isNeedBuildIn:Boolean = true;
            var dis:DisplayObject = sp.getChildAt(index);
            if(dis is UIComponent && (dis is Panel)==false)
            {
               return;
            }
            if(dis is Sprite )
            {
                //嵌套循环查找
                buildOneSprite(dis as Sprite);
            }
            name = dis.name;
            _addI = 0;
            var endName:String = name.slice(name.lastIndexOf("_")+1);
            endName = "_"+endName;
            
            switch(endName)
            {
                case "_button":
                    var btn:Button = new Button();
                    btn.label = findLabelText(dis,index);
                    controls = btn;
                    break;
                
                case "_slider":
                    var slider:Slider = new Slider();
                    controls = slider;
                    break;
                
                case "_comboBox":
                    controls = new ComboBox();
                    break;
                
                case "_image":
                    controls = new Image();
                    break;
                
                case "_radioButton":
                    var radio:RadioButton = new RadioButton();
                    radio.label = " 　";
					radio.groupName = sp.name;
					if(index==0)
					{
						radio.selected = true;
					}else
					{
						radio.selected = false;
					}
                    controls = radio;
                    needSetSize = false;
                    break;
                
                case "_checkBox":
                    var check:CheckBox = new CheckBox();
                    check.label = " 　";
                    controls = check;
                    needSetSize = false;
                    break;
                
                case "_tab":
                    var tabBar:TabBar = new TabBar();
                    var barSP:Sprite = dis as Sprite;
                    if(barSP)
                    {
                        var tab:Tab;
                        var tabName:String;
                        var tabGetDis:DisplayObject;
                        for(i=0;i<barSP.numChildren;i++)
                        {
                            tabGetDis = barSP.getChildAt(i);
                            if(tabGetDis is Sprite)
                            {
                                tabName = tabGetDis.name;
                                var tabConn:DisplayObject = sp.getChildByName(tabName);
                                if(tabConn)
                                {
                                    if(sp.getChildIndex(tabConn)<index)
                                    {
                                        index--;
                                        _addI--;
                                    }
                                }
                                var tabLabel:String = findLabelText(tabGetDis,i);
                                tab = tabBar.addTab(tabLabel,tabConn);
                                tab.name = tabName;
                            }
                        }
                    }
                    controls = tabBar;
                    break;
                
                case "_list":
                    controls = new List();
                    break;
                
                case "_tileList":
                    controls = new TileList();
                    break;
                
                case "_dataGrid":
                    controls = new DataGrid();
                    break;
                
                case "_tree":
                    controls = new Tree();
                    break;
                
                case "_vScrollBar":
                    controls = new VScrollBar();
                    break;
                
                case "_hScrollBar":
                    controls = new HScrollBar();
					needSetSize = false;
					controls.setSize(Math.round(dis.height),Math.round(dis.width));
                    break;
				
				
				case "_textInput":
					controls = new TextInput();
					break;
				
				
				case "_textArea":
					controls = new TextArea();
					break;
				
				
				case "_numericStepper":
					controls = new NumericStepper();
					break;
                    
                default:
                    break;
            }
            
            if(controls == null)
            {
                return;
            }
            
            controls.name = name;
            controls.x = int(dis.x);
            controls.y = int(dis.y);
            sp.removeChildAt(index);
            sp.addChildAt(controls,index);
            if(needSetSize)
            {
                controls.setSize(Math.round(dis.width),Math.round(dis.height));
            }
        }
        private static function findLabelText(labelDisplayObj:DisplayObject,index:uint):String
        {
            var par:DisplayObjectContainer = labelDisplayObj.parent;
            var len:uint = par.numChildren;
            var dis:DisplayObject;
            var j:int;
            for( j=index+1;j<len;j++)
            {
               dis = par.getChildAt(j);
               if(dis is TextField)
               {
                   if(dis.x>labelDisplayObj.x && dis.x < labelDisplayObj.x+labelDisplayObj.width/2 && dis.y > labelDisplayObj.y && dis.y < labelDisplayObj.y+labelDisplayObj.height/2)
                   {
                          dis.parent.removeChild(dis);
                          return TextField(dis).text;
                   }
               }
            }
            return " 　";
        }
        /**
         * 替换单个UI控件
         * 
         * @param targetName 参照的对象名字
         * @param parentSprite 父层
         * @param uiComponent UI控件
         * @param isReSize
         * @param isUseSameName
         * @param isUseSameXY
         * @param isAutoRemove
         * 
         */
        public static function buildOne(targetName:String,parentSprite:Sprite,uiComponent:UIComponent,
                                        isReSize:Boolean=true,
                                        isUseSameName:Boolean=true,
                                        isUseSameXY:Boolean=true,
                                        isAutoRemove:Boolean=true):void
        {
            var dis:DisplayObject = parentSprite.getChildByName(targetName);
            var index:uint = parentSprite.getChildIndex(dis);
            if(isReSize)
            {
                uiComponent.setSize(Math.round(dis.width),Math.round(dis.height));
            }
            if(isUseSameName)
            {
                uiComponent.name = dis.name;
            }
            if(isUseSameXY)
            {
                uiComponent.x = int(dis.x);
                uiComponent.y = int(dis.y);
            }
            if(isAutoRemove)
            {
                parentSprite.removeChildAt(index);
                parentSprite.addChildAt(uiComponent,index);
            }
        }
    }
}