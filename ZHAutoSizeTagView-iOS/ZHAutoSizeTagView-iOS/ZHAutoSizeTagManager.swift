//
//  ZHAutoSizeTagManager.swift
//  ZHAutoSizeTagView-iOS
//
//  Created by 张行 on 2017/12/13.
//  Copyright © 2017年 君赏. All rights reserved.
//

import UIKit

public class ZHAutoSizeTagManager : NSObject {
	public var tagTitle:[String] = []
	public var edge:UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	public var horizontalSpance:CGFloat = 10
	public var verticalSpance:CGFloat = 10
	public var selectBackgroundColor:UIColor = #colorLiteral(red: 1, green: 0.9294117647, blue: 0.8705882353, alpha: 1)
	public var selectBoardColor:UIColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 1)
	public var selectBoardWidth:CGFloat = 0
	public var selectTextColor:UIColor = #colorLiteral(red: 1, green: 0.5411764706, blue: 0, alpha: 1)
	public var selectImage:UIImage? = UIImage(named: "zh_autosize_tag_select_icon", in: Bundle(for: ZHAutoSizeTagManager.self), compatibleWith: nil)
	public var defaultBackgroundColor:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
	public var defaultBoardColor:UIColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
	public var defaultBoardWidth:CGFloat = 1
	public var defaultTextColor:UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
	public var defaultImage:UIImage?
	public var maxLine:Int = 0
	public var cornerRadius:CGFloat = 4
	public var textFont:UIFont = UIFont.systemFont(ofSize: 12)
	public var tagHeight:CGFloat = 0
	public override init() {
		super.init()
	}
}
