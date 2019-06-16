//
//  ChatCell.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/5.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct ChatCell : View {
    var item:ChatItem
    var body: some View {
            VStack{
                HStack(alignment: .center) {
                    CircleImage(imgName:item.imgName)
                    VStack(alignment: .leading){
                        Text(item.title)
                            .font(Font.system(size: 16))
                            .bold()
                            .offset(x: 0, y: 0)
                        Text(item.subTitle)
                            .font(Font.system(size: 14))
                            .color(Color.gray)
                            .offset(x: 0, y: 5)
                }
                Spacer()
                }
                .frame(height: 60)
            }
            .frame(height: 60)
        }
    
}

#if DEBUG
struct ChatCell_Previews : PreviewProvider {
    static var previews: some View {
        ChatCell(item: chatList.first!)
    }
}
#endif
