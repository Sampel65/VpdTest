//
//  SplashView.swift
//  YouVerify
//
//  Created by DevSampel 20/03/2025.
//

import SwiftUI


struct SplashView: View {
    
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var slideOffset: CGFloat = 1000
 
    private let animationDuration: Double = 1.2
    private let navigationDelay: Double = 5.0

    var body: some View {
        NavigationStack {
            ZStack {
                Color("buttoncolor").ignoresSafeArea()
                Text("GitHub Repo.")
                    .font(.system(size: 50))
                    .foregroundColor(Color("buttoncolor"))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                    )
                    .scaleEffect(size)
                    .opacity(opacity)
                    .offset(x: slideOffset)
                    .onAppear {
                        withAnimation(.easeIn(duration: animationDuration)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                        
                        withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                            slideOffset = 0
                        }
                    }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .task {
                    try? await Task.sleep(for: .seconds(navigationDelay))

                    if !Task.isCancelled {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isActive) {
                ContentView().navigationBarBackButtonHidden(true)
            }
        }
    }
}
