//
//  HomeCell.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/6.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct HomeCell : View {
    var info:HomeDetailInfo
    var body: some View {
        VStack(alignment: .leading){
            VStack(){
                
                HStack{
                    ImageStore.shared.image(name: info.zoneImgName, size: 45)
                    .cornerRadius(5)
                    .padding(.leading, 20)
                    .padding(.vertical, 15)
                    VStack(alignment: .leading, spacing: 5){
                        Text(info.zoneName)
                            .font(Font.system(size: 16))
                            .bold()
                        Text(info.timeStamp)
                            .font(Font.system(size: 12))
                            .color(Color.gray)
                            .padding(.top, 8)
                    }
                    Spacer()
                }
                .background(Color(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0))
                .offset(x: 0, y: -6)
                
                HStack{
                    VStack(alignment: .leading){
                        Text(info.content)
                            .font(Font.system(size: 15))
                            .frame(minWidth: 320,minHeight:50, maxHeight: 300, alignment: .leading)
                            .lineLimit(-1)
                        ImageStore.shared.image(name: info.imgName, size: 200)
                            .padding(.bottom, 10)
                    }
                    Spacer()
                }
                .padding(.leading, 20)
                
                HStack(alignment: .center){
                    CircleImage(imgName: info.userIcon)
                        .padding(.leading, 20)
                    Text(info.nickName)
                        .font(Font.system(size: 14))
                        .bold()
                    Text("发布")
                        .font(Font.system(size: 13))
                        .color(Color.gray)
                    Spacer()
                }
            }
            Divider()
            .padding(.horizontal,20)
            HStack{
                Image("dianzan")
                Spacer()
                Image("pinglun")
                Spacer()
                Image("share")
                Spacer()
                Image("shenglue")
            }
            .padding(.horizontal, 20)
            }
            .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
            .frame(width:SCREENWIDTH-30, height:450)
    }
}

#if DEBUG
struct HomeCell_Previews : PreviewProvider {
    static var previews: some View {
        HomeCell(info: HomeDetailInfo(id: 0, zoneName: "人人都爱宝可梦", zoneImgName: "30_Fotor", userIcon: "pokemon", nickName: "皮卡丘", timeStamp: "2小时前", content: "蒜头丘！\n皮卡皮卡₍₍ (̨̡ ‾᷄ᗣ‾᷅ )̧̢ ₎₎", imgName: "kcc"))
    }
}
#endif
