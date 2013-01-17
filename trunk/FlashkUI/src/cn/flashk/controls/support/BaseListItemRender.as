package cn.flashk.controls.support
{
	import cn.flashk.controls.List;
	import cn.flashk.controls.interfaces.ITileListItemRender;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * ListItemRender的基类，自定义List,TileList的Render可以从此类继承快速开发，然后覆盖方法
	 * */
	public class BaseListItemRender extends Sprite implements ITileListItemRender
	{
		protected var _data:Object;
		protected var _height:Number = 25;
		protected var _width:Number = 100;
		protected var _list:List;
		protected var _selected:Boolean = false;
		
		public function BaseListItemRender()
		{
			this.addEventListener (MouseEvent.MOUSE_OVER , showOver);
			this.addEventListener (MouseEvent.MOUSE_OUT , showOut);
		}
		
		protected function showOver(event:MouseEvent = null):void
		{
			if (_selected == false)
			{
				//
			}
		}
		
		public function set index(value:int):void
		{
			
		}
		
		public function showSelect(event:MouseEvent = null):void
		{
			
		}
		
		protected function showOut(event:MouseEvent = null):void
		{
			if (_selected == false)
			{
				//
			}
		}
		
		public function set list(value:List):void
		{
			_list = value;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function get itemHeight():Number
		{
			return _height;
		}
		
		public function get itemWidth():Number
		{
			return _width;
		}
		
		public function setSize(newWidth:Number , newHeight:Number):void
		{
			if (_selected == true)
			{
				showSelect ();
			}
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			if (_selected == true)
			{
				showSelect ();
			}
			else
			{
				showOut ();
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
	}
}
