//
//  UIViewController+HUD.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showHUD(_ text: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = text
    }
    func hideHUD() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    func showAlert(_ message: String) {
        let a = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .default))
        present(a, animated: true)
    }
}
