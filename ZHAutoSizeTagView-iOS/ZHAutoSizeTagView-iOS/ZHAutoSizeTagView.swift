//
//  File.swift
//  ZHAutoSizeTagView-iOS
//
//  Created by 张行 on 2017/12/13.
//  Copyright © 2017年 君赏. All rights reserved.
//

import UIKit

@objc public class ZHAutoSizeTagView: UIView {
	var manager:ZHAutoSizeTagManager?
	@objc public var monitorTagButtonClick:((_ index:Int) -> Void)?
	var currentLineNumber:Int = 0
	var tagButtons:[UIButton] = []
	@objc public init(frame:CGRect, block:(_ manager:ZHAutoSizeTagManager) -> Void) {
		let configManager = ZHAutoSizeTagManager()
		block(configManager)
		self.manager = configManager
		super.init(frame:frame)
		drawTagViews()
	}

	func drawTagViews() {
		guard let manager = self.manager else {
			return
		}
		var startX = manager.edge.left
		var startY = manager.edge.top
		var height:CGFloat = 0;
		var width:CGFloat = 0
		for e in manager.tagTitle.enumerated() {
			let button = creatTagView(title: e.element, manager: manager)
			tagButtons.append(button)
			button.tag = e.offset
			button.frame = getButtonIntrinsicFrame(intrinsicContentSize: button.intrinsicContentSize, startX: &startX, startY: &startY, manager: manager)
//			print(startX,startY)
			self.addSubview(button)
//			print(currentLineNumber)
			let stopDrawTagView = manager.maxLine > 0 && currentLineNumber == manager.maxLine
			if e.offset == manager.tagTitle.count - 1 || stopDrawTagView {
				height = button.frame.origin.y + button.frame.size.height + manager.edge.bottom
				width = button.frame.origin.x + button.frame.size.width + manager.edge.right
			}
			if stopDrawTagView {
				break
			}
		}
		if self.frame.size.width > width {
			width = self.frame.size.width
		}
		if self.frame.size.height > height {
			height = self.frame.size.height
		}
		self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: height)
	}

	func getButtonIntrinsicFrame(intrinsicContentSize:CGSize, startX:inout CGFloat, startY: inout CGFloat, manager:ZHAutoSizeTagManager) -> CGRect {
		var buttonFrame:CGRect = .zero
		let maxWidth = self.bounds.size.width - manager.edge.right
		var buttonWidth = intrinsicContentSize.width + 30
		let x = startX + buttonWidth
		var buttonHeight = intrinsicContentSize.height
		if buttonHeight <  manager.tagHeight{
			buttonHeight = manager.tagHeight
		}
		if maxWidth > 0 && x > maxWidth {
			if startX == manager.edge.left {
				buttonWidth = maxWidth - manager.edge.left
				buttonFrame = CGRect(x: startX, y: startY, width: buttonWidth, height: buttonHeight)
				startX = manager.edge.left
				startY += buttonHeight + manager.verticalSpance
				currentLineNumber += 1
			} else {
				startX = manager.edge.left
				startY += buttonHeight + manager.verticalSpance
				buttonFrame = getButtonIntrinsicFrame(intrinsicContentSize:intrinsicContentSize, startX:&startX , startY:&startY, manager:manager)
				currentLineNumber += 1
			}
		} else {
			buttonFrame =  CGRect(x: startX, y: startY, width: buttonWidth, height: buttonHeight)
			startX += buttonWidth + manager.horizontalSpance
		}
		return buttonFrame
	}

	func creatTagView(title:String, manager:ZHAutoSizeTagManager) -> UIButton {
		let button = UIButton(type: .custom)
		button.setTitle(title, for: .normal)
		button.titleLabel?.font = manager.textFont
		button.layer.masksToBounds = true
		button.layer.cornerRadius = manager.cornerRadius
		button.titleLabel?.lineBreakMode = .byTruncatingTail
		setButtonStyle(button: button, manager: manager)
		button.addTarget(self, action: #selector(self.tagButtonClick(sender:)), for: .touchUpInside)
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
		return button
	}

	@objc func tagButtonClick(sender:UIButton) {
		sender.isSelected = !sender.isSelected
		if let manager = self.manager {
			for button in tagButtons {
				if button != sender {
					button.isSelected = false
				}
				setButtonStyle(button: button, manager: manager)
			}
		}
		guard let monitorTagButtonClick = self.monitorTagButtonClick else {
			return
		}
		monitorTagButtonClick(sender.tag)
	}

	func setButtonStyle(button:UIButton, manager:ZHAutoSizeTagManager) {
		button.backgroundColor = button.isSelected ? manager.selectBackgroundColor : manager.defaultBackgroundColor
		button.setTitleColor(button.isSelected ? manager.selectTextColor : manager.defaultTextColor, for: .normal)
		button.layer.borderWidth = button.isSelected ? manager.selectBoardWidth : manager.defaultBoardWidth
		button.layer.borderColor = button.isSelected ? manager.selectBoardColor.cgColor : manager.defaultBoardColor.cgColor
		button.setImage(button.isSelected ? manager.selectImage : manager.defaultImage, for: .selected)

	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
