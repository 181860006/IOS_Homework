//
//  AnnouncementViewController.swift
//  NJUNews
//
//  Created by CuiZihan on 2020/12/23.
//

import UIKit
import SwiftSoup

class AnnouncementViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        downloadHTML()
    }
    
    typealias Item = (title: String, date: String, html: String)
    // current document
    var document: Document = Document.init("")
    // item founds
    var ANitems: [Item] = []
    // item founds
    
    //Download HTML
    func downloadHTML()
    {
        guard let url = URL(string: "https://jw.nju.edu.cn/_s414/24739/list.psp") else {return}
        do
        {
            // content of url
            let html = try String.init(contentsOf: url)
            // parse it into a Document
            document = try SwiftSoup.parse(html)
            // parse css query
            parse()
        }
        catch _ {return}
    }
    
    //Parse CSS selector
    func parse()
    {
        do
        {
            //empty old items
            ANitems = []
            var title = ""
            var html = "https://jw.nju.edu.cn/"
            var date = ""
            
            for element in try document.select("ul")
            {
                if try element.className() == "news_list list2"
                {
                    for list in try element.select("li")
                    {
                        for content in try list.select("span")
                        {
                            if try content.className() == "news_title"
                            {
                                title = try content.text()
                                html = "https://jw.nju.edu.cn/"
                                html += try content.select("a").attr("href")
                            }
                            if try content.className() == "news_meta"
                            {
                                date = try content.text()
                            }
                        }
                        ANitems.append(Item(title: title, date: date, html: html))
                    }
                }
            }
        }
        catch _ {return}
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AnnouncementViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ANitems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnouncementCell") as! AnnouncementTableViewCell
        cell.textLabel?.text = ANitems[indexPath.row].title
        cell.detailTextLabel?.text = ANitems[indexPath.row].date
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // 找到目标视图控制器
        guard let destViewController = segue.destination as? WebView else{
            fatalError("Unexpected destination: \(segue.destination)")
        }
        // 找到被选cell
        guard let selectedCell = sender as? AnnouncementTableViewCell else{
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        // 找到被选cell的indexPath
        guard let indexPath = tableView.indexPath(for: selectedCell)?.row else{
            fatalError("The selected cell is not being displayed by the table")
        }
        destViewController.html = ANitems[indexPath].html
    }
}
