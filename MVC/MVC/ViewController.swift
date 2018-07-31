//
//  ViewController.swift
//  MVC
//
//  Created by daniel on 2018/7/30.
//  Copyright © 2018年 DanielDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - 模型
    
    var model = Model(value: "写点有趣的东西")
    
    // MARK: - 界面
    
    @IBOutlet weak var mvcTextField: UITextField!
    @IBOutlet weak var mvcButton: UIButton!
    @IBOutlet weak var mvcLabel: UILabel!
    
    // MARK: - 属性
    
    var mvcObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mvcDidLoad()
    }
    
    func mvcDidLoad() {
        mvcTextField.text = model.value
        mvcObserver = NotificationCenter.default.addObserver(forName: Model.textDidChange, object: nil, queue: nil) { [mvcLabel] (note) in
            mvcLabel?.text = note.userInfo?[Model.textKey] as? String
        }
        
    }

    @IBAction func mvcButtonPressed(_ sender: Any) {
        model.value = mvcTextField.text ?? ""
    }
}

