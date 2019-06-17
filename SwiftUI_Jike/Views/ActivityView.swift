//
//  ActivityView.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/5.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct ActivityView : View {
    let activityPadding:CGFloat = 15
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    HStack{
                        Image("addPer")
                            .padding(.horizontal, activityPadding)
                        Spacer()
                        Text("动态").bold()
                            .padding(.trailing, 44)
                        Spacer()
                    }
                        .padding(.top, 10)
                    Divider()
                }
    
                List{
                    Section(header:
                        VStack{
                            Color.init(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0)
                            .frame(width: SCREENWIDTH, height: 1, alignment: .leading)
                            HStack(alignment: .center){
                                CircleImage(imgName: "subIcon")
                                    .padding(.leading, activityPadding)
                                Text("发布动态...")
                                    .font(Font.system(size: 16))
                                    .color(Color.gray)
                                Spacer()
                                }
                                .frame(width:SCREENWIDTH,height:60,alignment:.leading)
                                .background(Color.white)
                                .offset(x: 0, y: -4)
                        }
                    ){
                        ForEach(DataMgr.shared.activityList.identified(by: \.id)) { item in
                            NavigationButton(destination: TestView()) {
                                ActivityCell(item: item)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .padding(.top, -8)
                .listStyle(.grouped)
                    
                .navigationBarTitle(Text("动态"))
                .navigationBarHidden(true)
            }
        }
    }
}

#if DEBUG
struct ActivityView_Previews : PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
#endif
