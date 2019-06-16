//
//  CircleAvator.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/14.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct CircleAvator: View {
    var imgName:String
    var body: some View {
        VStack{
            ImageStore.shared.image(name: imgName, size: 60)
            .clipShape(Circle())
        }
        
    }
}

struct CircleAvator_Preview: PreviewProvider {
    static var previews: some View {
        CircleAvator(imgName:"meicon")
    }
}
