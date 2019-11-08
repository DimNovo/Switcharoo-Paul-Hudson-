//
//  ShuffleTray.swift
//  Switcharoo { Paul Hudson }
//
//  Created by Dmitry Novosyolov on 02/11/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct ShuffleTray: View {
    var action: (() -> Void)?
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                self.action?()
            }) {
                Text("Shuffle Tray")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .shadow(radius: 3)
                    .shadow(radius: 3)
                    .padding()
            }
        }.padding([.trailing, .bottom]).buttonStyle(PlainButtonStyle())
    }
}

struct ShuffleTray_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleTray()
    }
}
