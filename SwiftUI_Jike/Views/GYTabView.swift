//
//  GYTabView.swift
//  SegmentDemo
//
//  Created by alexyang on 2019/6/6.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct GYTabView: View {
    var tabViews:[AnyView]
    var tabItems:[TabBarItem]
    var viewControllers: [UIHostingController<AnyView>]?
   
    init(views:[AnyView], tabItems:[TabBarItem]) {

        tabViews = views
        viewControllers = [UIHostingController<AnyView>]()
        for content in tabViews {
            let vc = UIHostingController(rootView: content)
            self.viewControllers?.append(vc)
        }
        self.tabItems = tabItems
    }


    var body: some View {
        
        GYTabBarVC(tabItems: tabItems, controllers: viewControllers!)
    }
}

#if DEBUG
struct GYTabView_Previews : PreviewProvider {
    static var previews: some View {
        
        GYTabView(views:
                    [AnyView(HomeView()),
                     AnyView(ActivityView()),
                     AnyView(ChatView()),
                     AnyView(SettingView())],
                  tabItems: getTabItems())
    }
}
#endif
