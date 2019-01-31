//
//  Canvas.swift
//  Draw
//
//  Created by 逸唐陳 on 2019/1/31.
//  Copyright © 2019 逸唐陳. All rights reserved.
//
import UIKit

class Canvas: UIView {
    
    fileprivate var lines = [Line]()
    
    private var _strokeColor: UIColor = .red
    private var _strokeWidth: CGFloat = 5
    
    var strokeWidth: CGFloat  {
        get {
            return _strokeWidth
        }set (newWidth) {
            if newWidth != _strokeWidth {
                _strokeWidth = newWidth
            }
        }
    }
    
    var strokeColor: UIColor  {
        get {
            return _strokeColor
        }set (newColor) {
            if newColor != _strokeColor {
                _strokeColor = newColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                }else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
