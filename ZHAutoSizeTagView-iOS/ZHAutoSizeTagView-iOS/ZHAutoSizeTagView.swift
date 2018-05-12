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
    @objc public var monitorTagButtonClick:((_ index:Int, _ isSelected:Bool, _ view:ZHAutoSizeTagView) -> Void)?
	var currentLineNumber:Int = 1
	var tagButtons:[UIButton] = []
    @objc public var currentMultipleIndex:[Int] = []
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
            var size = button.frame.size
            print(size)
            if size == CGSize.zero {
                size = button.intrinsicContentSize
            }
			button.frame = getButtonIntrinsicFrame(intrinsicContentSize: size, startX: &startX, startY: &startY, manager: manager)
			let stopDrawTagView = manager.maxLine > 0 && currentLineNumber > manager.maxLine && e.offset != 0
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
        button.layer.masksToBounds = true
        button.layer.cornerRadius = manager.cornerRadius
        button.isSelected = manager.defaultSelectedIndex == index
        if button.isSelected {
            self.currentMultipleIndex.append(button.tag)
            updateDisableButton()
        }
        let config = ZHAutoSizeSubTagConfig(manager: manager)
        if let subTagConfigBlock = manager.subTagConfigBlock {
            subTagConfigBlock(button.tag,config)
        }
        if config.isUseImage {
            if let subTagImageConfigBlock = config.subTagImageConfigBlock {
                subTagImageConfigBlock(button,title)
            }
            button.frame = CGRect(x: 0, y: 0, width: config.imageSize.width, height: config.imageSize.height)
        } else {
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = manager.textFont
            button.titleLabel?.lineBreakMode = .byTruncatingTail
        }
		setButtonStyle(button: button, manager: manager)
		button.addTarget(self, action: #selector(self.tagButtonClick(sender:)), for: .touchUpInside)
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.isUserInteractionEnabled = config.isUseImage ? false : manager.isUserInteractionEnabled
        button.imageView?.contentMode = .scaleAspectFit
		return button
	}

	@objc func tagButtonClick(sender:UIButton) {
        guard let manager = self.manager else {
            return
        }
        let canSlected = !manager.isSupportMultipleChoice || self.currentMultipleIndex.count < manager.maxMultipleCount
        if !canSlected && !sender.isSelected {
            return
        }
		sender.isSelected = !sender.isSelected
        if !manager.isSupportMultipleChoice {
            for button in tagButtons {
                if button != sender {
                    button.isSelected = false
                    setButtonStyle(button: button, manager: manager)
                }
                
            }
        }
        setButtonStyle(button: sender, manager: manager)
        if sender.isSelected {
            self.currentMultipleIndex.append(sender.tag)
        } else {
            if let index = self.currentMultipleIndex.index(of: sender.tag) {
                self.currentMultipleIndex.remove(at: index)
            }
        }
        updateDisableButton()
		guard let monitorTagButtonClick = self.monitorTagButtonClick else {
			return
		}
		monitorTagButtonClick(sender.tag,sender.isSelected,self)
	}
    
    func updateDisableButton() {
//        guard let manager = self.manager else {
//            return
//        }
//        guard self.currentMultipleIndex.count < manager.maxMultipleCount else {
//            return
//        }
//        for button in self.tagButtons {
//            button.isEnabled = self.currentMultipleIndex.contains(button.tag)
//        }
        
    }

	func setButtonStyle(button:UIButton, manager:ZHAutoSizeTagManager) {
        let config = ZHAutoSizeSubTagConfig(manager: manager)
        if let subTagConfigBlock = manager.subTagConfigBlock {
            subTagConfigBlock(button.tag,config)
        }
        button.layer.borderWidth = button.isSelected ? config.selectBoardWidth : config.defaultBoardWidth
        button.layer.borderColor = button.isSelected ? config.selectBoardColor.cgColor : config.defaultBoardColor.cgColor
        guard !config.isUseImage else {
            return
        }
        button.backgroundColor = button.isSelected ? config.selectBackgroundColor : config.defaultBackgroundColor
        button.setTitleColor(button.isSelected ? config.selectTextColor : config.defaultTextColor, for: .normal)

        button.setImage(button.isSelected ? config.selectImage : config.defaultImage, for: .selected)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
