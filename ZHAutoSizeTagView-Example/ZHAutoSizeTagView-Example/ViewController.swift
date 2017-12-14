//
//  ViewController.swift
//  ZHAutoSizeTagView-Example
//
//  Created by 张行 on 2017/12/14.
//  Copyright © 2017年 君赏. All rights reserved.
//

import UIKit
import ZHAutoSizeTagView_iOS

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		let tagView = ZHAutoSizeTagView(frame: frame) { (manager) in
			manager.tagTitle = ["Black Friday","11.11","Global shipping"]
			manager.tagHeight = 30
			manager.maxLine = 1
			//			manager.selectImage = UIImage(named: "zh_autosize_tag_select_icon", in: Bundle(for: ZHAutoSizeTagManager.self), compatibleWith: nil)
		}
		tagView.monitorTagButtonClick = { index in
			print(index)
		}
		tagView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		//		tagView.center = view.center
		self.view.addSubview(tagView)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

