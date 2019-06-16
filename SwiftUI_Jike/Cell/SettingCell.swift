//
//  SettingCell.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/5.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct SettingCell : View {
    var imageName:String
    var title:String
    var body: some View {
        VStack(alignment: .center){
            HStack(){
                Image(imageName)
                Text(title)
                .font(Font.system(size: 15))
                .offset(x: 5, y: 0)
                Spacer()
                Image("righ_arrow")
                    .frame(width: 21, height: 36, alignment: .center)
                    .padding(.trailing, 5)
                    .scaledToFill()
            }
            .padding(.leading, 15)
            }
            .frame(height: 50)
    }
}

#if DEBUG
struct SettingCell_Previews : PreviewProvider {
    static var previews: some View {
        SettingCell(imageName: "setting_quanzi", title: "我的圈子")
    }
}
#endif
