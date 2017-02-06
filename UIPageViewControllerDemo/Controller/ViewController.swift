//
//  ViewController.swift
//  UIPageViewControllerDemo
//
//  Created by Niks on 21/12/15.
//  Copyright © 2015 TheAppGuruz. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController, UIPageViewControllerDataSource
{
    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    
    var ColredArr: NSArray = NSArray()
    var ColBlueArr: NSArray = NSArray()
    var ColGreenArr: NSArray = NSArray()
    
    var statusMutAry: NSMutableArray = NSMutableArray()
    
    var myScrollView : UIScrollView = UIScrollView()
    
 
    override func viewDidLoad()
    {
        super.viewDidLoad()

        arrPageTitle = ["This is The App Guruz", "This is Table Tennis 3D", "This is Hide Secrets","This is The App Guruz", "This is Table Tennis 3D", "This is Hide Secrets","This is The App Guruz", "This is Table Tennis 3D"];
        arrPagePhoto = ["1.jpg", "2.jpg", "3.jpg","4.jpg", "5.jpg", "6.jpg","7.jpg", "8.jpg"];
        
        
        statusMutAry = ["yes","no","no","no","no","no","no","no"];
        
        ColredArr = [15.0, 7.0, 49.0,37, 224, 241,77, 112];
        ColBlueArr = [66, 123, 249,57, 224, 141,87, 112];
        ColGreenArr = [135, 7, 49,37, 224, 41,63, 150];
        
        // color arrays
        
        self.dataSource = self
        
        self.setButtonFunction(indexNumber: 0)
        
        self.setViewControllers([getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        myScrollView = UIScrollView(frame:CGRect(x: 0.0, y: 20.0, width: self.view.frame.height, height: 40.0))

        let categoryAry=["first", "second", "third","forth", "fifth", "sixth","seventh", "eigth"]
        
        let imageWidth:CGFloat = 55.0
        let imageHeight:CGFloat = 35.0
        var xPosition:CGFloat = 0
        for index in 0 ..< categoryAry.count
        {
            let myButton:UIButton = UIButton()
            myButton.frame.size.width = imageWidth
            myButton.frame.size.height = imageHeight
            myButton.frame.origin.x = xPosition
            
            var floatRed = Float()
            var floatGreen = Float()
            var floatBlue = Float()
            
            floatRed = ColredArr[index] as! Float
            floatGreen = ColGreenArr[index] as! Float
            floatBlue = ColBlueArr[index] as! Float
            
            print(floatRed)
            print(floatGreen)
            print(floatBlue)
            
            myButton.backgroundColor = UIColor(colorLiteralRed: floatRed/255.0, green: floatGreen/255.0, blue: floatBlue/255.0, alpha: 1.0)
            
            myButton.tag = index
            myButton.addTarget(self, action:#selector(moveToParticular(sender:)), for: .touchUpInside)
            myButton.setTitle("\(index)", for: .normal)
            myScrollView.addSubview(myButton)
            let spacer:CGFloat = 5
            xPosition = xPosition + imageWidth + spacer
        }
        
        myScrollView.contentSize = CGSize(width: (120+5)*8, height: 0.0)
        self.view.addSubview(myScrollView)
    }

    
    func setButtonFunction(indexNumber : Int) -> Void
    {
        
        let categoryAry=["first", "second", "third","forth", "fifth", "sixth","seventh", "eigth"]
        
        let imageWidth:CGFloat = 55.0
        let imageHeight:CGFloat = 35.0
        var xPosition:CGFloat = 0
        for index in 0 ..< categoryAry.count
        {
            if let theButton = self.view.viewWithTag(index) as? UIButton
            {
                theButton.bringSubview(toFront: myScrollView)
                
                let spacer:CGFloat = 5
                if index == indexNumber
                {
                    theButton.frame.origin.x = xPosition - 10
                    theButton.frame.size.width = imageWidth + 20
                    theButton.frame.size.height = imageHeight + 10
                    xPosition = xPosition + imageWidth + spacer
                }
                else
                {
                    theButton.frame.origin.x = xPosition
                    theButton.frame.size.width = imageWidth
                    theButton.frame.size.height = imageHeight
                    xPosition = xPosition + imageWidth + spacer
                }
            }
        }
    }
    

    
// MARK:- UIPageViewControllerDataSource Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        var index = pageContent.pageIndex
        
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        
        index -= 1;
        self.setButtonFunction(indexNumber: index)
        return getViewControllerAtIndex(index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        var index = pageContent.pageIndex
        
        if (index == NSNotFound)
        {
            return nil;
        }
        
        index += 1;
        if (index == arrPageTitle.count)
        {
            return nil;
        }
        self.setButtonFunction(indexNumber: index)
        return getViewControllerAtIndex(index)
    }

// MARK:- Other Methods
    func getViewControllerAtIndex(_ index: NSInteger) -> PageContentViewController
    {
        print("index is",index)
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController

        //pageContentViewController.strTitle = "\(arrPageTitle[index])"
        pageContentViewController.strPhotoName = "\(arrPagePhoto[index])"
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
    
    
    func moveToParticular(sender: UIButton) -> UIViewController?
    {
        self.setViewControllers([getViewControllerAtIndex(sender.tag)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        self.setButtonFunction(indexNumber: sender.tag)
        self.myScrollView.bringSubview(toFront: self.view)
        self.view.addSubview(myScrollView)
        return self.getViewControllerAtIndex(sender.tag)
    }
    
}

