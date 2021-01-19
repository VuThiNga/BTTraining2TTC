//
//  ViewController.swift
//  Example
//
//  Created by admin on 1/4/21.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {

    var lstPhotos: [PhotoBO] = [PhotoBO]()
    let vm = PhotosVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getPhotos(vc: self)
    }

    @IBAction func downloadImage(_ sender: Any) {
        if lstPhotos.count > 0 {
            vm.download10Image(lstPhotos: lstPhotos)
        }
    }
    
}

extension UIViewController {
    func showLoading(_ msg: String? = nil) {
        hideLoading()
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            if let m = msg {
                hud.label.text = m
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

