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

protocol CreateHabitViewControllerDelegate: class {
    func createHabitVCDidDismiss(_ vc: CreateHabitViewController)
}

class CreateHabitViewController: UIViewController {

    weak var delegate: CreateHabitViewControllerDelegate?
    private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Choose a habit"
           return label
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private let habitNames: [String] = [
        "book",
        "bulb",
        "clock",
        "code",
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
    }

    private func configureLayout() {
        view.backgroundColor = .white
        let safeArea = view.safeAreaLayoutGuide
        view.sv(
            titleLabel,
            collectionView
        )
        titleLabel.Top == safeArea.Top + 16
        titleLabel.centerHorizontally()
        collectionView.Top == titleLabel.Bottom + 16
        collectionView.fillHorizontally(m: 16).height(60%).centerHorizontally()
    }

    private func setupCollectionView() {
        collectionView.register(HabitCell.self, forCellWithReuseIdentifier: "HabitCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CreateHabitViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

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
        guard let context = CoreDataManager.shared.context else { return }
        let habit = NSEntityDescription.insertNewObject(forEntityName: "Habit", into: context) as! Habit
        habit.imageName = habitName
        let habitNameVC = HabitNameViewController(habit)
        habitNameVC.delegate = self
        present(habitNameVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.width / 3.5)
    }
    
}

extension CreateHabitViewController: HabitNameViewControllerDelegate {
    func habitNameVCDidDismiss(_ vc: HabitNameViewController) {
        dismiss(animated: true) {
            self.delegate?.createHabitVCDidDismiss(self)
        }
    }
}
