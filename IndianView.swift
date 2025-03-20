//
//  IndianView.swift
//  CC60 NSC
//
//  Created by Dessen Tan on 20/3/25.
//

import SwiftUI

struct IndianView: View {
    var body: some View {
        VStack {
            Text("Indian View")
                .font(.largeTitle)
                .padding()
            Text("Welcome to the Indian culture page!")
                .font(.body)
                .padding()
        }
    }
}

struct IndianView_Previews: PreviewProvider {
    static var previews: some View {
        IndianView()
    }
}
