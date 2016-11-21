//
//  ViewScroll.swift
//  UIScrollView
//
//  Created by admin on 10/27/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var photos: [UIImageView] = []
    var pageImages : [String] = []
    var frontScrollViews: [UIScrollView] = []
    var first = false
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
        
    }
    
    override func viewDidLayoutSubviews() {
        if (!first) {
            first = true
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: 0)
            scrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0)
            
            for i in 0..<pageImages.count {
                let imgView = UIImageView(image: UIImage(named: pageImages[i] + ".jpg"))
                imgView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                imgView.contentMode = .scaleAspectFit
                photos.append(imgView)
                
                let frontScrollView = UIScrollView(frame: CGRect(x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
                frontScrollView.delegate = self
                frontScrollView.minimumZoomScale = 0.5
                frontScrollView.maximumZoomScale = 1.5
                frontScrollView.isPagingEnabled = true
                frontScrollView.contentSize = imgView.bounds.size
                frontScrollView.addSubview(imgView)
                frontScrollViews.append(frontScrollView)
                
                self.scrollView.addSubview(frontScrollView)
            }
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photos[pageController.currentPage]
    }
    
    func tapImg(gesture : UITapGestureRecognizer) {
        let position = gesture.location(in: photos[pageController.currentPage])
        zoomRectForScale(scale: scrollView.zoomScale * 1.5, center: position)
        
    }
    
    func doubleTapImg(gesture : UITapGestureRecognizer) {
        let position = gesture.location(in: photos[pageController.currentPage])
        zoomRectForScale(scale: scrollView.zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale : CGFloat, center : CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        
        frontScrollViews[pageController.currentPage] .zoom(to: zoomRect, animated: true)
    }
    
    @IBAction func onChange(_ sender: UIPageControl) {
        scrollView.contentOffset = CGPoint(x: CGFloat(pageController.currentPage) * scrollView.frame.size.width, y: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
    }
    
    
    @IBAction func backImage(_ sender: UIButton) {
        if(pageController.currentPage > 0 && pageController.currentPage < pageImages.count) {
            let prePage = pageController.currentPage - 1
            scrollView.contentOffset = CGPoint(x: CGFloat(prePage) * scrollView.frame.size.width,y: 0)
            pageController.currentPage = prePage
        }
    }
    
    @IBAction func nextImage(_ sender: UIButton) {
        if (pageController.currentPage >= 0 && pageController.currentPage < pageImages.count - 1) {
            let nextPage = pageController.currentPage + 1
            scrollView.contentOffset = CGPoint(x: CGFloat(nextPage) * scrollView.frame.size.width, y: 0)
            pageController.currentPage = nextPage
        }
    }
    
}
