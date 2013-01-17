package cn.flashk.controls.managers 
{
	import flash.filters.GlowFilter;

	/**
	 * ...
	 * @author flashk
	 */
	public class StyleManager 
	{
		public static var globalWindowDragAlpha:Number = 0.65;
		public static var globalWindowDragTotalAlpha:Number = 1;
        public static var globalAbleUserResizeWindow:Boolean = true;
        public static var globalWindowAutoClip:Boolean = true;
		public static var globalShowWindowMiniButton:Boolean = true;
        public static var globalTabbarAutoClip:Boolean = true;
        public static var globalTabBarAlign:String = "center";
		public static var globalWindowuseDragCatch:Boolean = true;
		public static var globalTextInputColor:uint = 0x000000;
		public static var globalImagePadding:int = 5;
		public static var defaultListSnapNum:Number = 2;
		public static var defaultTileListSnapNum:Number = 2;
		public static var defaultTreeSnapNum:Number = 1;
		public static var globalWindowButtonsY:Number = 0;
		public static var globalWindowButtonsXLess:Number = 10;
		public static var listIndex1Alpha:Number = 0.1;
		public static var listIndex2Alpha:Number = 0;
		public static var listOverAlpha:Number = 0.5;
		public static var listClickAlpha:Number = 0.9;
		public static var treeIndex1Alpha:Number = 0.05;
		public static var treeIndex2Alpha:Number = 0;
		public static var treeOverAlpha:Number = 0.35;
		/**
		 * 滚动条的缓动值，1表示不使用缓动 
		 */
		public static var globalScrollBarSmoothNum:Number = 3.0;
		public static var listScrollBarSmoothNum:Number = 2.0;
		public static var scrollBarOutAlpha:Number = 0.6;
		/**
		 * 默认Image是否开启平滑图像显示 
		 */
		public static var globalImageSmoth:Boolean = true;
		/**
		 * 默认是否允许TileList控件使用按下拖拉矩形进行多选 
		 */
		public static var globalTileListAllowMultipleSelection:Boolean = true;
		public static var treeOpenIconOverFilter:Array = [new GlowFilter(0xFFFFFF,1,8,8,4.5,2)];

		public static function setThemeGradientMode(value:uint):void {
			ThemesSet.GradientMode = value;
		}
		
	}
}