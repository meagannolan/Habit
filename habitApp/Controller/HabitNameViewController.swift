//
//  HabitNameViewController.swift
//  habitApp
//
//  Created by Meagan Nolan on 1/28/20.
//  Copyright © 2020 Meagan Nolan. All rights reserved.
//

import UIKit
import Stevia
import CoreData

protocol HabitNameViewControllerDelegate: class {
    func habitNameVCDidDismiss(_ vc: HabitNameViewController)
}

class HabitNameViewController: UIViewController {

    weak var delegate: HabitNameViewControllerDelegate?
    private let habit: Habit
    private let imageView = UIImageView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name of the New Habit"
        return label
    }()
    private let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Create Habit!", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    private var habitName: String { return textField.text ?? "" }

    init(_ habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    private func configureLayout() {
        view.backgroundColor = .white
        imageView.image = UIImage(named: habit.imageName)
        view.sv(
            imageView,
            nameLabel,
            textField,
            button
        )
        imageView.top(16).fillHorizontally(m: 16).heightEqualsWidth()
        nameLabel.centerHorizontally()
        textField.centerHorizontally()
        nameLabel.Top == imageView.Bottom + 16
        textField.Top == nameLabel.Bottom + 16
        textField.fillHorizontally(m: 8).centerHorizontally()
        textField.borderStyle = .roundedRect
        button.bottom(50).centerHorizontally()
    }

    @objc private func buttonTapped() {
        habit.name = habitName
        try? CoreDataManager.shared.context.save()
        dismiss(animated: true) {
            self.delegate?.habitNameVCDidDismiss(self)
        }
    }
}
