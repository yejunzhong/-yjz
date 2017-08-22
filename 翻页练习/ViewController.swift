//
//  ViewController.swift
//  翻页练习
//
//  Created by 叶俊中 on 2017/8/15.
//  Copyright © 2017年 叶俊中. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    let titleview = UIScrollView()
    let contentView = UIScrollView()
    var lastButton = UIButton()//前一个点击的滑动条中按钮，用于记录并恢复原状
    lazy var titlebuttonArray : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "翻页测试"
        titleview.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: 44)
        contentView.frame = CGRect(x: 0, y: titleview.frame.maxY, width: ScreenWidth, height: ScreenHeight - titleview.frame.maxY)
        contentView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let data = datasource()
        addTitleScrollView(data:data)
        addchildcontroller(data: data)
        
    }
    func addTitleScrollView(data:datasource) {
        let tbwidth = 100
        for i in 0..<data.title.count{
            let titlebutton = UIButton(type: .custom)
            titlebutton.setTitle(data.title[i], for: .normal)
            titlebutton.setTitleColor(UIColor.black, for: .normal)
            titlebutton.frame = CGRect(x: i * tbwidth, y: 0, width: tbwidth, height: 44)
            titlebutton.tag = i
            titlebutton.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
            titleview.addSubview(titlebutton)
            if i == 0{
                titleBtnClick(titleBtn: titlebutton)
            }
            titlebuttonArray.add(titlebutton)
        }
        titleview.contentSize = CGSize(width: data.title.count * 100, height: 0)
        titleview.showsHorizontalScrollIndicator = false
        self.view.addSubview(titleview)
    }
    func addchildcontroller(data:datasource) {
        for i in 0..<data.title.count {
            let c = ChildController1()
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            c.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            c.view.frame = CGRect(x: CGFloat(i) * ScreenWidth, y: 0, width: ScreenWidth, height: contentView.bounds.height)
            contentView.addSubview(c.view)
        }
        contentView.contentSize = CGSize(width: CGFloat(data.title.count) * ScreenWidth, height: 0)
        contentView.showsHorizontalScrollIndicator = false
        contentView.isPagingEnabled = true
        contentView.bounces = false
        self.view.addSubview(contentView)
    }
    //点击滑动条按钮
    func titleBtnClick(titleBtn: UIButton)  {
        lastButton.setTitleColor(UIColor.black, for: .normal)
        lastButton.transform = CGAffineTransform(scaleX: 1, y: 1)//前一个按钮恢复原状
        titleBtn.setTitleColor(UIColor.red, for: .normal)
        titleBtn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)//点击按钮后，按钮放大并变红
        lastButton = titleBtn
        moveTitleButton(titleBtn: titleBtn)
        let contViewoffset = CGPoint(x: CGFloat(titleBtn.tag) * ScreenWidth, y: 0)
        contentView.setContentOffset(contViewoffset, animated: true)
    }
    //把点击的按钮移到中间位置
    func moveTitleButton(titleBtn:UIButton) {
        var offsetPoint : CGPoint = titleview.contentOffset
        offsetPoint.x =  titleBtn.center.x -  ScreenWidth / 2
        //左边超出处理
        if offsetPoint.x < 0{
            offsetPoint.x = 0
        }
        let maxX : CGFloat = titleview.contentSize.width - ScreenWidth;
        //右边超出处理
        if offsetPoint.x > maxX {
            offsetPoint.x = maxX
        }
        titleview.setContentOffset(offsetPoint, animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = contentView.contentOffset.x
        let n = NSInteger(x / ScreenWidth)
        titleBtnClick(titleBtn: titlebuttonArray[n] as! UIButton)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

