//
//  TableData.swift
//  Table View
//
//  Created by Arin Houck on 9/18/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import Foundation

class TableData
{
    var rows: [Location] = []
    
    
    init()
    {
        var location = Location(n: "Switzerland", d: "Switzerland is a mountainous Central European country, home to numerous lakes, villages and the high peaks of the Alps.", img_name: "switzerland")
        rows.append(location)
        
        location = Location(n: "Italy", d: "Italy, commanding a long Mediterranean coastline, has left a powerful mark on Western culture and cuisine. Its capital, Rome, is home to the Vatican as well as landmark art and ancient ruins.", img_name: "italy")
        rows.append(location)
        
        location = Location(n: "Mexico", d: "Mexico is a country between the U.S. and Central America beaches on its Pacific and Gulf of Mexico coastlines and a diverse landscape of mountains, deserts and jungles.", img_name: "mexico")
        rows.append(location)
        
        location = Location(n: "United States", d: "The U.S. is a country of 50 states covering a vast swath of North America, with Alaska in the extreme Northwest and Hawaii extending the nation’s presence into the Pacific Ocean.", img_name: "usa")
        rows.append(location)
        
        location = Location(n: "India", d: "India is a vast South Asian country with diverse terrain – from Himalayan peaks to Indian Ocean coastline – and history reaching back 5 millennia.", img_name: "india")
        rows.append(location)
        
    }
    
    
    
    
}


class Location
{
    private var name: String = ""
    private var description:String = ""
    private var image_name:String = ""
    
    init (n: String, d: String, img_name: String)
    {
        name = n
        description = d
        image_name = img_name
        
    }
    
    internal func getName() -> String {
        return name
    }
    
    internal func getDescription() -> String {
        return description
    }
    
    internal func getImageName() -> String {
        return image_name
    }
    
    
}
