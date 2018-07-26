//
//  ViewController.swift
//  ExampleApp
//
//  Created by moxin on 7/23/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

import UIKit
import ExampleFramework

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView!
    let dataSource = ExampleLibWrapper();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.bounds.size);
        self.tableView = UITableView(frame: rect);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell");
        self.tableView.tableFooterView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0)));
        self.view.addSubview(self.tableView!);
        
        for i in 1...10{
            dataSource.append("example\(i)");
        }
        self.tableView?.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(dataSource.count());
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        let value = dataSource.object(at: UInt(indexPath.row));
        cell.textLabel?.text = value;
        
            
        
        return cell;
    }

}

