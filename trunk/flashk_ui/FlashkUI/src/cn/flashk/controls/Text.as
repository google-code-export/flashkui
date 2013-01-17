package cn.flashk.controls
{
	/**
	 * Text 组件将显示多行纯文本或 HTML 格式的文本，这些文本的对齐和大小格式可进行设置。
	 * 若要显示文本背景，请对background对象进行操作 
	 * @author flashk
	 * 
	 */
	public class Text extends Label
	{
		public function Text()
		{
			_compoWidth =300;
			_compoHeight = 200;
			wordWrap = true;
			setSize(_compoWidth,_compoHeight);
		}
	}
}