//
//  ViewController.swift
//  scrollTest
//
//  Created by Charles Rice on 04/11/2014.
//  Copyright (c) 2014 Cake Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do cool stuff
        //Part 1
        let image2 = UIImage(named: "photo2.png")
        let image = UIImage(named: "photo1.png")
        imageView = UIImageView(image: image)
        var theImageSize = CGSizeZero
        if let image = image {
            theImageSize = image.size
        }
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:theImageSize)
        scrollView.addSubview(imageView)
        
        //Part2
        scrollView.contentSize = theImageSize
        
        //Part 3
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        //Part 4
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = minScale
        
        //Part 5
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale
        
        //Part 6
        centerScrollViewContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Scroll delegates
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    //Double  tap to zoom
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer){
        //Part 1
        let pointInView = recognizer.locationInView(imageView)
        
        //Part 2
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        //Part 3
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
        
        //Part 4
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    //Fixes UIScrollView autodisplay in top-left
    func centerScrollViewContents(){
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if(contentsFrame.size.width < boundsSize.width){
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
    }
}

