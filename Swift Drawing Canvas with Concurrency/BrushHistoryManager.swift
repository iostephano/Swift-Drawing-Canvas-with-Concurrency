//
//  BrushHistoryManager.swift
//  Swift Drawing Canvas with Concurrency
//
//  Created by Stephano Portella on 06/04/25.
//
import UIKit

actor BrushHistoryManager {
    private var history: [DrawingCommandData] = []

    func add(_ tool: DrawingTool) {
        let path = tool.path()
        var points: [CGPoint] = []

        path.cgPath.applyWithBlock { elementPointer in
            let element = elementPointer.pointee
            if element.type == .moveToPoint || element.type == .addLineToPoint {
                points.append(element.points[0])
            }
        }

        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        tool.color.getRed(&r, green: &g, blue: &b, alpha: &a)
        let colorComponents = [r, g, b, a]

        let command = DrawingCommandData(colorComponents: colorComponents, points: points)
        history.append(command)
    }

    func all() -> [DrawingCommandData] {
        return history
    }

    func clear() {
        history.removeAll()
    }
}

