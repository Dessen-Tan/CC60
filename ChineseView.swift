//
//  ChineseView.swift
//  CC60 NSC
//
//  Created by Dessen Tan on 20/3/25.
//

import SwiftUI

struct ChineseView: View {
    var body: some View {
        VStack {
            Text("Chinese View")
                .font(.largeTitle)
                .padding()
            Text("Welcome to the Chinese culture page!")
                .font(.body)
                .padding()
        }
    }
}

struct ChineseView_Previews: PreviewProvider {
    static var previews: some View {
        ChineseView()
    }
}
