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
    let sliderWidth: CGFloat = 343 // Fixed width for the slider
    
    @State private var startX: CGFloat = 0
    @State private var endX: CGFloat = 0
    private let thumbSize: CGFloat = 18
    
    var body: some View {
        VStack {
            // Background Track
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Colors.Neutrals.n200)
                    .frame(width: sliderWidth, height: 4)
                
                // Range Track
                Rectangle()
                    .fill(Colors.Primary.p500)
                    .frame(width: endX - startX, height: 4)
                    .offset(x: startX)
                
                // Minimum Thumb
                Circle()
                    .fill(Colors.Neutrals.n50)
                    .overlay(Circle().stroke(Colors.Primary.p500, lineWidth: 5))
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: startX - thumbSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newX = min(max(0, value.location.x), endX - thumbSize) // Prevent crossing
                                startX = snapToStep(newX, width: sliderWidth)
                                minValue = mapToRange(startX / sliderWidth)
                            }
                    )
                
                // Maximum Thumb
                Circle()
                    .fill(Colors.Neutrals.n50)
                    .overlay(Circle().stroke(Colors.Primary.p500, lineWidth: 5))
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: endX - thumbSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newX = max(min(sliderWidth, value.location.x), startX + thumbSize) // Prevent crossing
                                endX = snapToStep(newX, width: sliderWidth)
                                maxValue = mapToRange(endX / sliderWidth)
                            }
                    )
            }
        }
        .frame(width: sliderWidth + thumbSize) // Set a fixed frame
        .onAppear {
            // Initialize thumb positions
            updateThumbs()
        }
        .onChange(of: minValue) { _, _ in
            updateThumbs()
        }
        .onChange(of: maxValue) { _, _ in
            updateThumbs()
        }
    }
    
    private func updateThumbs() {
        withAnimation {
            startX = CGFloat(mapFromRange(minValue) * sliderWidth)
            endX = CGFloat(mapFromRange(maxValue) * sliderWidth)
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
