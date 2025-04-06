//
//  DrawingView.swift
//  Swift Drawing Canvas with Concurrency
//
//  Created by Stephano Portella on 06/04/25.
//
import UIKit

class DrawingView: UIView {
    var activeTool: DrawingTool?
    var historyManager: BrushHistoryManager?
    private var cachedHistory: [DrawingCommandData] = []

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self), let tool = activeTool else { return }
        tool.begin(at: point)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self), let tool = activeTool else { return }
        tool.move(to: point)
        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self), let tool = activeTool else { return }
        tool.end(at: point)

        Task {
            await historyManager?.add(tool)
            if let updated = await historyManager?.all() {
                self.cachedHistory = updated
            }
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        for command in cachedHistory {
            let path = UIBezierPath()
            for (index, point) in command.points.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }

            let color = UIColor(
                red: command.colorComponents[0],
                green: command.colorComponents[1],
                blue: command.colorComponents[2],
                alpha: command.colorComponents[3]
            )
            color.setStroke()
            path.stroke()
        }

        activeTool?.color.setStroke()
        activeTool?.path().stroke()
    }
}
