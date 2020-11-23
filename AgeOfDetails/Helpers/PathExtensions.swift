//
//  PathExtensions.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 22.11.20.
//

import SwiftUI

extension Path {
    /*
     Inspired by https://medium.com/better-programming/create-a-line-chart-in-swiftui-using-paths-183d0ddd4578
     */
    static func lineChart(points: [Double], step: CGPoint) -> Path {
        var path = Path()
        if points.count < 2 {
            return path
        }
        guard let offset = points.min() else { return path }
        let p1 = CGPoint(x: 0, y: CGFloat(points[0] - offset) * step.y)
        path.move(to: p1)
        for pointIndex in 1..<points.count {
            let p2 = CGPoint(x: step.x * CGFloat(pointIndex), y: step.y * CGFloat(points[pointIndex] - offset))
            path.addLine(to: p2)
        }
        return path
    }
}
