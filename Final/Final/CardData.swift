//
//  CardData.swift
//  Final
//
//  Created by 陈劭彬 on 2021/1/12.
//

//游戏数据结构
import SwiftUI

enum direction
{
    case up
    case down
    case left
    case right
}

func direction2coordinate(direction: direction) -> (x: CGFloat, y: CGFloat)
{
    switch direction
    {
        case .up: return (0,-1)
        case .down: return (0,1)
        case .left: return (-1,0)
        case .right: return (1,0)
    }
}

class Main: ObservableObject
{
    @Published var Cards: [Card]
    
    init()
    {
        self.Cards = []
        self.Cards.append(Card(number: 2, coordinates: (0,1), id: self.Cards.count))
        self.Cards.append(Card(number: 2, coordinates: (0,2), id: self.Cards.count))
    }
    
    func add(data: Card)
    {
        self.Cards.append(Card(number: data.number, coordinates: data.coordinates, id: self.Cards.count))
    }
    
    //前面没有方块（要去掉已经被删除的）且没有移动到边界
    func ableToMove(id: Int, direction: direction) -> Bool
    {
        var position = self.Cards[id].coordinates
        position.x += direction2coordinate(direction: direction).x
        position.y += direction2coordinate(direction: direction).y
        if position.x<=3 && position.x>=0 && position.y<=3 && position.y>=0
        {
            if (self.Cards.firstIndex(where: {data in data.coordinates.x == position.x && data.coordinates.y == position.y && !data.deleted}) == nil)
            {return true}
        }
        return false
    }
    
    //移动时应先移动靠前的方块，后移动靠后的，找出移动的顺序
    func sort(direction: direction) -> [Int]
    {
        var temp = self.Cards
        temp.sort(by: {(data1, data2) in
            switch direction
            {
                case .up: return data1.coordinates.y<data2.coordinates.y
                case .down: return data1.coordinates.y>data2.coordinates.y
                case .left: return data1.coordinates.x<data2.coordinates.x
                case .right: return data1.coordinates.x>data2.coordinates.x
            }
        })
        
        var selection: [Int] = []
        for item in temp
        {
            selection.append(item.id)
        }
        return selection
    }
    
    func move(direction: direction)
    {
        let selection = self.sort(direction: direction)
        for i in selection
        {
            while self.ableToMove(id: i, direction: direction)
            {
                self.Cards[i].coordinates.x += direction2coordinate(direction: direction).x
                self.Cards[i].coordinates.y += direction2coordinate(direction: direction).y
            }
        }
    }
    
    //对于每一个元素，寻找在其后的，未被删除的，值相同的元素，将他们两个合并
    func combine(direction: direction)
    {
        let selection = self.sort(direction: direction)
        for i in selection
        {
            if !self.Cards[i].deleted
            {
                if let index = self.Cards.firstIndex(where: {data in
                    var position = self.Cards[i].coordinates
                    position.x += direction2coordinate(direction: direction).x
                    position.y += direction2coordinate(direction: direction).y
                    return position == data.coordinates && self.Cards[i].number == data.number && !data.deleted
                })
                {
                    self.Cards[i].coordinates.x += direction2coordinate(direction: direction).x
                    self.Cards[i].coordinates.y += direction2coordinate(direction: direction).y
                    self.Cards[i].deleted = true
                    self.Cards[index].number *= 2
                }
            }
        }
    }
    
    //首先移动，之后检测合并，最后再移动确保正确
    func moveAndcombine(direction: direction)
    {
        self.move(direction: direction)
        self.combine(direction: direction)
        self.move(direction: direction)
    }
    
    //遍历判断是不是满了
    func isFull() -> Bool
    {
        for i in 0..<4
        {
            for j in 0..<4
            {
                if (self.Cards.firstIndex(where: {
                    let temp = $0.coordinates
                    return Int(temp.x) == i && Int(temp.y) == j && !$0.deleted
                }) == nil)
                {return false}
            }
        }
        return true
    }
    
    //随机添加
    func addNewCard() -> Bool
    {
        if isFull() {return false}
        else
        {
            var tempx:CGFloat = CGFloat(arc4random()%4)
            var tempy:CGFloat = CGFloat(arc4random()%4)
            
            while self.Cards.firstIndex(where: {
                let temp = $0.coordinates
                return temp.x == tempx && temp.y == tempy && !$0.deleted
            }) != nil
            {
                tempx = CGFloat(arc4random()%4)
                tempy = CGFloat(arc4random()%4)
            }
            self.add(data: Card(number: 2, coordinates: (tempx, tempy)))
            return true
        }
    }
    
    func restart()
    {
        for item in self.Cards
        {
            self.Cards[item.id].deleted = true
        }
        self.Cards.append(Card(number: 2, coordinates: (0,1), id: self.Cards.count))
        self.Cards.append(Card(number: 2, coordinates: (0,2), id: self.Cards.count))
    }
}

struct Card: Identifiable
{
    var number: Int
    var coordinates: (x: CGFloat, y:CGFloat)
    var id:Int = 0
    var deleted: Bool = false
}
