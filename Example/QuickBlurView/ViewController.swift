//
//  ViewController.swift
//  QuickBlurView
//
//  Created by LuoYangCan on 10/25/2020.
//  Copyright (c) 2020 LuoYangCan. All rights reserved.
//

import UIKit
import QuickBlurView

class ViewController: UIViewController {
    private lazy var blurView: QuickBlurView = {
        let blurView = QuickBlurView(radius: 10, color: .clear, colorAlpha: 0.7)
        return blurView
    }()
    
    private lazy var demoPic: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "demoPic"))
        return imageView
    }()
    
    private lazy var progressView: UISlider = {
        let view = UISlider()
        view.minimumValue = 0
        view.maximumValue = 1
        view.value = 0.5
        view.addTarget(self, action: #selector(dragProgressView(sender:)), for: .valueChanged)
        return view
    }()
    
    private lazy var purpleLabel: UIButton = { [unowned self] in
        let label = UIButton(type: .custom)
        label.setTitleColor(.purple, for: .normal)
        label.setTitle("purple", for: .normal)
        label.addTarget(self, action: #selector(didTapPurpleLabel), for: .touchUpInside)
        return label
    }()
    
    private lazy var redLabel: UIButton = { [unowned self] in
        let label = UIButton(type: .custom)
        label.setTitleColor(.red, for: .normal)
        label.setTitle("red", for: .normal)
        label.addTarget(self, action: #selector(didTapRedLabel), for: .touchUpInside)
        return label
    }()
    
    private func setupSubview() {
        view.addSubview(demoPic)
        view.addSubview(blurView)
        view.addSubview(progressView)
        view.addSubview(purpleLabel)
        view.addSubview(redLabel)

        demoPic.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        purpleLabel.translatesAutoresizingMaskIntoConstraints = false
        redLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            demoPic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            demoPic.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            blurView.topAnchor.constraint(equalTo: demoPic.topAnchor),
            blurView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blurView.rightAnchor.constraint(equalTo: view.rightAnchor),
            blurView.bottomAnchor.constraint(equalTo: demoPic.bottomAnchor),
            progressView.centerXAnchor.constraint(equalTo: demoPic.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: blurView.bottomAnchor, constant: 50),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            purpleLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            purpleLabel.bottomAnchor.constraint(equalTo: blurView.topAnchor, constant: -20),
            redLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
            redLabel.bottomAnchor.constraint(equalTo: blurView.topAnchor, constant: -20),
        ])
    }
    
    @objc private func dragProgressView(sender: Any) {
        if let slider = sender as? UISlider {
            blurView.blurRadius = CGFloat(slider.value) * 20
        }
    }
    
    @objc private func didTapPurpleLabel() {
        blurView.colorTint = .purple
    }
    
    @objc private func didTapRedLabel() {
        blurView.colorTint = .red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

