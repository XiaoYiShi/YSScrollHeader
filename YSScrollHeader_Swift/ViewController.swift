//
//  ViewController.swift
//  YSScrollHeader_Swift
//
//  Created by 史晓义 on 2017/11/23.
//  Copyright © 2017年 懒人. All rights reserved.
//

import UIKit

class ViewController:   UIViewController,
                        UIScrollViewDelegate
{
    var contentScroll: UIScrollView!
    var scrollHead : YSScrollHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        //头
        scrollHead = YSScrollHeader.init(frame: CGRect(x:40,y:0,
                                                       width:SCREEN_WIDTH-80,
                                                       height:H_navigationBar))
        scrollHead.backgroundColor = .clear
        scrollHead.normalColor = 0x666666
        scrollHead.selectColor = 0xFFA015
        scrollHead.dataArray = ["推荐","图片","视频","段子"]
        self.navigationController?.navigationBar.addSubview(scrollHead)
        
        //滚动图
        contentScroll = UIScrollView.init(frame: .init(x:0,
                                                       y:H_topVC,
                                                       width:SCREEN_WIDTH,
                                                       height:SCREEN_HEIGHT-H_topVC-H_tabbar))
        view.addSubview(contentScroll)
        contentScroll.isPagingEnabled = true
        contentScroll.bounces = false
        contentScroll.delaysContentTouches = false
        contentScroll.canCancelContentTouches = true
        contentScroll.showsVerticalScrollIndicator = false
        contentScroll.showsHorizontalScrollIndicator = false
        contentScroll.contentSize = .init(width: 4*SCREEN_WIDTH,
                                          height: self.contentScroll.frame.height)
        contentScroll.delegate = self
        let contentColorArr = [UIColor.red,.green,.yellow,.purple]
        for i in 0..<4 {
            let t = UIView.init(frame: .init(x:CGFloat(i)*SCREEN_WIDTH,y:0,
                                             width:SCREEN_WIDTH,
                                             height:SCREEN_HEIGHT-H_topVC-H_tabbar))
            t.backgroundColor = contentColorArr[i]
            contentScroll.addSubview(t)
        }
        
        //头部点击
        scrollHead.selectAction = { [weak self] (index) in
            self?.contentScroll.contentOffset = .init(x: CGFloat(index)*SCREEN_WIDTH, y: 0)
        }
    }
    
    //MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.contentScroll {
            let currentPosition = scrollView.contentOffset.x/view.frame.size.width
            scrollHead.currentCursorPosition(p: currentPosition)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

