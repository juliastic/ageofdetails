//
//  DataChartLine.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 22.11.20.
//

import Foundation
import SwiftUI

struct DataChartLine: View {
    @Binding var frame: CGRect
    
    @State private var progress: CGFloat = .zero
    @State var showChartInformation: Bool = false
    
    let data: [Double]
    let padding: CGFloat = 30
    
    init(data: [Double], frame: Binding<CGRect>) {
        self.data = data
        self._frame = frame
    }

    @ViewBuilder
    var body: some View {
        ZStack {
            xAxis
                .stroke(Color.black ,style: StrokeStyle(lineWidth: 2, lineJoin: .bevel))
                .drawingGroup()
            yAxis
                .stroke(Color.black ,style: StrokeStyle(lineWidth: 2, lineJoin: .bevel))
                .drawingGroup()
            yAxisLabels
            ratingPath
                .trim(from: 0, to: progress)
                .stroke(Color.green ,style: StrokeStyle(lineWidth: 2, lineJoin: .bevel))
                .drawingGroup()
                .animation(.easeIn(duration: 5))
                .onAppear {
                    self.progress = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5, execute: {
                        self.showChartInformation = true
                    })
                }
            if showChartInformation {
                ForEach(0..<data.count, id: \.self) { i in
                    ZStack {
                        Text("\(Int(data[i]))")
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
                    if i % 2 == 0 {
                        drawLine(for: i)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                            .drawingGroup()
                    }
                }
            }
        }
        .rotationEffect(.degrees(180), anchor: .center)
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        .offset(x: 0, y: -15)
    }
    
    var ratingPath: Path {
        return Path.lineChart(points: data, step: CGPoint(x: stepWidth, y: stepHeight))
    }
    
    var xAxisLines: [Path] {
        var paths: [Path] = []
        for i in 0..<data.count {
            var path = Path()
            let p1 = CGPoint(x: 0, y: stepHeight * CGFloat(data[i]))
            path.move(to: p1)
            let p2 = CGPoint(x: stepWidth * CGFloat(data.count - 1), y: stepHeight * CGFloat(data[i]))
            path.addLine(to: p2)
            paths.append(path)
        }
        return paths
    }
    
    var xAxis: Path {
        var path = Path()
        let p1 = CGPoint(x: 0, y: 0)
        path.move(to: p1)
        let p2 = CGPoint(x: stepWidth * CGFloat(data.count - 1), y: 0)
        path.addLine(to: p2)
        return path
    }
    
    var yAxis: Path {
        var path = Path()
        let p1 = CGPoint(x: 0, y: 0)
        path.move(to: p1)
        let p2 = CGPoint(x: 0, y: stepHeight * CGFloat((data.max() ?? 0) - (data.min() ?? 0)))
        path.addLine(to: p2)
        return path
    }
    
    var yAxisLabels: some View {
        ZStack {
            Text("\(Int(data.min() ?? 0))")
                .position(CGPoint(x: CGFloat(0), y: stepHeight * CGFloat((data.max() ?? 0) - (data.min() ?? 0))))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .offset(x: 0, y: -55)
            Text("\(Int(data.max() ?? 0))")
                .position(CGPoint(x: 0, y: 0))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .offset(x: 0, y: -45)
        }
        .font(.system(size: 8))
    }
    
    var stepWidth: CGFloat {
        return frame.size.width / CGFloat(data.count - 1)
    }
    
    /*
     Inspired by https://medium.com/better-programming/create-a-line-chart-in-swiftui-using-paths-183d0ddd4578
     */
    var stepHeight: CGFloat {
        var min: Double?
        var max: Double?
        
        if let minPoint = data.min(), let maxPoint = data.max(), minPoint != maxPoint {
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
        let offset = data.min() ?? 0
        return CGPoint(x: stepWidth * CGFloat(index), y: stepHeight * CGFloat(data[index] - offset))
    }
    
    func drawLine(for index: Int) -> Path {
        let offset = data.min() ?? 0
        var path = Path()
        let p1 = CGPoint(x: 0, y: stepHeight * CGFloat(data[index] - offset))
        path.move(to: p1)
        let p2 = CGPoint(x: stepWidth * CGFloat(data.count - 1), y: stepHeight * CGFloat(data[index] - offset))
        path.addLine(to: p2)
        return path
    }
}
