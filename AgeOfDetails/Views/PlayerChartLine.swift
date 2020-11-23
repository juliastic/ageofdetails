//
//  PlayerMatchRatingsChart.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 22.11.20.
//

import Foundation
import SwiftUI

struct PlayerChartLine: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    @Binding var frame: CGRect

    let padding: CGFloat = 30

    @State private var progress: CGFloat = .zero
    @State var showChartInformation: Bool = false

    @ViewBuilder
    var body: some View {
        ZStack {
            path
                .trim(from: 0, to: progress)
                .stroke(Color.green ,style: StrokeStyle(lineWidth: 2, lineJoin: .bevel))
                .drawingGroup()
                .animation(.easeIn(duration: 2))
                .onAppear {
                    self.progress = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.showChartInformation = true
                    })
                }
            if showChartInformation {
                ForEach(0..<self.viewModel.filteredRatings.count, id: \.self) { i in
                    ZStack {
                        Text("\(Int(self.viewModel.filteredRatings[i]))")
                            .font(.system(size: 8))
                            .rotationEffect(.degrees(180), anchor: .center)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .offset(x: 0, y: i % 2 == 0 ? 10 : -10)
                    Circle()
                        .fill(Color.black)
                        .frame(width: 5, height: 5)
                    }
                    .position(calculateCirclePosition(for: i))
                    .animation(Animation.easeIn(duration: 2).delay(2))
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
                .offset(x: -36, y: -20)
                .frame(width: frame.width + 30, height: frame.height, alignment: .leading))
        .rotationEffect(.degrees(180), anchor: .center)
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
    
    var path: Path {
        return Path.lineChart(points: viewModel.filteredRatings, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    
    var stepWidth: CGFloat {
        return frame.size.width / CGFloat(viewModel.filteredPlayerMatchHistory.count - 1)
    }
    
    /*
     Inspired by https://medium.com/better-programming/create-a-line-chart-in-swiftui-using-paths-183d0ddd4578
     */
    var stepHeight: CGFloat {
        var min: Double?
        var max: Double?
        let points = viewModel.filteredRatings
        
        if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        } else {
            return 0
        }
        
        if let min = min, let max = max, min != max {
            return (frame.size.height - padding) / CGFloat(max - min)
        }
        return 0
    }
    
    func calculateCirclePosition(for index: Int) -> CGPoint {
        let offset = viewModel.filteredRatings.min() ?? 0
        return CGPoint(x: stepWidth * CGFloat(index), y: stepHeight * CGFloat(viewModel.filteredRatings[index] - offset))
    }
}
