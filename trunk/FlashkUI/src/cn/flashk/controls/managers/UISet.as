package cn.flashk.controls.managers
{
	public class UISet
	{
		public static var isImageDestoryRun:Boolean = true;
		/**
		 *  TextField文本是否启用cacheAsBitmap
		 */
		public static var globalTextFieldCatch:Boolean = false;
		/**
		 *  按钮TextField文本是否启用cacheAsBitmap
		 */
		public static var buttonTextFieldCatch:Boolean = false;
		public static var buttonCatchAsBitmap:Boolean = true;
		public static var treeItemTextFieldCatch:Boolean = false;
		public static var treeRenderCatch:Boolean = true;
		public static var listItemTextFieldCatch:Boolean = false;
		public static var listRenderCath:Boolean = true;
		/**
		 * 使用AS做皮肤时是否对矢量启用缓存 
		 */
		public static var asSkinShapeCatch:Boolean = false;
		/**
		 * 组件被禁用鼠标的 [色相，饱和度，亮度，对比度] 值 ，默认为[ 0 , -100 , 20 , 0]
		 */
		public static var disableHSB:Array = [ 0 , -100 , 20 , 0];
		/**
		 *  组件被禁用鼠标的透明度值
		 */
		public static var disableAlpha:Number = 0.8;
		public static var isScrollBarHideArrow:Boolean = false;
		public static var listIconSmooth:Boolean = false;
	
	}
}