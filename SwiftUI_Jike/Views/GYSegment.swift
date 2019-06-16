//
//  GYSegment.swift
//  SwiftUI_Jike
//
//  Created by alexyang on 2019/6/16.
//  Copyright © 2019 alexyang. All rights reserved.
//

import SwiftUI

struct GYSegment : UIViewRepresentable {
    
    var titles:[String]
    @Binding var currentPage: Int
    
    func makeCoordinator() -> GYSegment.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<GYSegment>) -> ZSegmentedControl {
        
        let rect = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 36)
        
        let segment = ZSegmentedControl(frame: rect)
        segment.backgroundColor = UIColor.white
        segment.bounces = true
        segment.textFont = UIFont.boldSystemFont(ofSize: 16)
        segment.textColor = UIColor.gray
        segment.textSelectedColor = UIColor.black
        segment.setHybridResource(titles, images: [], fixedWidth: SCREENWIDTH/4 - 10)
        segment.setSilder(backgroundColor: UIColor(red: 255, green: 228, blue: 20), position: .bottomWithHight(3), widthStyle: .fixedWidth(36))
        return segment
    }
    
    func updateUIView(_ uiView: ZSegmentedControl, context: Context) {
        
    }
    
    class Coordinator: NSObject {
        var control: GYSegment
        
        init(_ control: GYSegment) {
            self.control = control
        }
    }
}
#if DEBUG
struct GYSegment_Previews : PreviewProvider {
    static var previews: some View {
        GYSegment(titles: ["关注", "推荐", "附近", "即刻合伙人"], currentPage: .constant(0))
    }
}
#endif
