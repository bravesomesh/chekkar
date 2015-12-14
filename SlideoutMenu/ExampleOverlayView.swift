//
//  ExampleOverlayView.swift
//  SlideoutMenu
//
//  Created by Somesh Vyas on 12/12/15.
//  Copyright © 2015 Somesh Vyas. All rights reserved.
//

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class ExampleOverlayView: OverlayView {
    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        return imageView
        }()
    
    override var overlayState:OverlayMode  {
        didSet {
            switch overlayState {
            case .Left :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .Right :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
            
        }
    }
    
}
