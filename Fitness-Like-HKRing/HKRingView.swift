//
//  HKRingView.swift
//  Fitness-Like-HKRing
//
//  Created by chrimp on 10/26/24.
//

import SwiftUI
import HealthKit
import HealthKitUI

struct ActivityRingView: UIViewRepresentable {
    var activitySummary: HKActivitySummary
    let width: CGFloat
    let height: CGFloat
    
    func makeUIView(context: Context) -> HKActivityRingView {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let hkView = HKActivityRingView(frame: frame)
        return hkView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.setActivitySummary(self.activitySummary, animated: true)
    }
}

struct HKRingView: View {
    @Binding var daysAgo: Int
    @State var activitySummary: HKActivitySummary = HKActivitySummary()
    let hkStore = HKHealthStore()
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            ActivityRingView(activitySummary: self.activitySummary, width: self.width, height: self.height)
                .frame(width: self.width, height: self.height)
        }
        .onAppear {
            queryHKSummary(daysAgo: self.daysAgo) { summary in
                self.activitySummary = summary
            }
        }
        .onChange(of: daysAgo) {
            queryHKSummary(daysAgo: self.daysAgo) { summary in
                self.activitySummary = summary
            }
        }
    }
    
    func queryHKSummary(daysAgo: Int = 0, completion: @escaping (HKActivitySummary) -> Void) {
        print("Querying")
        let calendar = Calendar.autoupdatingCurrent
        let priorDate = calendar.date(byAdding: .day, value: -daysAgo, to: Date())!
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: priorDate)
        dateComponents.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: dateComponents)
        var summary_g: HKActivitySummary!
        
        let query = HKActivitySummaryQuery(predicate: predicate) { (query, summary, error) in
            guard let summaries = summary, summaries.count > 0 else {
                completion(HKActivitySummary())
                return
            }
            
            for summary in summaries { summary_g = summary }
            completion(summary_g)
            return
        }
        
        hkStore.execute(query)
    }
}

#Preview {
    let s = HKActivitySummary()
    @State var val = 0
    HKRingView(daysAgo: $val, width: 300, height: 300)
}
