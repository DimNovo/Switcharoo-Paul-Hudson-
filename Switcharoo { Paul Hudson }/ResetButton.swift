//
//  ResetButton.swift
//  Switcharoo { Paul Hudson }
//
//  Created by Dmitry Novosyolov on 02/11/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct ResetButton: View {
    var action: (() -> Void)?
    var body: some View {
        Group {
            Button(action: { self.action?()}) {
                Text("Reset Letters")
                    
            }
            .padding()
            .font(.largeTitle)
            .foregroundColor(.green)
            .shadow(radius: 3)
            .shadow(radius: 3)
            
            Text("(10 Point Penalty)")
                .font(.headline)
                .foregroundColor(.white)
                .shadow(color: .red, radius: 5)
                .shadow(color: .red, radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ResetButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetButton()
    }
}
