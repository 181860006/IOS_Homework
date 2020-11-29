//
//  Item.swift
//  4_MyShoppingList
//
//  Created by 陈劭彬 on 2020/11/13.
//

import UIKit

class Item
{
    var name:String
    var reason:String?
    var wish:String?
    var photo:UIImage?
    init?(_ name:String, _ reason:String?, _ wish:String?, _ photo:UIImage?)
    {
        guard !name.isEmpty else
        {
            return nil
        }
        self.name = name
        self.photo = photo
        self.wish = wish
        self.photo = photo
    }
    
}
