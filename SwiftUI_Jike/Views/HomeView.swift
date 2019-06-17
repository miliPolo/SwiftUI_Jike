//
//  HomeView.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/5.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct HomeView : View {
    let itemId = "关注"
    let segItems: [String] = ["关注", "推荐", "附近", "即刻合伙人"]
    @State var detailList: [HomeDetailInfo] = DataMgr.shared.detailList
    @State var currentPage = 0
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Color(red: 1.0, green: 228.0/255.0, blue: 20.0/255)
                    }
                    .frame(height: 40)
                    .edgesIgnoringSafeArea(.top)
                GYSearchBar()
                    .padding(.top, -52)
            }
            List{
                Section(header:
                    VStack{
                        HStack{
                            Text("我的圈子")
                                .font(Font.system(size: 16))
                                .bold()
                            Spacer()
                            Image("righ_arrow")
                                .frame(width: 21, height: 36, alignment: .center)
                                .scaledToFill()
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 10)
                            .frame(height:36)
                        CategoryRow(items: DataMgr.shared.zonnData)
                        }
                        .padding(.leading, 10)
                        .background(Color.white)
                        .frame(width: SCREENWIDTH,height: 145)
                        .offset(x: 0, y: -6)
                ){
                    GYSegment(titles: segItems, detaiList: $detailList, currentPage: $currentPage)
                        .frame(height: 36)
                        .offset(x: -25, y: 0)
                        ForEach(detailList.identified(by: \.id)) { info in
                            NavigationButton(destination: TestView()) {
                                HomeCell(info: info)
                            }
                        }
                }
                }
                .edgesIgnoringSafeArea(.top)
                .padding(.top, -8)
                .listStyle(.grouped)
            
                .navigationBarHidden(true)
                .navigationBarTitle(Text("首页"))
                .padding(.top, -8)
        }

    }
}

#if DEBUG
struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
