//
//  ViewController.swift
//  UIKitMarathon_D5
//
//  Created by Maksim Vaselkov on 15.02.2024.
//

import UIKit

class ViewController: UIViewController {

    private lazy var presentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var popoverVC = PopOverVC()

    override func viewDidLoad() {
        super.viewDidLoad()

        presentButton.addTarget(self, action: #selector(presentPopupView(_:)), for: .touchUpInside)

        view.addSubview(presentButton)
    }

    override func viewWillLayoutSubviews() {
        presentButton.sizeToFit()
        presentButton.frame.origin = .init(x: view.center.x - presentButton.frame.width / 2, y: view.safeAreaInsets.top + 20)
    }

    @objc
    private func presentPopupView(_ sender: UIButton) {
        popoverVC.preferredContentSize = .init(width: 300, height: 280)
        popoverVC.modalPresentationStyle = .popover
        popoverVC.popoverPresentationController?.delegate = self
        self.present(popoverVC, animated: true)

        if let popover = popoverVC.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
            popover.permittedArrowDirections = .up
        }
    }

}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

class PopOverVC: UIViewController {

    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "figure.walk.diamond.fill")
                        , for: .normal)

        button.addAction(.init(handler: { _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        return button
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let action1 = UIAction(title: "280pt", handler: { [weak self] _ in self?.changeViewHeight(height: 280) })
        let action2 = UIAction(title: "150pt", handler: { [weak self] _ in self?.changeViewHeight(height: 150) })

        let segmentedControl = UISegmentedControl(frame: .zero, actions: [action1, action2])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    override func viewDidLoad() {
        view.addSubview(exitButton)
        view.addSubview(segmentedControl)
    }

    override func viewWillLayoutSubviews() {
        exitButton.sizeToFit()
        exitButton.frame.origin = .init(x: view.frame.maxX - 5 - exitButton.frame.width, y: 15)

        segmentedControl.sizeToFit()
        segmentedControl.frame.origin = .init(x: view.center.x - segmentedControl.frame.width / 2, y: 20)
    }

    private func changeViewHeight(height: CGFloat) {
        self.preferredContentSize = .init(width: 300, height: height)
    }
}

