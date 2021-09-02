//
//  HomeViewController.swift
//  Hemita_test
//
//  Created by apple on 31/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- Outlet Connections
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var clnView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    //MARK:- Variables
    var arrImages = [UIImage(named: "demoImage3"),
                     UIImage(named: "demoImage3"),
                     UIImage(named: "demoImage3")
    ]
    var counter = 0
    var timer = Timer()
    var data = ["Raspberry", "Apple", "Guaua", "Pineapple",
        "Custurd apple", "Watermelon", "Banana", "Cherry",
        "Pear", "Orange", "Sweet lime", "Lemon",
        "Jackfruit", "Litchi", "Kiwi", "Cranberry",
        "Bluberry", "Grapes", "Mango", "Melon"]
    
    var filteredData: [String]!
    var searchResults : [String] = []
    let searchController = UISearchController(searchResultsController: nil)
    var index = 0
    var arrData = [TableViewDetailModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tblView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        
        clnView.delegate = self
        clnView.dataSource = self
        clnView.isPagingEnabled = true
        clnView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.numberOfPages = arrImages.count
        pageControl.currentPage = 0
        
        filteredData = data
        self.tblView.keyboardDismissMode = .onDrag
        
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        
    }
    
    
    //MARK:- Method for updating page control
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
            pageControl.currentPage = index
        filteredData =  data.shuffled()
        
        self.tblView.reloadData()
    }
}

//MARK:- Tableview delegate and datasource methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.filteredData.count > 0 {
            return self.filteredData.count
        }else{
            return self.data.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DetailTableViewCell = tblView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        if self.filteredData.count > 0{
            cell.lblText.text = self.filteredData[indexPath.row]
        }else{
            cell.lblText.text = self.data[indexPath.row]
        }
        
        return cell

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            let headerCell = tblView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        
            headerCell.searchBar.delegate = self

            headerView.addSubview(headerCell)
            return headerView

        }

        func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
            return 70
        }
}


//MARK:- CollectionView delegate and datasource images
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
          
        cell.imgView.image = arrImages[indexPath.row]
            
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = clnView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

//MARK:- Methods for search bar delegate
extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        self.tblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK:- Method for search result updating
extension HomeViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {

            if let searchText = searchController.searchBar.text {
                filteredData = data.filter({ $0.contains(searchText) })
                
                self.tblView.reloadData()
            }
        }
}

