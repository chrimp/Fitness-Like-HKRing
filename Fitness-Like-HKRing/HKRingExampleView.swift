//
//  ContentView.swift
//  Fitness-Like-HKRing
//
//  Created by chrimp on 10/26/24.
//

import SwiftUI
import HealthKit

struct HKRingExampleView: View {
    @State var isAuthorized = false
    @State var daysAgo = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if isAuthorized {
                    HKRingView(daysAgo: $daysAgo, radius: geometry.size.width * 0.8)
                    
                    Stepper(value: $daysAgo, in: 0...Int.max) {
                        Text("\(daysAgo) days ago")
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            // Request permission on launch
            let objectTypes = Set([HKObjectType.activitySummaryType()])
            HKHealthStore().requestAuthorization(toShare: nil, read: objectTypes) { (success, error) in
                isAuthorized = success
            }
        }
    }
}

#Preview {
    HKRingExampleView()
}
