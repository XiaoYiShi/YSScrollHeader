//
//  YSScrollHeader.swift
//  YSScrollHeader_Swift
//
//  Created by 史晓义 on 2017/11/23.
//  Copyright © 2017年 懒人. All rights reserved.
//

import UIKit

class YSScrollHeader: UIView {

    var selectColor : UInt  = 0xFFA015
    var normalColor : UInt  = 0x666666
    
    var normalFont  = UIFont.systemFont(ofSize: 17)
    var selectFont  = UIFont.boldSystemFont(ofSize: 17)
    
    private let cursorViewWidth: CGFloat = 32
    private let cursorView  = UIView()
    private let scrollView  = UIScrollView()
    private var btnArray    = [UIButton]()
    
    var selectAction : ZYBIntBlock?
    
    var selectIndex = 0
    
    var dataArray : Array<String>? {
        didSet {
            for aView in btnArray {
                aView.removeFromSuperview()
            }
            
            var x : CGFloat = 0
            let itemWidth = frame.width/CGFloat(dataArray!.count)
            
            for index in 0 ..< dataArray!.count {
                var buttonWidth : CGFloat = itemWidth
                let str = dataArray![index]
                if buttonWidth == 0 {
                    let copWidth = str.width(height: frame.height , font:normalFont)+15
                    buttonWidth = copWidth < 60 ? 60 : copWidth
                }
                let btn = UIButton.init(frame: CGRect(x: x, y: 0, width: buttonWidth, height: self.frame.height))
                scrollView.addSubview(btn)
                btn.tag = index+500
                btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
                btn.setTitle(str, for: .normal)
                btn.setTitleColor(UIColor.initRGB(normalColor), for: .normal)
                btn.setTitleColor(UIColor.initRGB(selectColor), for: UIControlState.selected)
                btn.titleLabel?.font = normalFont
                
                x += buttonWidth
                
                btnArray.append(btn)
            }
            scrollView.contentSize = CGSize(width:x,height:self.frame.height)
            currentCursorPosition(p: 0)
        }
    }
    
    //动态计算颜色
    private func dynamicColor(_ point:CGFloat) -> UIColor {
        let rFloat = (CGFloat((selectColor & 0xFF0000) >> 16) - CGFloat((normalColor & 0xFF0000) >> 16))*point+CGFloat((normalColor & 0xFF0000) >> 16)
        let gFloat = (CGFloat((selectColor & 0x00FF00) >> 8) - CGFloat((normalColor & 0x00FF00) >> 8))*point+CGFloat((normalColor & 0xFF0000) >> 16)
        let bFloat = (CGFloat(selectColor & 0x0000FF) - CGFloat(normalColor & 0x0000FF))*point+CGFloat((normalColor & 0xFF0000) >> 16)
        return UIColor(red: rFloat / 255.0, green: gFloat / 255.0, blue: bFloat / 255.0, alpha: CGFloat(1.0))
    }
    //发生偏移
    func currentCursorPosition(p:CGFloat) {
        selectIndex = Int(p.rounded())
        
        for aBtn in btnArray {
            let t = Int(p)
            if p-CGFloat(t) == 0 {
                //设置字体
                aBtn.titleLabel?.font = (aBtn.tag - 500 == t) ? selectFont : normalFont
                aBtn.setTitleColor(UIColor.initRGB((aBtn.tag - 500 == t) ? selectColor : normalColor), for: .normal)
            } else {
                aBtn.titleLabel?.font = (aBtn.tag - (p-CGFloat(t) > 0.5 ? 501 : 500) == t) ? selectFont : normalFont
                //动态计算title颜色
                if (aBtn.tag - 500 == t) {
                    aBtn.setTitleColor(dynamicColor(1.0-(p-CGFloat(t))), for: .normal)
                } else if (aBtn.tag - 501 == t) {
                    aBtn.setTitleColor(dynamicColor((p-CGFloat(t))), for: .normal)
                } else {
                    aBtn.setTitleColor(UIColor.initRGB(normalColor), for: .normal)
                }
            }
        }
        
        //存在下个View的情况
        if let view = self.viewWithTag(Int(p)+500),let viewAfter = self.viewWithTag(Int(p)+501)
        {
            let x = view.frame.midX+(viewAfter.frame.midX-view.frame.midX)*CGFloat(Int((p*100))%100)/100.0
            let num = viewAfter.center.x-view.center.x
            let pru = (x-view.center.x) / num
            if pru < 0.5 {
                cursorView.ys_width = cursorViewWidth + num*pru*2
            } else {
                cursorView.ys_width = cursorViewWidth + num*(2-pru*2)
            }
            cursorView.center = CGPoint(x:x,y:self.frame.height-1)
            
        } else if let view = self.viewWithTag(Int(p)+500)
        {   //没有下个View的情况
            let x = view.frame.midX+50*CGFloat(Int((p*100))%100)/100.0
            cursorView.center = CGPoint(x:x,y:self.frame.height-1)
            cursorView.ys_width = cursorViewWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(white: 1.0, alpha: 0.9)
        
        self.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        scrollView.addSubview(cursorView)
        cursorView.backgroundColor = UIColor.initRGB(0xFFA015)
        cursorView.frame = CGRect(x: 0, y: 42, width: cursorViewWidth, height: 2)
        
        selectIndex = 0
        
        let colorView = UIView.init(frame: CGRect(x: 0, y: frame.height-0.5, width: frame.width, height: 0.5))
        self.addSubview(colorView)
        colorView.backgroundColor = BackgroundGrayColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //点击按钮
    @objc func btnAction(_ btn:UIButton){
        print("\(btn.tag)")
        self.selectAction?(btn.tag as Int - 500)
        self.selectIndex = (btn.tag as Int - 500)
    }

}
