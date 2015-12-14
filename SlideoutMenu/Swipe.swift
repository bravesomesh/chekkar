//
//  Swipe.swift
//  SlideoutMenu
//
//  Created by Somesh Vyas on 17/11/15.
//  Copyright © 2015 Somesh Vyas. All rights reserved.
//

import Foundation

class Swipe : UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}