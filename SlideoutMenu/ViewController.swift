//
//  ViewController.swift
//  SlideoutMenu
//
//  Created by Somesh Vyas on 04/11/15.
//  Copyright © 2015 Somesh Vyas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Open: UIBarButtonItem!
    @IBOutlet weak var Label: UILabel!

    var varView = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
        if(varView == 0){
            Label.text = "Strings"
        } else {
            Label.text = "Others"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

