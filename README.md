# PrintIniOS  
最近要在项目中添加打印功能，所打印的内容为HTML形式，整理了一下。  

此功能所需遵守的协议为UIPrintInteractionControllerDelegate；  
所用的类主要为UIPrintInteractionController；    
打印按钮为UIBarButtonItem，如果你设置的为Button貌似需要转换一下；  
由于我们项目中所用的html网页为公司内部的，外网不能访问，我在此替换为了百度主页，可以自行替换。  
