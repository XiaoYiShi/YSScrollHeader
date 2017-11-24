//
//  swiftDefine.swift
//  YSScrollHeader_Swift
//
//  Created by 史晓义 on 2017/11/23.
//  Copyright © 2017年 懒人. All rights reserved.
//

import UIKit


typealias ZYBIntBlock       = (Int)->Void

let SCREEN_WIDTH    : CGFloat = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT   : CGFloat = UIScreen.main.bounds.size.height

// 适配6
let WIDTHBASE  = (SCREEN_WIDTH/375)
let HEIGHTBASE = (SCREEN_HEIGHT/668)

// 状态栏高度(statusbar)
let H_status = UIApplication.shared.statusBarFrame.size.height
//标题栏高度
let H_navigationBar : CGFloat = 44
//导航栏总高度
let H_topVC = (H_status+H_navigationBar)
//分栏
let H_tabbar : CGFloat = (H_status == 44 ? 83 : 49)

extension UIColor {
    class func initRGB(_ rgb :UInt) -> UIColor
    {
        // rgb颜色转换（16进制->10进制）
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func RGBA(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor
    {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}


extension String{
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin , .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.width
    }
}




extension UIView {
    
    var ys_x : CGFloat //x坐标
    {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {return self.frame.origin.x}
    }
    var ys_y : CGFloat { //y坐标
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {return self.frame.origin.y}
    }
    var ys_width : CGFloat { //宽
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {return self.frame.size.width}
    }
    var ys_height : CGFloat { //高
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {return self.frame.size.height}
    }
    
    var ys_right : CGFloat { //右边
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {return self.frame.size.width+self.frame.origin.x}
    }
    
    var ys_bottom : CGFloat { //下边
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {return self.frame.size.height+self.frame.origin.y}
    }
    
    var ys_size : CGSize { //尺寸：宽和高
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {return self.frame.size}
    }
    
    var ys_origin : CGPoint { //坐标：x和y
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {return self.frame.origin}
    }
    var ys_centerX : CGFloat { //中心点：X
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
        get {return self.center.x}
    }
    var ys_centerY : CGFloat { //中心点：Y
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
        get {return self.center.y}
    }
}

let BackgroundGrayColor : UIColor = UIColor.initRGB(0xE0E0E0)





