## **Description**

This project demonstrates a lightweight and responsive drawing canvas built with UIKit and Swift Concurrency. It allows users to draw using customizable tools (like a brush or eraser), and safely manages drawing history using Swift’s actor model for thread safety and performance.

## **Project Structure**

- DrawingTool
    
    A protocol that defines the essential behavior of drawing tools: begin, move, end, and returning the path.
    
- BrushTool / EraserTool
    
    Implementations of DrawingTool.
    
    - BrushTool: draws with a customizable color.
    - EraserTool: always draws in white (assuming a white canvas background).
- DrawingCommandData
    
    Struct that stores the color (RGBA) and the sequence of points for each drawing action.
    
- BrushHistoryManager (actor)
    
    Manages the history of drawing commands safely across concurrent tasks.
    
- DrawingView
    
    Subclass of UIView that captures touch input, updates the canvas, and communicates with the history manager.
    
- DrawingViewController
    
    The main view controller that initializes and configures the canvas and history manager.
    

## **How It Works**

- When the user touches the screen, the DrawingView uses the active tool to start a new path.
- As the user moves their finger, the path updates in real time.
- When the touch ends:
    - A Task is launched to asynchronously store the stroke in the BrushHistoryManager actor.
    - The history is fetched and stored locally for rendering.
- In the draw() method, all saved paths are redrawn on screen.
- Active strokes are displayed immediately using UIBezierPath.

## **Ideas for Extension**

- Add more drawing tools (shapes, highlighter, color picker).
- Implement support for pressure-sensitive strokes (using PencilKit or touch force).
- Add undo/redo functionality using another actor to manage undo stack.
- Save/load canvas from file system or cloud.
- Allow background color customization or image backgrounds.
- Support pinch to zoom and pan.

## License

MIT License. Feel free to use and modify.
