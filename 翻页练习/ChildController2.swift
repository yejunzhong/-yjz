//
//  ChildController2.swift
//  翻页练习
//
//  Created by 叶俊中 on 2017/8/15.
//  Copyright © 2017年 叶俊中. All rights reserved.
//

import UIKit

class ChildController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView()
        view1.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: 44)
        view1.backgroundColor = UIColor.red
        self.view.addSubview(view1)
        let button1 = UIButton()
        button1.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        button1.backgroundColor = UIColor.blue
        view1.addSubview(button1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
