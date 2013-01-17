package cn.flashk.controls.skin 
{
	import cn.flashk.controls.interfaces.ISkin;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.DisplayObject;

	/**
	 * ...
	 * @author flashk
	 */
	public class ActionDrawSkin implements ISkin
	{
		protected var isHideOutSide:Boolean;
		protected var _view:DisplayObject;
		
		public function ActionDrawSkin() 
		{
		
		}
		
		public function get view():DisplayObject
		{
			return _view;
		}
		
		public function init(target:UIComponent,styleSet:Object):void {
			
		}
		
		public function reDraw():void {
			
		}
		
		public function hideOutState():void {
			isHideOutSide = true;
		}
		
		public function updateSkin():void {
			reDraw();
		}
		
	}
}