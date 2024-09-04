//
//  RangeSliderView.swift
//  Aman
//
//  Created by Yousuf Abdelfattah on 02/09/2024.
//


import SwiftUI

struct RangeSliderView: View {
    @Binding var minValue: Double
    @Binding var maxValue: Double
    
    let range: ClosedRange<Double>
    let step: Double
    
    
    @State private var startX: CGFloat = 0
    @State private var endX: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            ZStack(alignment: .leading) {
                // Background track
                Rectangle()
                    .fill(Colors.Neutrals.n200)
                    .frame(height: 4)
                
                // Range track
                Rectangle()
                    .fill(Colors.Primary.p500)
                    .frame(width: endX - startX, height: 4)
                    .offset(x: startX)
                
                // Minimum thumb
                Circle()
                    .fill(Colors.Neutrals.n50)
                    .overlay(Circle().stroke(Colors.Primary.p500, lineWidth: 5))
                    .frame(width: 18, height: 18)
                    .offset(x: startX - 18 / 2)
//                    .offset(x: startX)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                
                                let newX = min(max(0, value.location.x), endX)
                                startX = snapToStep(newX - 18, width: width)
                                minValue = mapToRange(startX / width)
                            }
                    )
                
                // Maximum thumb
                Circle()
                    .fill(Colors.Neutrals.n50)
                    .overlay(Circle().stroke(Colors.Primary.p500, lineWidth: 5))
                    .frame(width: 18, height: 18)
                    .offset(x: endX - 18 / 2)
//                    .offset(x: endX)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newX = max(min(width, value.location.x), startX)
                                endX = snapToStep(newX + 18, width: width)
                                maxValue = mapToRange(endX / width)
                            }
                    )
            }
            .onAppear {
                startX = CGFloat(mapFromRange(minValue) * width)
                endX = CGFloat(mapFromRange(maxValue) * width)
            }
        }
    }
    
    private func snapToStep(_ value: CGFloat, width: CGFloat) -> CGFloat {
        let relativeValue = mapToRange(Double(value / width))
        let steppedValue = round(relativeValue / step) * step
        return CGFloat(mapFromRange(steppedValue) * width)
    }
    
    private func mapToRange(_ value: Double) -> Double {
        return range.lowerBound + value * (range.upperBound - range.lowerBound)
    }
    
    private func mapFromRange(_ value: Double) -> Double {
        return (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
}
#Preview {
    RangeSliderView(minValue: .constant(0), maxValue: .constant(1_000_000), range: 0...1_000_000, step: 10_000)
}



//#Preview {
//    RangeSliderView()
//}
