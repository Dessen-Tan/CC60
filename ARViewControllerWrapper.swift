//
//  ARViewControllerWrapper.swift
//  ARTest
//
//  Created by Bryan Nguyen on 20/3/25.
//
import SwiftUI
struct ARViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()  // Replace with your actual ViewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Any updates if needed
    }
}
