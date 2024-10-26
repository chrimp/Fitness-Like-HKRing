//
//  ContentView.swift
//  Fitness-Like-HKRing
//
//  Created by chrimp on 10/26/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    let objectTypes = Set([HKObjectType.activitySummaryType()])
    @State var isAuthorized = false
    @State var daysAgo = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if isAuthorized {
                    HKRingView(daysAgo: $daysAgo, width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                    
                    Stepper(value: $daysAgo, in: 0...Int.max) {
                        Text("\(daysAgo) days ago")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            HKHealthStore().requestAuthorization(toShare: nil, read: objectTypes) { (success, error) in
                isAuthorized = success
            }
        }
    }
}

#Preview {
    ContentView()
}
