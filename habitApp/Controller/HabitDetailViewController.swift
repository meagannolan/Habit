//
//  HabitDetailViewController.swift
//  habitApp
//
//  Created by Meagan Nolan on 1/28/20.
//  Copyright © 2020 Meagan Nolan. All rights reserved.
//

import UIKit
import Stevia

class HabitDetailViewController: UIViewController {
    private let habit: Habit
    private let imageView = UIImageView()
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Times Done"
        return label
    }()
    private let countLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Mark as Completed", for: .normal)
        button.setTitle("Completed Today!", for: .disabled)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    var isCompletedToday: Bool {
        get {
            let currentDate = Date()
            return currentDate.isIncludedInDates(habit.datesCompleted)
        } set {
            button.isEnabled = !newValue
        }
    }


    init(_ habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.isEnabled = !isCompletedToday
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = String(habit.datesCompleted.count)
        imageView.image = UIImage(named: habit.imageName)
        configureLayout()
    }

    @objc private func buttonTapped() {
        let date = NSDate()
        habit.datesCompleted.append(date)
        try? CoreDataManager.shared.context.save()
        countLabel.text = String(habit.datesCompleted.count)
        isCompletedToday = true
    }

    private func configureLayout() {
        view.backgroundColor = .white
        let safeArea = view.safeAreaLayoutGuide
        view.sv(
            imageView,
            totalLabel,
            countLabel,
            button
        )
        imageView.Top == safeArea.Top
        imageView.fillHorizontally(m: 16).heightEqualsWidth()
        totalLabel.left(8)
        totalLabel.Top == imageView.Bottom + 24
        countLabel.Top == totalLabel.Top
        countLabel.right(8)
        button.bottom(50).centerHorizontally()
    }
}
