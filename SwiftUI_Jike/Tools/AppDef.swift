//
//  AppDef.swift
//  Memento
//
//  Created by 石高扬 on 2018/1/16.
//  Copyright © 2018年 Alex yang. All rights reserved.
//

import Foundation
import UIKit

let SCREENWIDTH = UIScreen.main.bounds.size.width
let SCREENHEIGHT = UIScreen.main.bounds.size.height
let SCREENSCALE = UIScreen.main.nativeScale

// not UIUserInterfaceIdiomPad
let IS_IPHONE = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
let IS_IPAD = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)

// detect iPhone6 Plus based on its native scale
let IS_IPHONE_6PLUS = (IS_IPHONE && (UIScreen.main.nativeScale == 3.0))

func isPhoneX() -> Bool {
    var isPhoneX = false
    if #available(iOS 11.0, *) {
        guard let keyWnd = UIApplication.shared.keyWindow else { return false }
        let bottomInset = keyWnd.safeAreaInsets.bottom
        if bottomInset == 34.0 || bottomInset == 21.0 {
            isPhoneX = true
        }
    }
    return isPhoneX
}

let iPhoneX = isPhoneX()
let iPhoneX_T = CGFloat(iPhoneX ? 44 : 20)
let iPhoneX_B = CGFloat(iPhoneX ? 14 : 0)

#if DEBUG
#else
#endif
