//
//  GYTabBarVC.swift
//  SegmentDemo
//
//  Created by alexyang on 2019/6/6.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct GYTabBarVC : UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: GYTabContent, context: UIViewControllerRepresentableContext<GYTabBarVC>) {
        
    }
    
    
    func makeCoordinator() -> GYTabBarVC.Coordinator {
        Coordinator(self)
    }
    
    var tabItems:[TabBarItem]
    var controllers:[UIViewController]
    
    func makeUIViewController(context: Context) -> GYTabContent {
        
        var titles = [String]()
        var imgNames = [String]()
        var imgSelNames = [String]()
        
        for index in 0..<tabItems.count {
            let tabItem = tabItems[index]
            titles.append(tabItem.title)
            imgNames.append(tabItem.image)
            imgSelNames.append(tabItem.imageSelect)
        }
        
        let midIndex = Int((tabItems.count+1)/2)
        titles.insert("", at: midIndex)
        imgNames.insert("tab_add", at: midIndex)
        imgSelNames.insert("tab_add", at: midIndex)
        
        let tabBar = GYTabContent(titles: titles, imgNames: imgNames, imgSelNames: imgSelNames)
        
        var vPos:Int = 0
        for index in 0..<(controllers.count+1) {
            
            if index != Int((controllers.count+1)/2) {
                let vc = controllers[vPos]
                tabBar.setContentVC(vc: vc, index: index)
                vPos += 1
            }
        }
        
        return tabBar
    }
    
    class Coordinator: NSObject {
        var parent: GYTabBarVC

        init(_ tabBarVC: GYTabBarVC) {
            self.parent = tabBarVC
        }

        private func tabBarController(_ tabBarController: GYTabContent, didSelect viewController: UIViewController) {

        }

        private func tabBarController(_ tabBarController: GYTabContent, shouldSelect viewController: UIViewController) -> Bool {
            return true
        }
    }
}
