//
//  GYSearchBar.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/12.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct GYSearchBar : View {
    var body: some View {
        HStack{
            HStack{
                Image("search_icon")
                    .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 5))
                Text("优衣库KAWS遭疯抢")
                    .font(Font.system(size: 14))
                    .color(Color.gray)
                Spacer()
            }
            .background(
                Color.white
                    .cornerRadius(5)
            )
            .padding(EdgeInsets(top: 4, leading: 15, bottom: 4, trailing: 10))
            
            Image("scan_icon")
                .padding(.trailing, 15)
            }
            .frame(height: 45)
            .background(Color(red: 1.0, green: 228.0/255.0, blue: 20.0/255))
    }
}

#if DEBUG
struct GYSearchBar_Previews : PreviewProvider {
    static var previews: some View {
        GYSearchBar()
    }
}
#endif
