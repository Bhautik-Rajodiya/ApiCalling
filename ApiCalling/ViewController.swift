//  ViewController.swift
//  ApiCalling
//  Created by Bhautik Rajodiya on 09/11/22.

import UIKit


struct Post: Decodable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    
//    enum keys: String,CodingKey{
//    case myUrl = "thumbnailUrl"
//    }
//
//    init(from decoder: Decoder) throws {
//        var container = try decoder.container(keyedBy: keys.self)
//        tUrl = try container.decode(String.self, forKey: .myUrl)
//    }

//    enum aaa: String, CodingKey {
//    case title
//    case body
//    }
//
//
//    init(from decoder: Decoder) throws {
//        let hlp = try decoder.container(keyedBy: aaa.self)
//
//        id = 9
//        heading = try hlp.decode(String.self, forKey: .title)
//        details = try hlp.decode(String.self, forKey: .body)
//    }
}


class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var apiTabaleView: UITableView!
    var arr: [Post] = []
    var searchCountry: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
    }
    
    
    func getdata(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        var ur = URLRequest(url: url!)
        ur.httpMethod = "GET"
        URLSession.shared.dataTask(with: ur) { (data,response,error) in
            do{
                if error == nil
                {
                    self.arr = try JSONDecoder().decode([Post].self, from: data!)
//                    self.searchCountry = self.arr
//                    DispatchQueue.main.async {
//                        self.apiTabaleView.reloadData()
//                    }
                    print(self.arr)
                }
            }
            catch (let err){
                print("ERROR", err)
            }
        }.resume()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            arr = searchCountry
        }
        else
        {
            arr = searchCountry.filter({i in
                return i.title.contains(searchBar.text!)
            })
        }
        apiTabaleView.reloadData()
    }
    
    func img(uri: String)-> UIImage? {
        let url1 = URL(string: uri)
        let data = try? Data(contentsOf: url1! as URL)
        return UIImage(data: data!,scale: -1)
    }
    
    func nevigationTosecondPageViewController (mode: String) {
        let storyBoard  : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       let gamePlays = storyBoard.instantiateViewController(withIdentifier: "secondPage" ) as! secondPage
        //gamePlays.strLevel = mode
        navigationController?.pushViewController(gamePlays, animated: true)
    }

}


extension ViewController : UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell

        cell.lable2.text = String(arr[indexPath.row].id)
        cell.lable3.text = arr[indexPath.row].title
        cell.image1?.image = img(uri: arr[indexPath.row].url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            nevigationTosecondPageViewController(mode: "secondPage")
        }
    }
    
}
