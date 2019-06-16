//
//  ActivityCell.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/5.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct ActivityCell : View {
    var item:ActivityItem
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                VStack{
                    CircleImage(imgName: item.nickIcon)
                        .padding(.leading, 15)
                        .padding(.top, 10)
                    Spacer()
                }
                
                VStack(alignment: .leading){
                    HStack{
                        Text(item.nickName)
                            .padding(.top, 5)
                            .padding(.bottom, 2)
                        Spacer()
                    }
                    Text(item.timeStamp)
                    .font(Font.system(size: 12))
                    .color(Color.gray)
                    .padding(.bottom, 2)
                    Text(item.content)
                    .frame(minHeight:60, alignment: .top)
                    .font(Font.system(size: 15))
                    .lineLimit(-1)
                    Image(item.imgName)
                    .padding(.bottom, 20)
                }
            }
            HStack{
                Spacer()
                Image("dianzan")
                Spacer()
                Image("pinglun")
                Spacer()
                Image("share")
                Spacer()
                Image("shenglue")
            }
            .padding(.bottom, 10)
        }
        .padding(.leading, -20)
        .lineSpacing(0)
        .frame(minHeight: 300)
    }
}

#if DEBUG
struct ActivityCell_Previews : PreviewProvider {
    static var previews: some View {
        ActivityCell(item: ActivityItem(id: 1000, nickIcon: "pokemon", nickName: "皮卡丘", timeStamp: "2小时前", content: "发明一种新吃法#一人食灌蛋手抓饼夹小油条泡菜香肠，挤上番茄酱甜面酱巨好吃呀😘！！灌蛋是灵魂，不能偷懒！！", imgName: "sucai"))
    }
}
#endif
