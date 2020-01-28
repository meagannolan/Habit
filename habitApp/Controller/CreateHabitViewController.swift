//
//  CreateHabitViewController.swift
//  habitApp
//
//  Created by Meagan Nolan on 1/28/20.
//  Copyright © 2020 Meagan Nolan. All rights reserved.
//

import UIKit
import Stevia
import CoreData

class CreateHabitViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Pick Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    private let habitNames: [String] = [
        "book",
        "bulb",
        "clock",
        "code",
        "drop",
        "food",
        "grow",
        "gym",
        "heart",
        "other"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        setupCollectionView()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func configureLayout() {
        view.backgroundColor = .white
        view.sv(
            collectionView,
            button
        )
        collectionView.top(0).fillHorizontally().height(60%)
        button.centerHorizontally()
        button.Top == collectionView.Bottom
    }

    private func setupCollectionView() {
        collectionView.register(HabitCell.self, forCellWithReuseIdentifier: "HabitCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @objc private func buttonTapped() {
        guard let indexPath = self.collectionView.indexPathsForSelectedItems?.first else { return }
        let habitName = habitNames[indexPath.row]
        guard let context = CoreDataManager.shared.context else { return }
        let habit = NSEntityDescription.insertNewObject(forEntityName: "Habit", into: context) as! Habit
        habit.imageName = habitName
        let habitNameVC = HabitNameViewController(habit)
        present(habitNameVC, animated: true, completion: nil)
    }
}

extension CreateHabitViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let habitName = habitNames[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCell", for: indexPath) as! HabitCell
        cell.imageView.image = UIImage(named: habitName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habitName = habitNames[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        true
    }
}
