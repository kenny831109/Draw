//
//  ViewController.swift
//  Draw
//
//  Created by 逸唐陳 on 2019/1/31.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvasView: Canvas = {
        let view = Canvas()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let dropDownButton: DropDownButton = {
        let button = DropDownButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Colors", for: .normal)
        return button
    }()
    
    let slider: UISlider = {
        let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.minimumValue = 2
        view.maximumValue = 10
        view.value = 5
        return view
    }()
    
    let colors: [BackGroundColor] = [BackGroundColor(name: "Red", color: .red),
                                     BackGroundColor(name: "Blue", color: .blue),
                                     BackGroundColor(name: "Yellow", color: .yellow),
                                     BackGroundColor(name: "Green", color: .green),
                                     BackGroundColor(name: "Purple", color: .purple),
                                     BackGroundColor(name: "Pink", color: UIColor(red: 254/255, green: 127/255, blue: 157/255, alpha: 1)),]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Draw something..."
        setupCanvas()
        setupNavBarItem()
        setupButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dropDownButton.menuClose()
    }
    
    fileprivate func setupCanvas() {
        view.addSubview(canvasView)
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    fileprivate func setupButton() {
        view.addSubview(dropDownButton)
        dropDownButton.dropDownView.options = colors
        dropDownButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        dropDownButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        dropDownButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20).isActive = true
        dropDownButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dropDownButton.dropDownDelegate = self
        view.addSubview(slider)
        slider.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        slider.centerYAnchor.constraint(equalTo: dropDownButton.centerYAnchor).isActive = true
        slider.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
    }
    
    fileprivate func setupNavBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: UIBarButtonItem.Style.plain, target: self, action: #selector(clear))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Undo", style: UIBarButtonItem.Style.plain, target: self, action: #selector(undo))
    }
    
    @objc func clear() {
        canvasView.clear()
    }
    
    @objc func undo() {
        canvasView.undo()
    }
    
    @objc func sliderValue() {
        canvasView.strokeWidth = CGFloat(slider.value)
    }

}

extension ViewController: DropDownViewDelegate {
    
    func didSelectedOption(_ option: BackGroundColor) {
        canvasView.strokeColor = option.color
    }
    
}
