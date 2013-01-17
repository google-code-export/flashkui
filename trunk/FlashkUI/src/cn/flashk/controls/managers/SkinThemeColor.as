package cn.flashk.controls.managers 
{
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	import cn.flashk.controls.skin.MotionSkinControl;

	/**
	 * ...
	 * @author flashk
	 * 
	默认及新建AS外观的颜色
	 */
	public class SkinThemeColor 
	{
		public static var themColors:Array = new Array();
		private static var isInit:Boolean = false;
		public static var fillColors:Array =[];
		public static var fillAlphas:Array = [1.0, 1.0, 1.0, 1.0];
		public static var fillRatios:Array = [0, 127, 128, 255];
		public static var fillAngle:Number = 90;
		public static var imageFillColors:Array =[];
		public static var imageFillAlphas:Array = [0.5, 0.5, 0.5, 0.5];
		public static var imageFillRatios:Array = [0, 127, 128, 255];
		public static var imageFillAngle:Number = 90;
		public static var scrollBarFillColors:Array =[];
		public static var scrollBarFillAlphas:Array = [1, 1, 1, 1];
		public static var scrollBarFillRatios:Array = [0, 127, 128, 255];
		public static var scrollBarFillAngle:Number = 90;
		public static var border:uint = 0x3C7FB1;
		public static var top:uint = 0xFFFFFF;
		public static var upperMiddle:uint = 0xDAF0FC;
		public static var lowerMiddle:uint = 0xB9E3FA;
		public static var bottom:uint = 0x77BADE;
		public static var textBackgroudColor:uint = 0XFFFFFF;
		public static var tabHightLight:uint = 0xFFFFFF;
		public static var itemOverColor:uint= 0x77BADE;
		public static var itemOverTextColor:uint= 0xFFFFFF;
		public static var itemMouseOverTextColor:uint = 0x000000;
		public static var borderAlpha:Number = 1.0;
		public static var arrowFillColor:uint = 0x000000;
		public static var imageBorderColor:uint = 0x0;
		public static var imageBorderAlpha:Number = 0.5;
		public static var scrollbarBorderColor:uint = 0x0;
		public static var scrollbarBorderAlpha:Number = 0.5;
		public static var scrollBarShapeColor1:uint = 0x00000;
		public static var scrollBarShapeAlpha1:Number = 0.85;
		public static var scrollBarShapeColor2:uint = 0xFFFFFF;
		public static var scrollBarShapeAlpha2:Number = 0.2;
		public static var scrollBarBarFillColors:Array =  [0xCCCCCC, 0xFFFFFF];
		public static var scrollBarBarFillAngle:Number = 0;
		public static var scrollBarBarFillAlphas:Array =  [1.0, 1.0];
		public static var scrollBarBarFillRatios:Array = [0, 255];
		public static var listBackgroundFillColors:Array =  [0xCCCCCC, 0xFFFFFF];
		public static var listBackgroundFillAngle:Number = 0;
		public static var listBackgroundFillAlphas:Array =  [1.0, 1.0];
		public static var listBackgroundFillRatios:Array = [0, 255];
		public static var textInputFillColors:Array =  [0xEEEEEE, 0xFFFFFF];
		public static var textInputFillAngle:Number = 90;
		public static var textInputFillAlphas:Array =  [1.0, 1.0];
		public static var textInputFillRatios:Array = [0, 255];
		
		public static function initImageFillStyle(fillGraphics:Graphics,width:Number,height:Number,angle:Number=-1):void
		{
			fillGraphics.lineStyle(1, imageBorderColor,imageBorderAlpha,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			if(imageFillColors.length>1)
			{
				var mat:Matrix;
				mat = new Matrix();
				if(angle == -1)
				{
					angle = imageFillAngle;
				}
				mat.createGradientBox(width, height, angle* Math.PI/180);
				fillGraphics.beginGradientFill(GradientType.LINEAR, imageFillColors, imageFillAlphas, imageFillRatios, mat);
			}else
			{
				fillGraphics.beginFill(fillColors[0],fillAlphas[0]);
			}
		}
		
		public static function initFillStyle(fillGraphics:Graphics,width:Number,height:Number,angle:Number=-1):void
		{
			fillGraphics.lineStyle(1, SkinThemeColor.border,borderAlpha,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			if(fillColors.length>1)
			{
				var mat:Matrix;
				mat = new Matrix();
				if(angle == -1)
				{
					angle = fillAngle;
				}
				mat.createGradientBox(width, height, angle* Math.PI/180);
				fillGraphics.beginGradientFill(GradientType.LINEAR, fillColors, fillAlphas, fillRatios, mat);
			}else
			{
				fillGraphics.beginFill(fillColors[0],fillAlphas[0]);
			}
		}
		
		public static function initScrollerFillStyle(fillGraphics:Graphics,width:Number,height:Number,angle:Number=-1):void
		{
			fillGraphics.lineStyle(1, SkinThemeColor.scrollbarBorderColor,scrollbarBorderAlpha,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			if(scrollBarFillColors.length>1)
			{
				var mat:Matrix;
				mat = new Matrix();
				if(angle == -1)
				{
					angle = scrollBarFillAngle;
				}
				mat.createGradientBox(width, height, angle* Math.PI/180);
				fillGraphics.beginGradientFill(GradientType.LINEAR, scrollBarFillColors, scrollBarFillAlphas,scrollBarFillRatios, mat);
			}else
			{
				fillGraphics.beginFill(scrollBarFillColors[0],scrollBarFillAlphas[0]);
			}
		}
		
		public static function initBarFillStyle(fillGraphics:Graphics,width:Number,height:Number):void
		{
			var mat:Matrix;
			if(scrollBarBarFillColors.length>1)
			{
				mat = new Matrix();
				
				mat.createGradientBox(width, height, scrollBarBarFillAngle* Math.PI / 180);
				fillGraphics.beginGradientFill(GradientType.LINEAR, scrollBarBarFillColors, scrollBarBarFillAlphas, scrollBarBarFillRatios, mat);
			}else
			{
				fillGraphics.beginFill(scrollBarBarFillColors[0],scrollBarBarFillAlphas[0]);
			}
		}
		
		public static function initTextFillStyle(fillGraphics:Graphics,width:Number,height:Number):void
		{
			var colors:Array;
			var mat:Matrix;
			var alphas:Array;
			var ratios:Array;
			fillGraphics.lineStyle(1, SkinThemeColor.border,borderAlpha,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			if(textInputFillColors.length>1)
			{
				mat = new Matrix();
				mat.createGradientBox(width, height, textInputFillAngle * Math.PI / 180);
				fillGraphics.beginGradientFill(GradientType.LINEAR, textInputFillColors, textInputFillAlphas, textInputFillRatios, mat);
			}else
			{
				fillGraphics.beginFill(textInputFillColors[0],textInputFillAlphas[0]);
			}
		}
		
		public static function setDefaultStyles(buttonOutTextColor:String="",
												buttonOverTextColor:String="",
												buttonDownTextColor:String="",
												checkBoxTextColor:String="",
												checkBoxTextOverColor:String="",
												checkBoxLineColor:String="",
												textColor:String=""):void 
		{
			if(buttonOutTextColor != null) DefaultStyle.buttonOutTextColor = buttonOutTextColor;
			if(buttonOverTextColor != null) DefaultStyle.buttonOverTextColor = buttonOverTextColor;
			if(buttonDownTextColor != null) DefaultStyle.buttonDownTextColor = buttonDownTextColor;
			if(checkBoxTextColor != null) DefaultStyle.checkBoxTextColor = checkBoxTextColor;
			if(checkBoxTextOverColor != null) DefaultStyle.checkBoxTextOverColor = checkBoxTextOverColor;
			if(checkBoxLineColor != null) DefaultStyle.checkBoxLineColor = checkBoxLineColor;
			if(textColor != null) DefaultStyle.textColor= textColor;
		}
		
		public static function userDefaultColor(themeIndex:uint):void {
			var co:Object;
			DefaultStyle.buttonOutTextColor = "#000000";
			DefaultStyle.buttonOverTextColor = "#333333";
			DefaultStyle.buttonDownTextColor = "#000000";
			DefaultStyle.checkBoxTextColor = "#000000";
			DefaultStyle.checkBoxTextOverColor = "#666666";
			DefaultStyle.checkBoxLineColor = "#009100";
			DefaultStyle.textColor= "#000000";
			DefaultStyle.ellipse = 2;
			DefaultStyle.scrollBarRound = 2;
			StyleManager.listIndex1Alpha = 0.1;
			StyleManager.listIndex2Alpha = 0;
			StyleManager.treeIndex1Alpha = 0.05;
			StyleManager.treeIndex2Alpha = 0;
			
			DefaultStyle.buttonFilter = null;
			DefaultStyle.scrollbarFilter = null;
			DefaultStyle.buttonTextFilters = null;
			fillAlphas = [1.0,1.0,1.0,1.0];
			fillRatios = [0, 127, 128, 255];
			fillAngle = 90;
			imageFillAlphas = [1.0,1.0,1.0,1.0];
			imageFillRatios = [0, 127, 128, 255];
			imageFillAngle = 90;
			 scrollBarBarFillColors =  [0xCCCCCC, 0xFFFFFF];
			 scrollBarBarFillAngle = 0;
			 scrollBarBarFillAlphas =  [1.0, 1.0];
			 scrollBarBarFillRatios = [0, 255];
			 if(themeIndex != 80)
			 {
				 MotionSkinControl.RBG = [1,1,1];
				 MotionSkinControl.multiplier = 1.5;
			 }
			SkinThemeColor.itemOverTextColor = 0xFFFFFF;
			if (isInit == false) {
				// 粉色
				co = new Object();
				co.top = 0xfcecfc;
				co.upperMiddle = 0xfba7e1;
				co.lowerMiddle = 0xfd88d7;
				co.bottom = 0xff9ce1;
				co.border = 0xd957af;
				//FE108D
				co.defaultStyles = ["#910463","#FE108D","#910463",null,null,"#910463"];
				themColors[0] = co;
				// 石墨色
				co = new Object();
				co.top = 0xf2f6f8;
				co.upperMiddle = 0xd9e2e7;
				co.lowerMiddle = 0xb8c9d2;
				co.bottom = 0xdbeaf4;
				co.border = 0x9db0bc;
				co.defaultStyles = ["#5a717f","#5a717f","#5a717f"];
				co.itemOverTextColor = 0x000000;
				themColors[1] = co;
				// 石墨银
				co = new Object();
				co.top = 0xf8f9fa;
				co.upperMiddle = 0xe6ecef;
				co.lowerMiddle = 0xd8dee3;
				co.bottom = 0xf2f5f7;
				co.border = 0xadb9c2;
				co.defaultStyles = ["#5a717f","#5a717f","#5a717f"];
				co.itemOverTextColor = 0x000000;
				themColors[2] = co;
				// 银灰
				co = new Object();
				co.top = 0xfefefe;
				co.upperMiddle = 0xf1f1f1;
				co.lowerMiddle = 0xe4e4e4;
				co.bottom = 0xf4f4f4;
				co.border = 0xb3b3b3;
				co.defaultStyles = ["#555555","#000000","#555555"];
				co.itemOverTextColor = 0x009100;
				themColors[3] = co;
				// 渐变青蓝色
				co = new Object();
				co.top = 0xd8f9ff;
				co.upperMiddle = 0xafeefc;
				co.lowerMiddle = 0xafeefc;
				co.bottom = 0x9ae7fa;
				co.border = 0x499eb3;
				co.itemOverTextColor = 0x000000;
				themColors[4] = co;
				// 渐变黄色
				co = new Object();
				co.top = 0xf4eb87;
				co.upperMiddle = 0xf6ca47;
				co.lowerMiddle = 0xf6ca47;
				co.bottom = 0xfdb335;
				co.border = 0xb1770b;
				co.defaultStyles = ["#714a00","#714a00","#714a00",null,null,"#714a00"];
				themColors[5] = co;
				// 渐变褐蓝色
				co = new Object();
				co.top = 0xcde0ec;
				co.upperMiddle = 0xa7c5db;
				co.lowerMiddle = 0xa7c5db;
				co.bottom = 0x84adcc;
				co.border = 0x406e90;
				co.defaultStyles = ["#222222","#000000","#555555",null,null,"#000000"];
				themColors[6] = co;
				// win7 蓝
				co = new Object();
				co.top = 0xFFFFFF;
				co.upperMiddle = 0xDAF0FC;
				co.lowerMiddle = 0xB9E3FA;
				co.bottom = 0xB9E3FA;
				co.border = 0x3C7FB1;
				co.defaultStyles = ["#222222","#006f08","#555555"];
				co.itemOverTextColor = 0x000000;
				themColors[7] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xeaefb4;
				co.upperMiddle = 0xe6ecac;
				co.lowerMiddle = 0xe6ecac;
				co.bottom = 0xe2e9a1;
				co.border = 0x878d59;
				co.itemOverTextColor = 0x000000;
				themColors[8] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xfe8376;
				co.upperMiddle = 0xe94b43;
				co.lowerMiddle = 0xe94b43;
				co.bottom = 0xd00605;
				co.border = 0xbb0500;
				co.defaultStyles = ["#FFFFFF","#000000","#EEEEEE",null,null,"#FFFFFF"];
				themColors[9] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xfe1900;
				co.upperMiddle = 0xe90e00;
				co.lowerMiddle = 0xe90e00;
				co.bottom = 0xd00100;
				co.border = 0xbb0500;
				co.defaultStyles = ["#FFFFFF","#EEEEEE","#EEEEEE",null,null,"#FFFFFF"];
				themColors[10] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xf3f9fa;
				co.upperMiddle = 0xd0e9ef;
				co.lowerMiddle = 0xd0e9ef;
				co.bottom = 0xafdae4;
				co.border = 0x77a0ab;
				co.itemOverTextColor = 0x000000;
				themColors[11] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xfcd8d1;
				co.upperMiddle = 0xff593e;
				co.lowerMiddle = 0xea300d;
				co.bottom = 0xfce1dc;
				co.border = 0xbb2d00;
				co.defaultStyles = ["#000000","#000000","#EEEEEE",null,null,"#000000"];
				co.itemOverTextColor = 0x000000;
				themColors[12] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xf5c8c0;
				co.upperMiddle = 0xea7a67;
				co.lowerMiddle = 0xee3f19;
				co.bottom = 0xf77727;
				co.border = 0xbb2d00;
				co.defaultStyles = ["#660000","#000000","#EEEEEE",null,null,"#FFFFFF"];
				themColors[13] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xa7de7e;
				co.upperMiddle = 0x62c51a;
				co.lowerMiddle = 0x5ec314;
				co.bottom = 0x87d24f;
				co.border = 0x419b00;
				themColors[14] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xacb9bc;
				co.upperMiddle = 0x737c79;
				co.lowerMiddle = 0x0a0e0a;
				co.bottom = 0x0a0809;
				co.border = 0x000000;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[15] = co;
				// 黄绿色，纯色
				co = new Object();
				co.top = 0xfdfee7;
				co.upperMiddle = 0xeaedd3;
				co.lowerMiddle = 0xeaedd3;
				co.bottom = 0xd8ddc1;
				co.border = 0xbdc1a3;
				co.defaultStyles = ["#555842","#555842","#555842",null,null,"#555842"];
				co.itemOverTextColor = 0x000000;
				themColors[16] = co;
				// 青蓝色，渐变
				co = new Object();
				co.top = 0x95def5;
				co.upperMiddle = 0x4dc7ed;
				co.lowerMiddle = 0x4dc7ed;
				co.bottom = 0x0bb3e7;
				co.border = 0x089dcb;
				themColors[17] = co;
				// 蓝色，渐变
				co = new Object();
				co.top = 0xb1e0ff;
				co.upperMiddle = 0x8ccbfd;
				co.lowerMiddle = 0x8ccbfd;
				co.bottom = 0x69b8fc;
				co.border = 0x438ece;
				co.defaultStyles = ["#225580","#225580","#225580",null,null,"#225580"];
				themColors[18] = co;
				// 橙色，渐变
				co = new Object();
				co.top = 0xffa341;
				co.upperMiddle = 0xff8c22;
				co.lowerMiddle = 0xff8c22;
				co.bottom = 0xff7704;
				co.border = 0xc95d00;
				co.defaultStyles = ["#703500","#703500","#703500",null,null,"#FFFFFF"];
				themColors[19] = co;
				// 草绿色，渐变
				co = new Object();
				co.top = 0xcbe987;
				co.upperMiddle = 0xb8d96f;
				co.lowerMiddle = 0xb8d96f;
				co.bottom = 0xa6ca58;
				co.border = 0x87a93e;
				co.defaultStyles = ["#507500","#507500","#507500",null,null,"#507500"];
				themColors[20] = co;
				// 粉红色，渐变
				co = new Object();
				co.top = 0xfeb9b9;
				co.upperMiddle = 0xfe8b8c;
				co.lowerMiddle = 0xfe8b8c;
				co.bottom = 0xff6061;
				co.border = 0xd31a1c;
				co.defaultStyles = ["#640202","#FFFFFF","#640202",null,null,"#FFFFFF"];
				themColors[21] = co;
				// 灰色，渐变
				co = new Object();
				co.top = 0xededed;
				co.upperMiddle = 0xdbdbdb;
				co.lowerMiddle = 0xdbdbdb;
				co.bottom = 0xcecece;
				co.border = 0xaeaeae;
				co.defaultStyles = ["#333333","#333333","#333333",null,null,"#FFFFFF"];
				themColors[22] = co;
				// 墨绿色，渐变
				co = new Object();
				co.top = 0x617b4b;
				co.upperMiddle = 0x405c2a;
				co.lowerMiddle = 0x405c2a;
				co.bottom = 0x223e0b;
				co.border = 0x25410e;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[23] = co;
				// 金黄色，渐变
				co = new Object();
				co.top = 0xf6e5af;
				co.upperMiddle = 0xf8d14b;
				co.lowerMiddle = 0xf8d14b;
				co.bottom = 0xef981d;
				co.border = 0xd27d00;
				co.defaultStyles = ["#764900","#764900","#764900",null,null,"#764900"];
				themColors[24] = co;
				// 淡蓝色，水晶
				co = new Object();
				co.top = 0xe0f3fa;
				co.upperMiddle = 0xd9f0fc;
				co.lowerMiddle = 0xb8e2f6;
				co.bottom = 0xb6dffc;
				co.border = 0x83bbd9;
				co.itemOverTextColor = 0x009100;
				themColors[25] = co;
				// 水蓝色，水晶
				co = new Object();
				co.top = 0xb3dced;
				co.upperMiddle = 0x76d0ef;
				co.lowerMiddle = 0x21b4e2;
				co.bottom = 0xb9fcff;
				co.border = 0x15a4d0;
				co.defaultStyles = ["#00546e","#00546e","#00546e",null,null,"#00546e"];
				co.itemOverTextColor = 0x000000;
				themColors[26] = co;
				// 亮灰蓝色，水晶
				co = new Object();
				co.top = 0xf7f9fb;
				co.upperMiddle = 0xe6ebef;
				co.lowerMiddle = 0xe6ebef;
				co.bottom = 0xd8e1e6;
				co.border = 0x90a7bf;
				co.itemOverTextColor = 0x009100;
				themColors[27] = co;
				// 粉色，渐变
				co = new Object();
				co.top = 0xff5bb0;
				co.upperMiddle = 0xf72f96;
				co.lowerMiddle = 0xf72f96;
				co.bottom = 0xf0057f;
				co.border = 0xc70067;
				co.defaultStyles = ["#FFFFFF","#fffc00","#EEEEEE",null,null,"#FFFFFF"];
				themColors[28] = co;
				// 亮白色，渐变
				co = new Object();
				co.top = 0xffffff;
				co.upperMiddle = 0xfefefe;
				co.lowerMiddle = 0xfefefe;
				co.bottom = 0xf0f0f0;
				co.border = 0xbdbcbd;
				co.itemOverTextColor = 0x009100;
				themColors[29] = co;
				// acebook蓝，纯色
				co = new Object();
				co.top = 0x356aa0;
				co.upperMiddle = 0x356aa0;
				co.lowerMiddle = 0x356aa0;
				co.bottom = 0x356aa0;
				co.border = 0x174574;
				co.defaultStyles = ["#FFFFFF","#EEEEEE","#EEEEEE",null,null,"#FFFFFF"];
				themColors[30] = co;
				// facebook蓝，纯色
				co = new Object();
				co.top = 0x2c539d;
				co.upperMiddle = 0x284b92;
				co.lowerMiddle = 0x284b92;
				co.bottom = 0x244487;
				co.border = 0x00236f;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[31] = co;
				// 蓝色，水晶
				co = new Object();
				co.top = 0xb4e0fc;
				co.upperMiddle = 0x91c0f1;
				co.lowerMiddle = 0x6ba8e5;
				co.bottom = 0xabe4fd;
				co.border = 0x3c81c4;
				co.defaultStyles = ["#01396a","#034a87","#000000",null,null,"#f4ffe0"];
				co.itemOverTextColor = 0x01396a;
				themColors[32] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0x49a514;
				co.upperMiddle = 0x26990a;
				co.lowerMiddle = 0x26990a;
				co.bottom = 0x048d01;
				co.border = 0x047700;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[33] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xfdfdfb;
				co.upperMiddle = 0xd5ddb7;
				co.lowerMiddle = 0xd5ddb7;
				co.bottom = 0xb0c078;
				co.border = 0xb1c179;
				co.defaultStyles = ["#576626","#576626","#576626",null,null,"#576626"];
				themColors[34] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xfffef8;
				co.upperMiddle = 0xf8ec98;
				co.lowerMiddle = 0xf8ec98;
				co.bottom = 0xf2dc3f;
				co.border = 0xceb70d;
				co.itemOverTextColor = 0x009100;
				themColors[35] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xfc83fb;
				co.upperMiddle = 0xf361f4;
				co.lowerMiddle = 0xf361f4;
				co.bottom = 0xec41ef;
				co.border = 0xb211b0;
				themColors[36] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xa2d940;
				co.upperMiddle = 0xa2d64f;
				co.lowerMiddle = 0x80c217;
				co.bottom = 0x7dbe0b;
				co.border = 0x5b9400;
				co.defaultStyles = ["#006010","#006010","#EEEEEE",null,null,"#FFFFFF"];
				themColors[37] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xa4ccdd;
				co.upperMiddle = 0x4c80b0;
				co.lowerMiddle = 0x4c80b0;
				co.bottom = 0x27578e;
				co.border = 0x1e5288;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[38] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xffc477;
				co.upperMiddle = 0xfdb14e;
				co.lowerMiddle = 0xfdb14e;
				co.bottom = 0xfb9f28;
				co.border = 0xcd7708;
				themColors[39] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xffffff;
				co.upperMiddle = 0xcac9c9;
				co.lowerMiddle = 0xcac9c9;
				co.bottom = 0x9c9a9a;
				co.border = 0xbebebe;
				co.defaultStyles = ["#6f6654","#6f6654","#6f6654",null,null,"#6f6654"];
				themColors[40] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xffffff;
				co.upperMiddle = 0x000000;
				co.lowerMiddle = 0x000000;
				co.bottom = 0x000000;
				co.border = 0x000000;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[41] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xddeefe;
				co.upperMiddle = 0xb7d4ed;
				co.lowerMiddle = 0xb7d4ed;
				co.bottom = 0x9bc1e0;
				co.border = 0x6990b3;
				themColors[42] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xfdfeff;
				co.upperMiddle = 0xe1f1fb;
				co.lowerMiddle = 0xe1f1fb;
				co.bottom = 0xc6e6f7;
				co.border = 0xa6d0e7;
				co.itemOverTextColor = 0x000000;
				themColors[43] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xeef8ff;
				co.upperMiddle = 0xc4e8ff;
				co.lowerMiddle = 0xc4e8ff;
				co.bottom = 0xa5ddff;
				co.border = 0x7db5de;
				co.itemOverTextColor = 0x000000;
				themColors[44] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xfbffff;
				co.upperMiddle = 0xdafdff;
				co.lowerMiddle = 0xdafdff;
				co.bottom = 0xb6dcf6;
				co.border = 0x7db5de;
				co.itemOverTextColor = 0x000000;
				themColors[45] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xccdae5;
				co.upperMiddle = 0x94a3ad;
				co.lowerMiddle = 0x94a3ad;
				co.bottom = 0x607179;
				co.border = 0x5e6f77;
				themColors[46] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xd5fe64;
				co.upperMiddle = 0xaaf432;
				co.lowerMiddle = 0xaaf432;
				co.bottom = 0x7fe51e;
				co.border = 0x467f00;
				co.defaultStyles = ["#037600","#037600","#037600",null,null,null];
				co.itemOverTextColor = 0x037600;
				themColors[47] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xd1deed;
				co.upperMiddle = 0xbfd1ea;
				co.lowerMiddle = 0xa6c0e3;
				co.bottom = 0xb7ceed;
				co.border = 0x5b79a3;
				themColors[48] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xc5def5;
				co.upperMiddle = 0x0a77d5;
				co.lowerMiddle = 0x0a77d5;
				co.bottom = 0x7db6e8;
				co.border = 0x157dd7;
				themColors[49] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0x4c4c4c;
				co.upperMiddle = 0x4c4c4c;
				co.lowerMiddle = 0x000000;
				co.bottom = 0x000000;
				co.border = 0x000000;
				co.defaultStyles = ["#fdfa00","#FFFFFF","#EEEEEE",null,null,"#FFFFFF"];
				themColors[50] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0x743821;
				co.upperMiddle = 0xfbd8c5;
				co.lowerMiddle = 0xfbd8c5;
				co.bottom = 0xa65c33;
				co.border = 0xad734d;
				themColors[51] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0x5da8f0;
				co.upperMiddle = 0x56a4ee;
				co.lowerMiddle = 0x358def;
				co.bottom = 0x206ee1;
				co.border = 0x1f54bc;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[52] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0x00b7e9;
				co.upperMiddle = 0x00aedc;
				co.lowerMiddle = 0x00aedc;
				co.bottom = 0x00a0c6;
				co.border = 0x0087ae;
				themColors[53] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xe46fe6;
				co.upperMiddle = 0xc75dc5;
				co.lowerMiddle = 0xc75dc5;
				co.bottom = 0xac4ba7;
				co.border = 0x833692;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[54] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xfdfdfd;
				co.upperMiddle = 0xdbdce1;
				co.lowerMiddle = 0xdbdce1;
				co.bottom = 0xd2d3da;
				co.border = 0xb2b2c4;
				co.itemOverTextColor = 0x009100;
				themColors[55] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xeae7f8;
				co.upperMiddle = 0xd9d1ef;
				co.lowerMiddle = 0xcdc6ec;
				co.bottom = 0xc1bfea;
				co.border = 0xb8b2db;
				co.defaultStyles = ["#625c96","#7770b6","#625c96",null,null,"#4e4982"];
				co.itemOverTextColor = 0x000000;
				themColors[56] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xf5fee0;
				co.upperMiddle = 0xcde668;
				co.lowerMiddle = 0xcde668;
				co.bottom = 0xb8df30;
				co.border = 0x9fc120;
				co.itemOverTextColor = 0x000000;
				themColors[57] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xd4cda5;
				co.upperMiddle = 0xc9c191;
				co.lowerMiddle = 0xc9c191;
				co.bottom = 0xb9af74;
				co.border = 0xb4ac7e;
				themColors[58] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xa70329;
				co.upperMiddle = 0x8b0221;
				co.lowerMiddle = 0x8b0221;
				co.bottom = 0x70001a;
				co.border = 0x7b0c26;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[59] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xf8fcf6;
				co.upperMiddle = 0xeff6e8;
				co.lowerMiddle = 0xeff6e8;
				co.bottom = 0xf4f9ef;
				co.border = 0xdde7d4;
				co.itemOverTextColor = 0x000000;
				themColors[60] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xf9ffff;
				co.upperMiddle = 0xf0f8fe;
				co.lowerMiddle = 0xe4f1fc;
				co.bottom = 0xd0e2f3;
				co.border = 0x8daac7;
				co.defaultStyles = ["#214c73","#2f5b84","#000000",null,null,"#009100"];
				co.itemOverTextColor = 0x009100;
				themColors[61] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xccedff;
				co.upperMiddle = 0xc3e6fe;
				co.lowerMiddle = 0x9dd2fa;
				co.bottom = 0x8fcbff;
				co.border = 0x4584b8;
				themColors[62] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xed5c5c;
				co.upperMiddle = 0xd03c3c;
				co.lowerMiddle = 0xd03c3c;
				co.bottom = 0xb51d1d;
				co.border = 0xb51d1d;
				co.defaultStyles = ["#FFFFFF","#000000","#FFFFFF",null,null,"#FFFFFF"];
				themColors[63] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0x53aa20;
				co.upperMiddle = 0x8bcc63;
				co.lowerMiddle = 0x56aa1d;
				co.bottom = 0x75be1b;
				co.border = 0x4d882b;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[64] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xedc0c5;
				co.upperMiddle = 0xd45361;
				co.lowerMiddle = 0xba2636;
				co.bottom = 0xea818c;
				co.border = 0xb42232;
				co.defaultStyles = ["#550009","#FFFFFF","#EEEEEE",null,null,"#FFFFFF"];
				themColors[65] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xf1dfc3;
				co.upperMiddle = 0xc4a26d;
				co.lowerMiddle = 0xb68d4c;
				co.bottom = 0xeddbbd;
				co.border = 0xb38c4f;
				co.defaultStyles = ["#593e13","#593e13","#593e13",null,null,"#593e13"];
				co.itemOverTextColor = 0x000000;
				themColors[66] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xebb19a;
				co.upperMiddle = 0x8c3310;
				co.lowerMiddle = 0x782504;
				co.bottom = 0xb66444;
				co.border = 0x853212;
				co.defaultStyles = ["#FFFFFF","#FFFFFF","#FFFFFF",null,null,"#FFFFFF"];
				themColors[67] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xfdc9ad;
				co.upperMiddle = 0xf2793a;
				co.lowerMiddle = 0xea5506;
				co.bottom = 0xfa925a;
				co.border = 0xcf4700;
				themColors[68] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xb4e0fc;
				co.upperMiddle = 0x91c0f1;
				co.lowerMiddle = 0x6ba8e5;
				co.bottom = 0xe1fffc;
				co.border = 0x3c81c4;
				co.defaultStyles = ["#01396a","#0056a2","#004a71",null,null,"#009900"];
				themColors[69] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xfceab9;
				co.upperMiddle = 0xfccf56;
				co.lowerMiddle = 0xf8b500;
				co.bottom = 0xfbdb87;
				co.border = 0xdea303;
				themColors[70] = co;
				// 绿色，渐变
				co = new Object();
				co.top = 0xF0F0F0;
				co.upperMiddle = 0xEAEAEA;
				co.lowerMiddle = 0xEAEAEA;
				co.bottom = 0xE6E6E6;
				co.border = 0xC4C4C4;
				themColors[80] = co;
				
				isInit = true;
			}
			if(themeIndex<71 || themeIndex == 80)
			{
				co = themColors[themeIndex];
				SkinThemeColor.border = co.border;
				SkinThemeColor.top = co.top;
				SkinThemeColor.upperMiddle = co.upperMiddle;
				SkinThemeColor.lowerMiddle = co.lowerMiddle;
				SkinThemeColor.bottom = co.bottom;
				if(themeIndex != 69)
				{
					SkinThemeColor.itemOverColor = SkinThemeColor.bottom;
				}else
				{
					SkinThemeColor.itemOverColor = 0x3c81c4;
				}
				if(co.itemOverTextColor != null)
				{
					SkinThemeColor.itemOverTextColor = co.itemOverTextColor;
				}
				if (co.defaultStyles is Array) {
					setDefaultStyles(co.defaultStyles[0], co.defaultStyles[1],  co.defaultStyles[2],  co.defaultStyles[3],  co.defaultStyles[4],  co.defaultStyles[5],  co.defaultStyles[6]);
				}
				DefaultStyle.windowButtonOverFilter = [new GlowFilter(SkinThemeColor.border,1,4,4,0.7,1)];
				fillColors = [SkinThemeColor.top, SkinThemeColor.upperMiddle, SkinThemeColor.lowerMiddle, SkinThemeColor.bottom];
				if(themeIndex==2)
				{
					fillColors = [0xFFFFFF, 0xAAAAAA];
					fillAlphas = [1,1];
					fillRatios = [0,255];
					fillAngle = 90;
					borderAlpha = 0.5;
					scrollBarFillColors = fillColors;
					scrollBarFillAlphas = fillAlphas;
					scrollBarFillRatios = fillRatios;
					scrollBarFillAngle = fillAngle;
					DefaultStyle.buttonOverTextColor = "#000000";
					arrowFillColor = 0x666666;
				}
				imageFillColors = fillColors;
				imageFillAlphas = [0.3,0.3,0.3,0.3];
				imageBorderColor = border;
				imageBorderAlpha = 0.5;
				textInputFillColors = [fillColors[0],0xFFFFFF];
				scrollBarBarFillColors = [fillColors[0],0xFFFFFF];
				listBackgroundFillColors = [SkinThemeColor.itemOverColor];
				DefaultStyle.listBackgroundEllipse = 0;
				scrollBarShapeColor1 = border;
				scrollbarBorderColor = border;
				scrollbarBorderAlpha = 1.0;
				scrollBarShapeAlpha1 = 0.85;
				scrollBarShapeColor2 = 0xFFFFFF;
				scrollBarShapeAlpha2 = 0.2;
				scrollBarFillColors = fillColors;
				scrollBarFillAngle = fillAngle;
				scrollBarFillRatios = fillRatios;
				scrollBarFillAlphas = fillAlphas;
				arrowFillColor = border;
				if(themeIndex == 80)
				{
					DefaultStyle.ellipse = 0;
					DefaultStyle.scrollBarRound = 0;
					SkinThemeColor.itemOverColor = 0x6EB3F6;
					StyleManager.listIndex1Alpha = 0;
					StyleManager.listIndex2Alpha = 0;
					StyleManager.treeIndex1Alpha = 0;
					StyleManager.treeIndex2Alpha = 0;
					scrollBarShapeAlpha1 = 0;
					scrollBarShapeAlpha2 = 0;
					StyleManager.treeOpenIconOverFilter = [new GlowFilter(0xFFFFFF,1,6,6,2,1)];
					scrollBarFillColors=[0xCCCCCC];
					scrollbarBorderColor = 0x999999;
					listBackgroundFillColors = [SkinThemeColor.itemOverColor];
				}else
				{
					MotionSkinControl.RBG = [1,1,1];
					MotionSkinControl.multiplier =1.5;
				}
			}else
			{
				MotionSkinControl.RBG = [1,1,1];
				MotionSkinControl.multiplier =1.5;
//				MotionSkinControl.multiplier = 2.5;
				arrowFillColor = 0x000000;
				DefaultStyle.checkBoxLineColor = "#990000";
				fillAlphas = [1,1,1,1];
				switch(themeIndex)
				{
					case 71:
						DefaultStyle.ellipse = 0;
						fillColors = [0xEFEFEF];
						border = 0xAAAAAA;
						MotionSkinControl.multiplier =0.5;
						DefaultStyle.scrollBarRound = 0;
						scrollbarBorderColor = 0x999999;
						scrollBarBarFillColors = [0xDFDFDF]
						scrollBarFillColors =  [0xD1D1D1];
						textInputFillColors= [0xEEEEEE,0xFFFFFF]
						SkinThemeColor.itemOverColor = 0x7991B0;
						listBackgroundFillColors = [SkinThemeColor.itemOverColor];
						scrollBarShapeAlpha1 = 0;
						scrollBarShapeColor2 = 0x333333;
						scrollBarShapeAlpha2 = 0.3;
						break;
					
					case 72:
						DefaultStyle.ellipse = 0;
						fillColors = [0xEE8787];
						border = 0xB66767;
						DefaultStyle.scrollBarRound = 0;
						scrollbarBorderColor = 0xB66767;
						scrollBarBarFillColors = [0xEE8787]
						SkinThemeColor.itemOverColor = 0x7991B0;
						textInputFillColors= [0xFBE1E1]
						SkinThemeColor.itemOverColor = 0xE44949;
						listBackgroundFillColors = [SkinThemeColor.itemOverColor];
						scrollBarShapeAlpha1 = 0;
						scrollBarShapeColor2 = 0x000000;
						scrollBarShapeAlpha2 = 0.3;
						scrollBarFillColors =  [0xEE8787];
						break;
					
					case 73:
						DefaultStyle.ellipse = 0;
						fillColors = [0xF0F0F0];
						border = 0xA0A0A0;
						DefaultStyle.scrollBarRound = 0;
						scrollbarBorderColor = 0x999999;
						scrollBarBarFillColors = [0xDFDFDF]
						scrollBarFillColors =  [0xD1D1D1];
						textInputFillColors= [0xEEEEEE,0xFFFFFF]
						SkinThemeColor.itemOverColor = 0x7991B0;
						listBackgroundFillColors = [SkinThemeColor.itemOverColor];
						scrollBarShapeAlpha1 = 0;
						scrollBarShapeColor2 = 0x333333;
						scrollBarShapeAlpha2 = 0.3;
						break;
					
					case 74:
						fillColors = [0xFCECFC,0xFBA7E1,0xFD88D7,0xFF9CE1];
						fillAlphas = [1,1,1,1];
						fillAngle = 45;
						fillRatios = [0,115,128,255];
						imageFillAngle = 45;
						border = 0xd957af;
						listBackgroundFillColors = [0xFF9CE1];
						DefaultStyle.checkBoxLineColor = "#910463";
						arrowFillColor = border;
						break;
					
					case 75:
						fillColors = [0xFCECFC,0xFBA7E1,0xFD88D7,0xFF9CE1];
						fillAlphas = [1,1,1,1];
						fillAngle = -45;
						fillRatios = [0,115,128,255];
						imageFillAngle = -45;
						border = 0xd957af;
						listBackgroundFillColors = [0xFF9CE1];
						DefaultStyle.checkBoxLineColor = "#910463";
						arrowFillColor = border;
						break;
					
					case 76:
						fillColors = [0xFCECFC,0xFBA7E1,0xFD88D7,0xFF9CE1];
						fillAlphas = [1,1,1,1];
						fillAngle = 20;
						fillRatios = [0,115,128,255];
						imageFillAngle = 20;
						border = 0xd957af;
						listBackgroundFillColors = [0xFF9CE1];
						DefaultStyle.checkBoxLineColor = "#910463";
						arrowFillColor = border;
						break;
					
					case 77:
						DefaultStyle.ellipse = 0;
						DefaultStyle.scrollBarRound = 0;
						MotionSkinControl.multiplier = 0.6;
						fillColors = [0xf1f1f1,0xd5d5d5];
						fillAlphas = [1,1];
						fillAngle =90;
						fillRatios = [0,255];
						imageFillAngle = 90;
						border = 0x737373;
						listBackgroundFillColors = [0xcccccc];
						DefaultStyle.checkBoxLineColor = "#515151";
						arrowFillColor = 0x515151;
						SkinThemeColor.itemOverTextColor = 0x000000;
						DefaultStyle.buttonTextFilters = [ new DropShadowFilter(1,90,0xFFFFFF,1,1,1,0.55,1)];
						break;
					
					case 78:
						DefaultStyle.ellipse = 0;
						DefaultStyle.scrollBarRound = 0;
						MotionSkinControl.multiplier = 0.2;
						fillColors = [0xd4d0c8];
						fillAlphas = [1];
						fillAngle =90;
						fillRatios = [0,255];
						imageFillAngle = 90;
						border = 0x808080;
						listBackgroundFillColors = [0xcccccc];
						DefaultStyle.checkBoxLineColor = "#515151";
						arrowFillColor = 0x515151;
						SkinThemeColor.itemOverTextColor = 0x000000;
						DefaultStyle.buttonFilter = [new BevelFilter(1.5,45,0xFFFFFF,1,0,1,1.3,1.3,1.2)];
//						DefaultStyle.scrollbarFilter = [new BevelFilter(1.2,45,0xFFFFFF,1.5,0,1,1.5,1.5,1.2)];
						break;
				}
				scrollBarFillAlphas = fillAlphas;
				imageFillColors = fillColors;
				imageFillAlphas = [0.3,0.3,0.3,0.3];
				imageBorderColor = border;
				imageBorderAlpha = 0.5;
				DefaultStyle.windowButtonOverFilter = [new GlowFilter(SkinThemeColor.border,1,4,1.4,1.2,1)];
				if(themeIndex>73 && themeIndex <80)
				{
					scrollBarFillColors = fillColors;
					scrollBarFillAlphas = fillAlphas;
					scrollBarFillRatios = fillRatios;
					scrollBarFillAngle = fillAngle;
					scrollbarBorderColor =border;
					scrollBarShapeColor1 = border;
					textInputFillColors = [fillColors[0],0xFFFFFF];
					imageFillColors = fillColors;
					imageFillAlphas = [0.3,0.3,0.3,0.3];
					imageBorderColor = border;
					imageBorderAlpha = 0.5;
				}
			}	
			if(themeIndex == 80)
			{
				scrollBarFillColors=[0xCCCCCC];
				scrollbarBorderColor = 0xCCCCCC;
				scrollBarBarFillColors = [0xEFEFEF]
				arrowFillColor = 0x000000;
				MotionSkinControl.RBG = [0.44,0.53,0.81];
				MotionSkinControl.multiplier = 4.5;
			}
			if(themeIndex ==15 || themeIndex ==50)
			{
				arrowFillColor = 0xFFFFFF;
			}
			if(themeIndex ==47 )
			{
				listBackgroundFillColors = [0xd5fe64,0x7fe51e];
				listBackgroundFillAlphas = [1,1];
				listBackgroundFillRatios=[0,255];
				listBackgroundFillAngle = 90;
				DefaultStyle.scrollBarRound = 20;
			}
			switch(themeIndex)
			{
				case 2:
					arrowFillColor = 0x333333;
					scrollBarShapeColor1 = 0x666666;
					break;
				
				case 6:
					arrowFillColor = 0x333333;
					scrollBarShapeColor1 = 0x333333;
					break;
				
				case 9:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 10:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					scrollBarShapeAlpha2 = 0;
					break;
					
					
				case 12:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					break;
				
				
				case 13:
					arrowFillColor = 0x781d00;
					scrollBarShapeColor1 = 0x781d00;
					break;
				
				
				case 14:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
					
					
				case 17:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
					
					
				case 19:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					break;
				
				
				case 22:
					arrowFillColor = 0x666666;
					DefaultStyle.checkBoxLineColor = "#666666";
					scrollBarShapeColor1 = 0x666666;
					break;
				
				
				case 23:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
					
					
				case 26:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
					
					
				case 28:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
					
					
				case 30:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
					
					
				case 31:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
					
					
				case 32:
					arrowFillColor = 0x003466;
					scrollBarShapeColor1 = 0x003466;
					DefaultStyle.checkBoxLineColor = "#003466";
					break;
					
					
				case 33:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 34:
					arrowFillColor = 0x576626
					scrollBarShapeColor1 = 0x576626;
					DefaultStyle.checkBoxLineColor = "#576626";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 35:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					break;
				
				
				
				case 36:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				
				case 37:
					arrowFillColor = 0x275701
					scrollBarShapeColor1 = 0x275701;
					DefaultStyle.checkBoxLineColor = "#275701";
					scrollBarShapeAlpha2 = 0;
					break;
				
				case 38:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 39:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					DefaultStyle.checkBoxLineColor = "#000000";
					break;
				
				
				case 40:
					arrowFillColor = 0x5f5540
					scrollBarShapeColor1 = 0x5f5540;
					DefaultStyle.checkBoxLineColor = "#5f5540";
					scrollBarShapeAlpha2 = 0;
					break;
				
				case 41:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 46:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					DefaultStyle.checkBoxLineColor = "#000000";
					break;
				
				
				case 49:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 51:
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 52:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 53:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					DefaultStyle.checkBoxLineColor = "#000000";
					break;
				
				
				case 54:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 56:
					arrowFillColor = 0x3e3973;
					scrollBarShapeColor1 = 0x3e3973;
					DefaultStyle.checkBoxLineColor = "#3e3973";
					break;
				
				
				case 57:
					arrowFillColor = 0x005500;
					scrollBarShapeColor1 = 0x005500;
					DefaultStyle.checkBoxLineColor = "#005500";
					break;
				
				
				case 58:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					DefaultStyle.checkBoxLineColor = "#000000";
					break;
				
				
				case 59:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 63:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 64:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 65:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 66:
					arrowFillColor = 0x573b10
					scrollBarShapeColor1 = 0x573b10;
					DefaultStyle.checkBoxLineColor = "#573b10";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 67:
					arrowFillColor = 0xFFFFFF
					scrollBarShapeColor1 = 0xFFFFFF;
					DefaultStyle.checkBoxLineColor = "#FFFFFF";
					scrollBarShapeAlpha2 = 0;
					break;
				
				
				case 68:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					DefaultStyle.checkBoxLineColor = "#000000";
					break;
				
				
				case 70:
					arrowFillColor = 0x000000;
					scrollBarShapeColor1 = 0x000000;
					DefaultStyle.checkBoxLineColor = "#000000";
					break;
					
				default:
					break;
			}
		}
		
	}
}