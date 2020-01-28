//
//  HabitListViewController.swift
//  habitApp
//
//  Created by Meagan Nolan on 1/28/20.
//  Copyright © 2020 Meagan Nolan. All rights reserved.
//

import UIKit
import CoreData
import Stevia

class HabitListViewController: UIViewController {

    private let tableView = UITableView()
    private var habits: [Habit] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchHabits()
    }

    private func fetchHabits() {
        let context = CoreDataManager.shared.context
        let request = NSFetchRequest<Habit>(entityName: "Habit")
        do {
            guard let fetchedHabits = try context?.fetch(request) else { return }
            habits = fetchedHabits
        } catch let error as NSError {
            print(error)
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configureNavigationBar() {
        title = "Habit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
    }

    private func configureLayout() {
        view.sv(tableView)
        tableView.followEdges(view)
    }

    @objc private func plusButtonTapped() {
        let createHabitVC = CreateHabitViewController()
        present(createHabitVC, animated: true, completion: nil)
    }

}

extension HabitListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let habit = habits[indexPath.row]
        let cell = UITableViewCell()
        cell.imageView?.image = UIImage(named: habit.imageName)
        cell.textLabel?.text = habit.name
        let currentDate = Date()
        cell.accessoryType = currentDate.isIncludedInDates(habit.datesCompleted) ? .checkmark: .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let habit = habits[indexPath.row]
        let habitDetailVC = HabitDetailViewController(habit)
        navigationController?.pushViewController(habitDetailVC, animated: true)
    }
}
