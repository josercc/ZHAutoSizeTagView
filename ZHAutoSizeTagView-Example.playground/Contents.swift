//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ZHAutoSizeTagView_iOS

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
		view.frame = CGRect(x: 0, y: 0, width: 375, height: 676)
		let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		let tagView = ZHAutoSizeTagView(frame: frame) { (manager) in
			manager.tagTitle = ["Black Friday","11.11","Global shipping"]
			manager.tagHeight = 30
			manager.maxLine = 1
//			manager.selectImage = UIImage(named: "zh_autosize_tag_select_icon", in: Bundle(for: ZHAutoSizeTagManager.self), compatibleWith: nil)
			print(manager.selectImage)
		}
		tagView.monitorTagButtonClick = { index in
			print(index)
		}
		tagView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//		tagView.center = view.center
        view.addSubview(tagView)
		
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


