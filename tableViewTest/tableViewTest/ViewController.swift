//
//  ViewController.swift
//  tableViewTest
//
//  Created by Aubkhon Abdullaev on 06.10.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: Date())?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myCell, for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myCell, for: indexPath) as! MyCell
        //cell.myTextLabel1.text = String(indexPath.row + 1)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let calendar = Calendar.current
        var dateComponent = calendar.dateComponents([.year, .month], from: Date())
        dateComponent.day = indexPath.row + 1
        let str = " " + dateFormatter.string(from: calendar.date(from: dateComponent)!) + " " + String(calendar.component(.year, from: Date())) + " year"
        cell.textLabel?.text = String(indexPath.row + 1) + " " + calendar.monthSymbols[calendar.component(.month, from: Date()) - 1] + str
        //cell.dayImageButton.setImage(UIImage(named: "calendar"), for: .normal)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    private func configureTableView() {
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        myTableView = UITableView(frame: rect)
        myTableView.dataSource = self
        myTableView.backgroundColor = .gray
        myTableView.delegate = self
        myTableView.register(MyCell.self, forCellReuseIdentifier: Constants.myCell)
        view.addSubview(myTableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.cellForRow(at: indexPath)!.textLabel!.text ?? "")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

