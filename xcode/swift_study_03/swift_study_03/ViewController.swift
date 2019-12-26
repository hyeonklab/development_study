//
//  ViewController.swift
//  swift_study_03
//
//  Created by admin on 2018. 9. 30..
//  Copyright © 2018년 hyeonk lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var label_01: UILabel!
    
    @IBOutlet var label_02: UILabel!

    @IBOutlet var label_03: UILabel!
    
    @IBOutlet var label_04: UILabel!
    
    @IBOutlet var label_05: UILabel!
    
    @IBAction func click_btn01(_ sender: Any) {
        print("touch up inside")
    }
    
    @IBAction func did_end_on_exit(_ sender: Any) {
        print("did_end_on_exit")
    }
    
    @IBAction func touch_cancel(_ sender: Any) {
        print("touch_cancel")
    }
    
    @IBAction func touch_down(_ sender: Any) {
        print("touch_down")
    }
    
    @IBAction func touch_repeat(_ sender: Any) {
        print("touch_repeat")
    }
    
//    @IBAction func touch_drag_enter(_ sender: Any) {
//        print("touch_drag_enter")
//    }
    
//    @IBAction func touch_drag_exit(_ sender: Any) {
//        print("touch_drag_exit")
//    }
    
//    @IBAction func touch_drag_outside(_ sender: Any) {
//        print("touch_drag_outside")
//    }
    
    @IBAction func touch_up_outside(_ sender: Any) {
        print("touch_up_outside")
    }
    
    @IBAction func click_btn02(_ sender: Any) {
        print("touch up inside")
    }
}

