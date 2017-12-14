---
typora-copy-images-to: ipic
---

# ZHAutoSizeTagView

自动适配大小标签试图

![](/ZHAutoSizeTagView.gif)

`ZHAutoSizeTagView`是一个基于最新的 Swift4.0语言编写的标签显示控件。

类似于京东，淘宝等电商网站双11 黑五 自营等标签控件

- [x] 支持自动计算宽度
- [x] 支持自动计算高度
- [x] 支持限制行数
- [x] 支持自定义样式
- [x] 支持最新的 Swift4.0
- [x] 支持 Cocoapods
- [x] 支持 Framework 集成
- [x] 支持自动换行
- [x] 支持 Playground 预览

## 怎么安装

1. 使用 Cocoapods

   ```ruby
   pod 'ZHAutoSizeTagView'
   ```

2. 使用 Framework

   [下载最新版本](https://github.com/josercc/ZHAutoSizeTagView/releases/)

   拖拽到工程里面即可

> 如果是 OC 工程 请开始Always Embed Stadard Libraries = YES

## 使用教程

### 初始化

1. 初始化一个自动计算大小的试图

   ```swift
   let frame = CGRect(x: 20, y: 20, width: 0, height: 0)
   let tagView = ZHAutoSizeTagView(frame: frame) { (manager) in
       manager.tagTitle = ["Black Friday","11.11","Global shipping"]
   }
   ```

   ![6501285E-34BC-422E-B71E-1EBA4398105A](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-6501285E-34BC-422E-B71E-1EBA4398105A.png)

2. 初始化一个自定义宽度的试图

   ```swift
   let frame = CGRect(x: 20, y: 20, width: 200, height: 0)
   let tagView = ZHAutoSizeTagView(frame: frame) { (manager) in
       manager.tagTitle = ["Black Friday","11.11","Global shipping"]
   }
   ```

   ![619E679B-18D5-4DB9-A6C8-10D99FDF1C20](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-619E679B-18D5-4DB9-A6C8-10D99FDF1C20.png)

3. 初始化一个自定义高度试图
   ```swift
   	let frame = CGRect(x: 20, y: 20, width: 300, height: 0)
		let tagView = ZHAutoSizeTagView(frame: frame) { (manager) in
			manager.tagTitle = ["Black Friday","11.11","Global shipping"]
			manager.tagHeight = 40
		}
   ```

   ![7D37701E-C5C6-41AF-AB5C-7787EBD9008C](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-7D37701E-C5C6-41AF-AB5C-7787EBD9008C.png)

4. 设置选中状态

   ``` Swift
   // 设置选中状态按钮的背景颜色
   public var selectBackgroundColor:UIColor = #colorLiteral(red: 1, green: 0.9294117647, blue: 0.8705882353, alpha: 1)
   // 设置选中状态按钮的边框颜色
   public var selectBoardColor:UIColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 1)
   // 设置选中状态边框大小
   public var selectBoardWidth:CGFloat = 0
   // 设置选中状态的文本颜色
   public var selectTextColor:UIColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 1)
   // 设置选中状态的选中图片
   public var selectImage:UIImage? = UIImage(named: "zh_autosize_tag_select_icon", in: Bundle(for: ZHAutoSizeTagManager.self), compatibleWith: nil)
   ```

   ![113CB191-6D0D-4619-9C77-936B57EB1D9B](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-113CB191-6D0D-4619-9C77-936B57EB1D9B.png)

5. 设置默认状态的样式

   ``` Swift
   // 设置默认状态按钮的背景颜色
   public var defaultBackgroundColor:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
   // 设置默认状态边框颜色
   public var defaultBoardColor:UIColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
   // 设置默认状态的边框大小
   public var defaultBoardWidth:CGFloat = 1
   // 设置默认状态的文本颜色
   public var defaultTextColor:UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
   // 设置默认状态的图标
   public var defaultImage:UIImage?
   ```

   ![BE630CDF-E4D1-4569-9412-46DEE20F7F01](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-BE630CDF-E4D1-4569-9412-46DEE20F7F01.png)

6. 设置标签数量

   ```swift
   public var tagTitle:[String] = []
   ```

   ![EEF8C785-FDE1-4325-867D-F6D36D1CFCC5](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-EEF8C785-FDE1-4325-867D-F6D36D1CFCC5.png)

   ![9D3C1D1B-003C-43F7-BA5E-65DA181A6191](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-9D3C1D1B-003C-43F7-BA5E-65DA181A6191.png)

7. 设置四周的边距

   ```Swift
   public var edge:UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
   ```

   ![A68E90BF-6DE7-4730-ADF9-233408E47B4C](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-A68E90BF-6DE7-4730-ADF9-233408E47B4C.png)

   ![68D3F7B9-76E3-4267-9D0C-4C570FDB4D2C](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-68D3F7B9-76E3-4267-9D0C-4C570FDB4D2C.png)

8. 设置横向间距

   ```swift
   public var horizontalSpance:CGFloat = 10
   ```

   ![6D86E363-1D68-4A37-A7F9-9186A4484748](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-6D86E363-1D68-4A37-A7F9-9186A4484748.png)

9. 设置纵向边距

   ```swift
   public var verticalSpance:CGFloat = 10
   ```

   ![95AD53B0-E7EC-4E7F-ADD4-3AD4106AEF79](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-95AD53B0-E7EC-4E7F-ADD4-3AD4106AEF79.png)

10. 设置最大显示行数 0不限制

   ```swift
   public var maxLine:Int = 0
   ```

   ![BD65F921-B069-4DBD-9493-49D1A83CD5B4](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-BD65F921-B069-4DBD-9493-49D1A83CD5B4.png)

11. 设置圆角大小

    ```swift
    public var cornerRadius:CGFloat = 4
    ```

    ![41664BC0-7B7F-4B4A-8A30-57F006A80C90](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-41664BC0-7B7F-4B4A-8A30-57F006A80C90.png)

    ![F6000E46-2C98-4277-8ACD-4A090C4D264D](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-F6000E46-2C98-4277-8ACD-4A090C4D264D.png)

12. 设置字体大小

    ```swift
    public var textFont:UIFont = UIFont.systemFont(ofSize: 12)
    ```

    ![4CF55BBC-9EEC-45B1-B312-E62288741AE8](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-4CF55BBC-9EEC-45B1-B312-E62288741AE8.png)

    ![6A7081A6-2E13-4769-959E-1518DD08EE9F](http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-6A7081A6-2E13-4769-959E-1518DD08EE9F.png)

上面就是 ZHAutoSizeTagView 的全部教程，使用有问题可以提出来。我会看到之后尽快的修复。
