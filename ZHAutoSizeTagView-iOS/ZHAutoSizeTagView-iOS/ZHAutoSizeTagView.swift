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
	@objc public var monitorTagButtonClick:((_ index:Int, _ isSelected:Bool) -> Void)?
	var currentLineNumber:Int = 1
	var tagButtons:[UIButton] = []
	@objc public init(frame:CGRect, block:(_ manager:ZHAutoSizeTagManager) -> Void) {
		let configManager = ZHAutoSizeTagManager()
		block(configManager)
		self.manager = configManager
		super.init(frame:frame)
		drawTagViews()
	}

	@objc public static func getIntrinsicContentSize(size:CGSize, block:(_ manager:ZHAutoSizeTagManager) -> Void) -> CGSize {
		let tagView = ZHAutoSizeTagView(frame: CGRect(origin: .zero, size: size), block: block)
		return tagView.frame.size
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
			let button = creatTagView(title: e.element, manager: manager, index: e.offset)
			tagButtons.append(button)
			button.frame = getButtonIntrinsicFrame(intrinsicContentSize: button.intrinsicContentSize, startX: &startX, startY: &startY, manager: manager)
			let stopDrawTagView = manager.maxLine > 0 && currentLineNumber > manager.maxLine
			if stopDrawTagView {
				break
			}
			height = button.frame.origin.y + button.frame.size.height + manager.edge.bottom
			width = button.frame.origin.x + button.frame.size.width + manager.edge.right
			self.addSubview(button)
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
		if manager.tagHeight > 0 {
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

	func creatTagView(title:String, manager:ZHAutoSizeTagManager, index:Int) -> UIButton {
		let button = UIButton(type: .custom)
		button.tag = index
		button.setTitle(title, for: .normal)
		button.titleLabel?.font = manager.textFont
		button.layer.masksToBounds = true
		button.layer.cornerRadius = manager.cornerRadius
		button.titleLabel?.lineBreakMode = .byTruncatingTail
		button.isSelected = manager.defaultSelectedIndex == index
		setButtonStyle(button: button, manager: manager)
		button.addTarget(self, action: #selector(self.tagButtonClick(sender:)), for: .touchUpInside)
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
		button.isUserInteractionEnabled = manager.isUserInteractionEnabled
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
		monitorTagButtonClick(sender.tag,sender.isSelected)
	}

	func setButtonStyle(button:UIButton, manager:ZHAutoSizeTagManager) {
		button.backgroundColor = button.isSelected ? manager.selectBackgroundColor : manager.defaultBackgroundColor
		button.setTitleColor(button.isSelected ? manager.selectTextColor : manager.defaultTextColor, for: .normal)
		button.layer.borderWidth = button.isSelected ? manager.selectBoardWidth : manager.defaultBoardWidth
		button.layer.borderColor = button.isSelected ? manager.selectBoardColor.cgColor : manager.defaultBoardColor.cgColor
		button.setImage(button.isSelected ? manager.selectImage : manager.defaultImage, for: .selected)
		setButtonSubStyle(button: button, manager: manager)
	}

	func setButtonSubStyle(button:UIButton, manager:ZHAutoSizeTagManager) {
		guard let subTagConfigBlock = manager.subTagConfigBlock else {
			return
		}
		let config = ZHAutoSizeSubTagConfig(manager: manager)
		subTagConfigBlock(button.tag, config)
		button.backgroundColor = button.isSelected ? config.selectBackgroundColor : config.defaultBackgroundColor
		button.setTitleColor(button.isSelected ? config.selectTextColor : config.defaultTextColor, for: .normal)
		button.layer.borderWidth = button.isSelected ? config.selectBoardWidth : config.defaultBoardWidth
		button.layer.borderColor = button.isSelected ? config.selectBoardColor.cgColor : config.defaultBoardColor.cgColor
		button.setImage(button.isSelected ? config.selectImage : config.defaultImage, for: .selected)
		print("setButtonSubStyle")
	}


	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
