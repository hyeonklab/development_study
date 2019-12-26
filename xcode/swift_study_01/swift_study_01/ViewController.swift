//
//  ViewController.swift
//  swift_study_01
//
//  Created by admin on 2018. 9. 30..
//  Copyright © 2018년 hyeonk lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var uiTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sayHello(_ sender: Any) {
        self.uiTitle.text = "hello, world"
    }

}

