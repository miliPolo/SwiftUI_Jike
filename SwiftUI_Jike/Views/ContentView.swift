//
//  ContentView.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/5.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
		
		GYTabView(views:
					[AnyView(HomeView()),
					 AnyView(ActivityView()),
					 AnyView(ChatView()),
					 AnyView(SettingView())],
				  tabItems: getTabItems())
		.edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
		ContentView()
		
    }
}
#endif
