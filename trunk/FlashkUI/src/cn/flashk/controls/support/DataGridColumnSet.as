package cn.flashk.controls.support
{
	public class DataGridColumnSet
	{
		public var title:String = "标题";
		public var dataField:String = "label";
		public var sortByNumberTypes:Boolean = true;
		public var itemRender:Class = TextFieldItemRender;
		public var width:Number = -25;
		
		public function DataGridColumnSet(titleSet:String="标题",
										  dataFieldSet:String="label",
										  widthSet:Number=-25,
										  itemRenderSet:Class=null,
										  sortByNumverTypeSet:Boolean=true)
		{
			title = titleSet;
			dataField = dataFieldSet;
			width = widthSet;
			if(itemRenderSet != null)
			{
				itemRender = itemRenderSet;
			}
			sortByNumberTypes = sortByNumverTypeSet;
		}
		
	}
}