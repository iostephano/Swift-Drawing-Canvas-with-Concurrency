//
//  DrawingViewController.swift
//  Swift Drawing Canvas with Concurrency
//
//  Created by Stephano Portella on 06/04/25.
//
import UIKit

class DrawingViewController: UIViewController {
    private let drawingView = DrawingView()
    private let historyManager = BrushHistoryManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawingView.frame = view.bounds
        drawingView.backgroundColor = .white
        drawingView.activeTool = BrushTool()
        drawingView.historyManager = historyManager
        view.addSubview(drawingView)
    }
}
