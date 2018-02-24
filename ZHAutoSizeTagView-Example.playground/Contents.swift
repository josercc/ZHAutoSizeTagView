//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import ZHAutoSizeTagView_iOS

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
		view.frame = CGRect(x: 0, y: 0, width: 375, height: 676)
		let frame = CGRect(x: 20, y: 20, width: 300, height: 0)
		let tagView = ZHAutoSizeTagView(frame: frame) { (manager) in
			manager.tagTitle = ["Black Friday Black Friday Black Friday Black Friday Black Friday Black Friday Black Friday","11.11","Global shipping"]
			manager.tagHeight = 15
			manager.defaultSelectedIndex = 1
            manager.maxLine = 1
			manager.subTagConfigBlock = {index,config in
				print(index)
				if index == 0 {
					config.defaultTextColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
				}
			}
		}
		tagView.monitorTagButtonClick = { index, isSelected in
			print(index,isSelected)
		}
		tagView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//		tagView.center = view.center
        view.addSubview(tagView)

		print(ZHAutoSizeTagView.getIntrinsicContentSize(size: CGSize.init(width: 0, height: 0), block: { (manager) in
			manager.tagTitle = ["Black Friday","11.11","Global shipping"]
			manager.tagHeight = 40
			manager.defaultSelectedIndex = 1
		}))
		
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


