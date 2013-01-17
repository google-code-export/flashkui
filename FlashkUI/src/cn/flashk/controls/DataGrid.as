package cn.flashk.controls
{
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.support.DataGridColumnSet;
	import cn.flashk.controls.support.DataGridItemRender;
	import cn.flashk.controls.support.DataGridTitle;
	import cn.flashk.controls.support.TextFieldItemRender;
	
	import flash.display.DisplayObject;
	
	/**
	 * DataGrid 类是基于列表的组件，提供呈行和列分布的网格。 可以在该组件顶部指定一个可选标题行，用于显示所有属性名称。 每一行由一列或多列组成，其中每一列表示属于指定数据对象的一个属性。
	 * 
	 * <p>DataGrid 组件特别适用于显示包含多个属性的对象。</p>
	 * <p>columnWidths、dataField、labels、sortByNumberTypes的长度应该保持一致。 </p>
	 * 
	 * 
	 * 有两种方式来初始化dataGrid:
	 * 
	 * 
	 * 			dg.columnWidths = [-30,-30,-40];
	 * 			dg.labels = ["标题","时间","大小"];
	 * 			dg.dataField = ["label","label2","title"];
	 * 			dg.sortByNumberTypes = [ false,true,false];
	 * 
	 * 
	 * 或者
	 * 
	 *			var sets:Vector. DataGridColumnSet = new Vector. DataGridColumnSet ();
	 *			sets.push(new DataGridColumnSet("序","label1",36));
	 *			sets.push(new DataGridColumnSet("玩家","label2",120));
	 *			dg.initColumns(sets);
	 * 		
	 *  对于columnWidths 最后一个如果为0将使用剩余的宽度，前面的值如果为正，则使用像素，如果为负数，则使用百分比如-30=30% 50=50px
	 * 
	 *  可以设置itemRender属性指向你自己定义的类引用来使用你自己的渲染器，参见ListItemRender和IListItemRender接口
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.video.VideoDisplay
	 * @see cn.flashk.controls.support.ListItemRender
	 * @see cn.flashk.controls.interfaces.IListItemRender
	 * 
	 * @author flashk
	 */

	public class DataGrid extends List
	{
		protected var title:DataGridTitle;
		protected var _labels:Array =["标题","标题","标题","标题"];
		protected var _dataField:Array =["label","label2","labe3","labe4"];
		protected var _columnWidths:Array =[-25,-25,-25,-25];
		protected var _sortByNumberTypes:Array =[true,true,true,true,true,true,true,true,true,true,true,true,true,true];
		protected var _renders:Array = [TextFieldItemRender,TextFieldItemRender,TextFieldItemRender,TextFieldItemRender,TextFieldItemRender];
		protected var _isSetWidth:Boolean = false;
		
		public function DataGrid()
		{
			this.mouseEnabled = false;
			super();
			_compoWidth = 600;
			_itemRender = DataGridItemRender;
			styleSet["padding"] = 10;
			styleSet["paddingRight"] = 5;
			items.y = 25;
			scrollBar.setTarget(items,false,_compoWidth,15);
			title = new DataGridTitle();
			title.dg = this;
			this.addChild(title);
			setSize(_compoWidth, _compoHeight);
		}
		
		public function set ableTitleSort(value:Boolean):void
		{
			title.mouseChildren = value;
		}
		
		public function initColumns(setArray:Vector.<DataGridColumnSet>):void
		{
			var arr:Array = [[],[],[],[],[]];
			for(var i:int =0 ;i<setArray.length;i++)
			{
				arr[0].push(setArray[i].title);
				arr[1].push(setArray[i].dataField);
				arr[2].push(setArray[i].sortByNumberTypes);
				arr[3].push(setArray[i].width);
				arr[4].push(setArray[i].itemRender);
			}
			_renders = arr[4];
			columnWidths = arr[3];
			dataField = arr[1];
			sortByNumberTypes = arr[2];
			labels = arr[0];
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void
		{
			super.setSize(newWidth,newHeight);
			if(title)
			{
				title.setSize(_compoWidth,items.y);
			}
		}
		
		/**
		 * 获得对表格标题栏实例的引用
		 */ 
		public function get dataGridTitle():DataGridTitle
		{
			return title;
		}
		
		public function get dataField():Array
		{
			return _dataField;
		}
		
		public function get renders():Array
		{
			return _renders;
		}
		
		public function set renders(value:Array):void
		{
			 _renders = value;
		}
		
		/**
		 * 设置/获取每一列的数据字段名，此字段属性的内容将提供给相应位置的单元格渲染器。
		 * 
		 * @default ["label","label2","labe3","labe4"]
		 */
		public function set dataField(value:Array):void
		{
			_dataField = value;
		}
		
		public function get columnWidths():Array
		{
			return _columnWidths;
		}
		
		/**
		 * 设置/获取表格每一列的宽度，可以使用正数和负数，如果是正数，则表示列的实际像素宽度，如果是负数，则表示百分比。
		 * <p>如：dg.columnWidths = [-30,-30,-40]表示第1列的宽度是整个表格宽度的30%</p>
		 * 
		 * @default [-25,-25,-25,-25]
		 */ 
		public function set columnWidths(value:Array):void
		{
			_isSetWidth = true;
			_columnWidths = value;
		}
		
		public function get labels():Array
		{
			return _labels;
		}
		
		/**
		 * 设置/获取每一列的标题文字。
		 * 
		 * @default ["标题","标题","标题","标题"]
		 */
		public function set labels(value:Array):void
		{
			_labels = value;
			if(_isSetWidth == false)
			{
				for(var i:int=0;i<value.length;i++)
				{
					_columnWidths[i] = -1/value.length*100;
				}
			}
			title.updateLabels();
		}
		
		/**
		 * 设置/获取每一列当用户点击列标题的排序依据，如果是字符串(a-z排序，再次点击相反），则填false,如果是数字则true(0-9排序，再次点击相反）
		 * 
		 * @default  [true,true,true,true]
		 */ 
		public function set sortByNumberTypes(value:Array):void
		{
			_sortByNumberTypes = value;
		}
		
		public function get sortByNumberTypes():Array
		{
			return _sortByNumberTypes;
		}
		
		/**
		 * 以指定的标题重新排序表格，并指定是升序还是降序排序
		 * 
		 * @param titleName 依据的标题名字，也就是显示在表格最顶部的标题
		 * @param isUp true为升序排序(0-9)(a-z) false 为降序排序(9-0)(z-a)
		 */ 
		public function sortOnByTitle(titleName:String,isUp:Boolean):void
		{
			for(var i:int=0;i<_labels.length;i++)
			{
				if(_labels[i] == titleName)
				{
					sortOnByIndex(i,isUp);
					break;
				}
			}
		}
		
		/**
		 * 以指定的索引重新排序表格，并指定是升序还是降序排序
		 * 
		 * @param index 依据的索引，按照labels/dataField的索引，而不是永恒拖动后的索引
		 * @param isUp true为升序排序(0-9)(a-z) false 为降序排序(9-0)(z-a)
		 */ 
		public function sortOnByIndex(index:uint,isUp:Boolean):void
		{
			var fieldName:String = _dataField[index];
			var sortOptions:Object;
			if(isUp == true)
			{
				if(_sortByNumberTypes[index] == false)
				{
					sortOptions = Array.CASEINSENSITIVE;
				}else
				{
					sortOptions =Array.NUMERIC  |Array.CASEINSENSITIVE;
				}
			}else
			{
				if(_sortByNumberTypes[index] == false)
				{
					sortOptions = Array.DESCENDING |Array.CASEINSENSITIVE;
				}else
				{
					sortOptions =Array.NUMERIC | Array.DESCENDING |Array.CASEINSENSITIVE;
				}
			}
			var all:Array = new Array();
			var obj:Object;
			for(var i:int =0;i<items.numChildren;i++)
			{
				obj = new Object();
				obj.comp = IListItemRender(items.getChildAt(i)).data[fieldName];
				obj.ref = items.getChildAt(i);
				all[i] = obj;
			}
			all.sortOn("comp",sortOptions);
			for(i=0;i<all.length;i++)
			{
				items.removeChild(all[i].ref);
			}
			for(i=0;i<all.length;i++)
			{
				items.addChild(all[i].ref);
				if(i==0)
				{
					DisplayObject(all[i].ref).y = 0;
				}else
				{
					DisplayObject(all[i].ref).y = items.getChildAt(i-1).y + IListItemRender(items.getChildAt(i-1)).itemHeight;
				}
			}
		}
		
		/**
		 * 以指定的数据字段重新排序表格，并指定是升序还是降序排序
		 * 
		 * @param fieldName 依据的数据字段名字，也就是添加的数据对象字段
		 * @param isUp true为升序排序(0-9)(a-z) false 为降序排序(9-0)(z-a)
		 */ 
		public function sortOnBydataField(fieldName:String,isUp:Boolean):void
		{
			for(var i:int=0;i<_dataField.length;i++)
			{
				if(_dataField[i] == fieldName)
				{
					sortOnByIndex(i,isUp);
					break;
				}
			}
		}
		
	}
}