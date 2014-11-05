//
//  PagedScrollViewController.swift
//  scrollTest
//
//  Created by Charles Rice on 05/11/2014.
//  Copyright (c) 2014 Cake Solutions. All rights reserved.
//

import UIKit

class PagedScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Part 1
        pageImages = [
            UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!
        ]
        
        let pageCount = pageImages.count
        
        //Part 2
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        //Part 3
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        //Part 4
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: pagesScrollViewSize.height)
        
        //Part 5
        loadVisiblePages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        loadVisiblePages()
    }
    
    func loadVisiblePages(){
        //What can we see?
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        //update page control display
        pageControl.currentPage = page
        
        //What pages do I want to load?
        let firstPage = page - 1
        let lastPage = page + 1
        
        //Purge before
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        //Load our pages
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        //Purge after
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    func loadPage(page: Int){
        if page < 0 || page >= pageImages.count {
            return
        }
        
        //1
        if let pageView = pageViews[page] {
            //Do nothing. Already loaded.
        } else {
            //2; scroll through to this part i.e. image
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            //3
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            //4
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int){
        if page < 0 || page >= pageImages.count {
            return
        }
        
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
