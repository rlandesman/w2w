//
//  MainViewController.swift
//  w2w
//
//  Created by Roee Landesman on 11/8/16.
//  Copyright © 2016 BOOLEEN. All rights reserved.
//

import UIKit
import ForecastIO
import Foundation
import SwiftyJSON
import Firebase
import FirebaseDatabaseUI

class MainViewController: UIViewController {
    var tempMax : Double?
    var fbDataSource: FUITableViewDataSource?
    var temperatureChild : FIRDatabaseReference? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ref = FIRDatabase.database().reference()
        let myLat = Double(35)
        let myLon = Double(-120)
        
        let client = DarkSkyClient(apiKey: "d0b6cdd6341ef3c17e43b85b20be61dd")
        client.language = .english
        client.getForecast(latitude: myLat, longitude: myLon, excludeFields: [.alerts, .currently, .hourly, .flags, .minutely]) { (result) in
            switch result {
            case .success(let forecast, let requestMetadata):
                self.tempMax = Double((forecast.daily?.data.first?.apparentTemperatureMax!)!)
                print(self.tempMax!)
            case .failure(let error):
                print(error)
            }
        }
        if(tempMax! >= 55)
        {
            temperatureChild = ref.child("Hot")
        }
        else
        {
            temperatureChild = ref.child("Cold")
        }
        
        let q = temperatureChild?.queryOrderedByKey()
        fbDataSource = FUITableViewDataSource(query: q, view: tableView) {
            (tableView: UITableView, indexPath: IndexPath, data: FIRDataSnapshot) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "clothCell", for: indexPath) as? ExampleCell
      }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        

        }
        
    }
    


