//
//  GameNumber.swift
//  Switcharoo { Paul Hudson }
//
//  Created by Dmitry Novosyolov on 02/11/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct GameNumber: View {
    var text: String
    var value: Int
    var body: some View {
        VStack {
            Text(self.text)
            Text("\(self.value)")
                .font(.largeTitle)
        }.frame(maxWidth: .infinity)
    }
}

struct GameNumber_Previews: PreviewProvider {
    static var previews: some View {
        GameNumber(text: "Score", value: 0)
    }
}
