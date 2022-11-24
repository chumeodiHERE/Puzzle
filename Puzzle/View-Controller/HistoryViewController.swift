//
//  HistoryViewController.swift
//  Puzzle
//
//  Created by Gia Huy on 04/11/2022.
//

import UIKit
import SDWebImage

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [HistoryItem]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HISTORY 🕐"
        view.addSubview(tableView)
        getAllItem()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    //TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        var Itemcontent = cell.defaultContentConfiguration()
        let imgSize = cell.frame.size.height - 6
        let uiImg: UIImageView = UIImageView()
        uiImg.frame = CGRect(x: cell.frame.size.width - imgSize, y: 3, width: imgSize, height: imgSize)
        uiImg.sd_setImage(with: URL(string: "https://easterbilby.net/compdle.wtf/computers/"+model.image!+"5.jpg"), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        uiImg.sizeToFit()
        Itemcontent.image = uiImg.image
        Itemcontent.text = model.name
        Itemcontent.secondaryText = formatter.string(from: model.dayComplete!)
        cell.contentConfiguration = Itemcontent
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //CORE DATA
    func getAllItem() {
        do {
            models = try context.fetch(HistoryItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            fatalError("FAIL")
        }
    }
    
}
