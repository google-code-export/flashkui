package cn.flashk.controls.interfaces
{
	import flash.display.DisplayObject;

	public interface ISkin
	{
		function get view():DisplayObject;
		function reDraw():void;
		function updateSkin():void;
	}
}