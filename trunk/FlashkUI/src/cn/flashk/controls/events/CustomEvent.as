package cn.flashk.controls.events
{
	import flash.events.Event;

	public class CustomEvent  extends Event
	{
		public static const ITEM_MOUSE_OVER:String = " itemMouseOver";
		public static const ITEM_MOUSE_OUT:String = " itemMouseOut";
		
		public function CustomEvent(type:String)
		{
			super(type);
		}
		
	}
}