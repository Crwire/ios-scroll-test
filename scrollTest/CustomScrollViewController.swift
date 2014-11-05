//
//  CustomScrollViewController.swift
//  scrollTest
//
//  Created by Charles Rice on 05/11/2014.
//  Copyright (c) 2014 Cake Solutions. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup the container view to hold your custom view hierarchy
        let containerSize = CGSize(width: 640.0, height: 640.0)
        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y:0), size:containerSize))
        scrollView.addSubview(containerView)
        
        //Setup the custom view hierarchy
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 80))
        redView.backgroundColor = UIColor.redColor()
        containerView.addSubview(redView)
        
        let blueView = UIView(frame: CGRect(x: 0, y: 560, width: 640, height: 80))
        blueView.backgroundColor = UIColor.blueColor()
        containerView.addSubview(blueView)
        
        let greenView = UIView(frame: CGRect(x: 160, y: 160, width: 320, height: 320))
        greenView.backgroundColor = UIColor.greenColor()
        containerView.addSubview(greenView)
        
        let imageView = UIImageView(image: UIImage(named: "slow.png"))
        imageView.center = CGPoint(x: 320, y: 320)
        containerView.addSubview(imageView)
        
        //Tell scroll view the size of contents
        scrollView.contentSize = containerSize
        
        //EXTRA: Re-add double-tap to zoom
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        //Setup min and max zoom scales
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        centerScrollViewContents()
    }
    
    //Double-tap to zoom function
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer){
        //Identify where the user double-tapped
        let pointInView = recognizer.locationInView(containerView)
        
        //Create the new zoomscales
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        //Setup the ScrollView
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (w / 2.0)
        
        let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
        
        //Zoom to it!
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    //Scroll view delegates and center frame functions
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func centerScrollViewContents(){
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.y = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.x = (boundsSize.height - contentsFrame.size.height) / 2.0
        }
        
        containerView.frame = contentsFrame
    }
}
