package cn.flashk.controls.skin 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	
	import cn.flashk.controls.managers.DefaultStyle;
	/**
	 * ...
	 * @author flashk
	 */
	public class MotionSkinControl 
	{
		/**
		 * 滑过时的ColorTransform的Offset值，每一个为下一帧的值，以此组成动画 
		 */
		public static var over:Array = [4, 8, 12,16, 20];
		/**
		 * 滑出时的ColorTransform的Offset值，反向排列。每一个为下一帧的值，以此组成动画 
		 */
		public static var out:Array = [2,4,6,8,10,12,14,16,18,20];
		public static var RBG:Array = [1,1,1];
		/**
		 *  over的倍数
		 */
		public static var multiplier:Number = 1.5;
		
		public var showDown:Boolean = true;
		public var resetAlpha:Boolean = true;
		public var filtersDown:Array;
		
		private var eventDis:InteractiveObject;
		private var view:DisplayObject;
		private var index:int;
		private var isOutViewHide:Boolean = false;
		private var bakFilters:Array;
		
		public function MotionSkinControl(eventDis:InteractiveObject,view:DisplayObject) 
		{
			this.eventDis = eventDis;
			this.view = view;
			eventDis.addEventListener(MouseEvent.MOUSE_OVER, startShowOver);
			eventDis.addEventListener(MouseEvent.MOUSE_OUT, startShowOut);
			eventDis.addEventListener(MouseEvent.MOUSE_DOWN, startShowDown);
			eventDis.addEventListener(MouseEvent.MOUSE_UP, startShowUp);
			var shadow:DropShadowFilter = new DropShadowFilter(1, 90, 0, 0.3, 4, 4, 1, 1, true);
			filtersDown = DefaultStyle.filters.slice(0);
			filtersDown.push(shadow);
		}
		
		public function setOutViewHide(isHide:Boolean):void {
			isOutViewHide = isHide;
		}
		
		private function startShowOver(event:MouseEvent):void {
			index = 0;
			eventDis.removeEventListener(Event.ENTER_FRAME, outMotion);
			eventDis.addEventListener(Event.ENTER_FRAME, overMotion);
		}
		
		private function startShowOut(event:MouseEvent):void {
			index = out.length - 1;
			view.filters = bakFilters;
			eventDis.removeEventListener(Event.ENTER_FRAME, overMotion);
			eventDis.addEventListener(Event.ENTER_FRAME, outMotion);
		}
		
		private function startShowUp(event:MouseEvent):void {
			view.filters = bakFilters;
			index = over.length - 1;
			view.transform.colorTransform = new ColorTransform(1, 1,1, view.alpha, over[index]*multiplier, over[index]*multiplier, over[index]*multiplier, 0);
		}
		
		private function startShowDown(event:MouseEvent):void {
			if(showDown == false) return;
			eventDis.removeEventListener(Event.ENTER_FRAME, outMotion);
			eventDis.removeEventListener(Event.ENTER_FRAME, overMotion);
			bakFilters = view.filters;
			view.filters = filtersDown;
		}
		
		private  function overMotion(event:Event):void {
			if (index > over.length - 1) {
				eventDis.removeEventListener(Event.ENTER_FRAME, overMotion);
			}else {
				view.transform.colorTransform = new ColorTransform(1-(1-RBG[0])*index/over.length,1-(1-RBG[1])*index/over.length,1-(1-RBG[2])*index/over.length, view.alpha, over[index]*multiplier, over[index]*multiplier, over[index]*multiplier, 0);
				if (isOutViewHide == true) {
					view.alpha = (index+1) / over.length;
				}else {
					if(resetAlpha == true){
						view.alpha = 1;
					}
				}
			}
			index ++;
		}
		
		private  function outMotion(event:Event):void {
			if (index <0) {
				eventDis.removeEventListener(Event.ENTER_FRAME, outMotion);
			}else {
				view.transform.colorTransform = new ColorTransform(1-(1-RBG[0])*index/out.length,1-(1-RBG[1])*index/out.length,1-(1-RBG[2])*index/out.length,  view.alpha, out[index]*multiplier, out[index]*multiplier, out[index]*multiplier, 0);
				if (isOutViewHide == true) {
					view.alpha = index / out.length;
				}else {
					if(resetAlpha == true){
						view.alpha = 1;
					}
				}
			}
			index --;
		}
		
	}
}