//
//  ViewController.swift
//  InstrumentCollector
//
//  Created by Ann Marie Seyerlein on 5/16/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var instruments : [Instrument] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            
            instruments = try context.fetch(Instrument.fetchRequest())
            tableView.reloadData()
            
        } catch {
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instruments.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let instrument = instruments[indexPath.row]
        
        cell.textLabel?.text = instrument.name
        
        cell.imageView?.image = UIImage(data: instrument.image as! Data)
        
        return cell
        
    }

}

