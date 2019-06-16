//
//  HomeDetailInfo.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/12.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct HomeDetailInfo : Identifiable, Hashable, Codable {
    var id:Int
    var zoneName:String
    var zoneImgName:String
    var userIcon:String
    var nickName:String
    var timeStamp:String
    var content:String
    var imgName:String
}

struct ChatItem: Hashable, Codable, Identifiable  {
    var id:Int
    var imgName:String
    var title:String
    var subTitle:String
}

struct ActivityItem: Hashable, Codable, Identifiable {
    var id:Int
    var nickIcon:String
    var nickName:String
    var timeStamp:String
    var content:String
    var imgName:String
}
