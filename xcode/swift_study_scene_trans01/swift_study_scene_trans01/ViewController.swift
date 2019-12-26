//
//  ViewController.swift
//  swift_study_scene_trans01
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

    @IBAction func move_next(_ sender: Any) {
        // reference view controller by storyboard id
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "secondVC")
            else
        {
            return
        }
        
        // animation type
        uvc.modalTransitionStyle = .flipHorizontal
        
        // call present method
        self.present(uvc, animated: true)
    }

}

