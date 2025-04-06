//
//  DrawingTool.swift
//  Swift Drawing Canvas with Concurrency
//
//  Created by Stephano Portella on 06/04/25.
//
import UIKit

protocol DrawingTool {
    var color: UIColor { get set }
    func begin(at point: CGPoint)
    func move(to point: CGPoint)
    func end(at point: CGPoint)
    func path() -> UIBezierPath
}

class BrushTool: DrawingTool {
    var color: UIColor = .black
    private let bezierPath = UIBezierPath()

    func begin(at point: CGPoint) {
        bezierPath.move(to: point)
    }

    func move(to point: CGPoint) {
        bezierPath.addLine(to: point)
    }

    func end(at point: CGPoint) {
        bezierPath.addLine(to: point)
    }

    func path() -> UIBezierPath {
        return bezierPath
    }
}

class EraserTool: BrushTool {
    override var color: UIColor {
        get { return .white }
        set {} // no-op
    }
}
