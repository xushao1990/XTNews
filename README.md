XTNews
======

此工程模仿网易新闻的主视图切换模式



更新日志：

2014年05月27日

增加全局menu的开关。

2014年05月22日

增加左侧菜单示例,点击切换中间视图

2014年05月05日18:03:01

适配iOS6

2014年05月05日01:08:06

① 增加瀑布流展示的示例,支持重用

② 增加下拉刷新(尚未实现刷新数据,略有bug，慎用),增加加载更多数据

③ 完善demo中的视图切换

要点：

1、列表视图的重用

2、列表间视图切换与左右menu的切换手势并存

![image](https://raw.githubusercontent.com/xushao1990/XTNews/master/Screenshots/first.gif)
![image](https://raw.githubusercontent.com/xushao1990/XTNews/master/Screenshots/second.gif)

开发本工程为工作中处理过类似的交互，出于某些原因整理了一份此类交互的实现方式，本工程使用了大量第三方类库，慎入！

首先先感谢广大开源的作者。

1、iCarousel -> https://github.com/nicklockwood/iCarousel

  十分强大的类似ScrollView的类！提供重用视图及多种3D切换方式，为本工程的核心类库之一。
  
  列表视图的重用为此类实现。本工程内的iCarousel为1.8beta9版本，已经根据实际情况添加了某些属性以及增加了对边缘手势的检测。
  
2、RESideMenu -> https://github.com/romaonthego/RESideMenu

  左右视图切换的实现类库，核心类库之一。
  
3、SDWebImage -> https://github.com/rs/SDWebImage

  有名的图片加载类库，幸好X易新闻的图片数据比较标准，不用专门写图片下载。
  
4、CRNavigationController -> https://github.com/croberts22/CRNavigationController

  iOS7下对navigationBar的颜色改变比较特殊，此类提供了解决方案，不过我估计X易用的不是navigationBar
  
5、TopAligningLabel -> https://github.com/Baglan/MCTopAligningLabel

  X易的新闻摘要是顶部对齐的，这个Label就是做这个的
  
6、PSCollectionView -> https://github.com/ptshih/PSCollectionView

  工作中最常用的瀑布流展示的类，Thanks！本工程中的已经修复iOS7下的出现的cell点击无效的问题，不过目前还没使用到本工程中。
  
本工程的功能说明为参考另一位兄台的framework说明文件 -> https://github.com/JackTeam/XHNewsFrameworkExample

Jack十分活跃，分享了很多组件，赞一个！

## 建议

本工程目的为展示X易新闻的主界面的切换方式，为本人的实现方式，仅供大家参考。

如果有疑问或者批评建议，欢迎QQ联系我：1124672787

## 中文：   

1、嵌套在滚动视图里面的View支持重用，可以重写XTListView即可。        
2、支持快速水平滑动滚动视图。
3、完美解决滚动视图和侧滑框架的手势冲突，支持在滚动视图内部滑动打开侧滑框架        
4、支持栏目的pageControl与内容的滚动视图iCarousel的交互。

## English：    

XXX

## License

中文: 本工程 是在MIT协议下使用的，可以在LICENSE文件里面找到相关的使用协议信息.     

English: the project is acailable under the MIT license, see the LICENSE file for more information.     

=======================
## 须知       

本工程仅供学习交流使用，如侵权请告知。
