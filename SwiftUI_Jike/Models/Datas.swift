//
//  Datas.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/5.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI
class DataMgr:NSObject {
    
    static var shared = DataMgr()
    var curPageIndex:Int = -1
    var tabItems: [TabBarItem] = []
    var zonnData: [ZoneModel] = []
    var detailList: [HomeDetailInfo] = []
    var chatList: [ChatItem] = []
    var activityList: [ActivityItem] = []
    
    override init() {
        super.init()
    
        tabItems = getTabItems()
        zonnData = load("zoneData.json")
        detailList = getDetailList(tag: 0)
        chatList = load("msg.json")
        activityList = load("activity.json")
    }
    
    
    func getDetailList(tag: Int) -> [HomeDetailInfo] {
        
        if tag == curPageIndex {
            return detailList
        }
        curPageIndex = tag
        let list:[HomeDetailInfo] = load("detail.json")
        var itemList = [HomeDetailInfo]()
        for item in list {
            if item.tag == tag {
                itemList.append(item)
            }
        }
        detailList = itemList
        
        return itemList
    }
    
    func getTabItems() -> [TabBarItem] {
        
        var items = [TabBarItem]()
        let item0 = TabBarItem(id: 0, title: "首页", image: "tab_home_normal", imageSelect: "tab_home_select")
        items.append(item0)
        let item1 = TabBarItem(id: 1, title: "动态", image: "tab_status_normal", imageSelect: "tab_status_select")
        items.append(item1)
        let item2 = TabBarItem(id: 2, title: "聊天", image: "tab_chat_normal", imageSelect: "tab_chat_select")
        items.append(item2)
        let item3 = TabBarItem(id: 3, title: "我的", image: "tab_me_normal", imageSelect: "tab_me_select")
        items.append(item3)
        
        return items
    }
    
    func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}

