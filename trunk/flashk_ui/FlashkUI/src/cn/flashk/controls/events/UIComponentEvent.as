package cn.flashk.controls.events
{
	import flash.events.Event;

	public class UIComponentEvent extends Event
	{
		public static const RESIZE:String = "resize";
		public static const SCROLL:String = "scroll";
		public static const SCROLL_BAR_START_DRAG:String = "scrollBarStartDrag";
		public static const SCROLL_BAR_STOP_DRAG:String = "scrollBarStopDrag";
		
		public function UIComponentEvent(type:String)
		{
			super(type);
		}
		
	}
}