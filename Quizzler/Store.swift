//
//  Store.swift
//  Quizzler
//
//  Created by Julian Silvestri on 2020-08-22.
//  Copyright © 2020 Julian Silvestri. All rights reserved.
//

import UIKit

class quizStoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleOfQuiz: UILabel!
    @IBOutlet weak var descriptionOfQuiz: UILabel!
    @IBOutlet weak var imageOfCell: UIImageView!
    @IBOutlet weak var priceOfQuiz: UILabel!
}

class Store: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating, UISearchBarDelegate{

    

    @IBOutlet weak var searchBarMenu: UIView!
    @IBOutlet weak var filterFreeBtn: UILabel!
    @IBOutlet weak var filterChallengeBtn: UILabel!
    @IBOutlet weak var filterPriceBtn: UILabel!
    @IBOutlet weak var filterNewestBtn: UILabel!
    @IBOutlet weak var filterStackButtons: UIStackView!
    @IBOutlet weak var quizStoreLabel: UILabel!
    @IBOutlet weak var quizStoreCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchController = UISearchController(searchResultsController: nil)
    var titlesOfQuizes = [String]()
    var descriptionsOfQuizes = [String]()
    var pricesOfQuizes = [String]()
    var titleOfItemSelected = ""
    var descriptionOfItemSelected = ""
    var priceOfItemSelected = ""
    var imagesForCell = [String]()
    var filteredQuizzes = [QuizzesInStore]()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //extension function below
        hideKeyboardWhenTappedAround()
        
        self.quizStoreCollectionView.delegate = self
        self.quizStoreCollectionView.dataSource = self
        
        self.filterChallengeBtn.clipsToBounds = true
        self.filterNewestBtn.clipsToBounds = true
        self.filterPriceBtn.clipsToBounds = true
        self.filterFreeBtn.clipsToBounds = true
        
        self.filterChallengeBtn.layer.cornerRadius = 5
        self.filterNewestBtn.layer.cornerRadius = 5
        self.filterPriceBtn.layer.cornerRadius = 5
        self.filterFreeBtn.layer.cornerRadius = 5

        if self.traitCollection.userInterfaceStyle == .dark {
            self.quizStoreCollectionView.backgroundColor = UIColor.clear
            self.quizStoreLabel.textColor = UIColor.black
            self.filterFreeBtn.textColor = UIColor.white
            self.filterPriceBtn.textColor = UIColor.white
            self.filterNewestBtn.textColor = UIColor.white
            self.filterChallengeBtn.textColor = UIColor.white
//            self.searchBar.backgroundColor = UIColor.clear
//            self.searchBar.layer.backgroundColor = UIColor.clear.cgColor
            //self.searchBar.tintColor = UIColor.white
    
        } else {
            self.quizStoreCollectionView.backgroundColor = UIColor.clear
            self.quizStoreLabel.textColor = UIColor.black
            self.filterFreeBtn.textColor = UIColor.white
            self.filterPriceBtn.textColor = UIColor.white
            self.filterNewestBtn.textColor = UIColor.white
            self.filterChallengeBtn.textColor = UIColor.white
//            self.searchBar.backgroundColor = UIColor.clear
//            self.searchBar.layer.backgroundColor = UIColor.clear.cgColor
            //self.searchBar.tintColor = UIColor.white
            
        }
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.becomeFirstResponder()
        self.searchBarMenu.addSubview(searchController.searchBar)
        self.searchBarMenu.bringSubviewToFront(searchController.searchBar)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        self.refreshControl.addTarget(self, action: #selector(handleTopRefresh), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Top Refresh
    @objc func handleTopRefresh(_ sender: UIRefreshControl){
        
        sender.endRefreshing()
        print("REFRESHED")
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .default
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return Globals.quizzesInStore?.count ?? 10
        if isFiltering() == true {
            return self.filteredQuizzes.count
        } else {
            return Globals.quizzesInStore.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizStoreCollectionView.dequeueReusableCell(withReuseIdentifier: "featuredQuizCell", for: indexPath) as! quizStoreCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.imageOfCell.layer.cornerRadius = cell.frame.size.height/2
        
        if self.traitCollection.userInterfaceStyle == .dark {
            //cell.titleOfQuiz.textColor = UIColor.white
            cell.titleOfQuiz.textColor = UIColor.black
            //cell.descriptionOfQuiz.textColor = UIColor.black
            //cell.priceOfQuiz.textColor = UIColor.black
        } else {
            self.quizStoreCollectionView.backgroundColor = UIColor.clear
            //cell.titleOfQuiz.textColor = UIColor.white
            cell.titleOfQuiz.textColor = UIColor.black
            //cell.descriptionOfQuiz.textColor = UIColor.black
            //cell.priceOfQuiz.textColor = UIColor.black
        }
        let data: QuizzesInStore
        if isFiltering() == true {
            data = self.filteredQuizzes[indexPath.row]
            

            cell.titleOfQuiz.text = data.title
            cell.imageOfCell.image = UIImage(named: "\(data.imageName)")
            return cell
        } else {
            data = Globals.quizzesInStore[indexPath.row]
            cell.titleOfQuiz.text = data.title
            cell.imageOfCell.image = UIImage(named: "\(data.imageName)")

            return cell
        }
        

    }
    
    //MARK: Did Select Row At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data: QuizzesInStore
        if isFiltering() == true {
            data = self.filteredQuizzes[indexPath.row]
            self.titleOfItemSelected = data.title
            self.descriptionOfItemSelected = data.description
        } else {
            data = Globals.quizzesInStore[indexPath.row]
            self.titleOfItemSelected = data.title
            self.descriptionOfItemSelected = data.description
        }
        self.priceOfItemSelected = "$0.99"
        
        self.performSegue(withIdentifier: "quizSelected", sender: self)
    }
    
    //MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizSelected" {
            if let destination = segue.destination as? QuizSelectedVC {
                destination.descriptionOfItemSelected = self.descriptionOfItemSelected
                destination.titleOfItemSelected = self.titleOfItemSelected
                destination.priceOfItemSelected = self.priceOfItemSelected
            }
        }
    }
    
    
    @IBAction func filterActionSheet(_ sender: Any) {
        let action_sheet1 = UIAlertController(title: "Filter", message: "Please Select an Option: ", preferredStyle: .actionSheet)

        action_sheet1.addAction(UIAlertAction(title: "$$ High > Low", style: .default , handler:{ (alert: UIAlertAction!) -> Void in

//            let alert = UIAlertController(title: "Approve", message: "Would you like to approve the file ", preferredStyle: UIAlertController.Style.alert)
//
//            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: nil))
//
//            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
//

            //self.present(alert, animated: true, completion: nil)

        }))




        action_sheet1.addAction(UIAlertAction(title: "$$ High < Low", style: .default , handler:{ (alert: UIAlertAction!) -> Void in

        }))




        action_sheet1.addAction(UIAlertAction(title: "Newest", style: .default , handler: { (alert: UIAlertAction!) -> Void in


        }))

        action_sheet1.addAction(UIAlertAction(title: "Free", style: .default , handler: { (alert: UIAlertAction!) -> Void in


        }))


        action_sheet1.addAction(UIAlertAction(title: "cancel", style: .cancel))


        if self.searchController.isActive == true {
            self.searchController.isActive = false

        } else {
            self.present(action_sheet1, animated: true, completion: {
                print("completion block")
            })
        }
        
        self.present(action_sheet1, animated: true, completion: {
            print("completion block")
        })

    }
    
    //MARK: Is filtering
    func isFiltering() -> Bool {
//        if self.searchController.isActive == false{
//            return false
//        } else {
//            return true
//        }
        print("Am I Filtering? -> \(searchController.isActive)")
        return searchController.isActive && !searchBarIsEmpty()
    }
    //MARK: Search Bar is empty
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
//    //MARK: Filter Content For Search Text
//    func filterContentForSearchText(_ searchText: String) {
//        self.filteredQuizzes = self.titlesOfQuizes.filter({(item: String) -> Bool in
//            return (item.lowercased().contains(searchText.lowercased()))
//
//
//        })
//        quizStoreCollectionView.reloadData()
//    }
    

    
//    //MARK: Search Bar cancel button clicked
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        //searchWasCanceled = true
//        //self.menuItems.removeAll()
//        //self.filteredMenuData.removeAll()
////        loadData() { success, error in
////            if success == true {
////                print("success")
////                self.menuTableView.reloadData()
////            } else {
////                print("no success")
////            }
////            if error != nil {
////                print(error)
////            } else {
////                print("no error")
////            }
////        }
//        //self.menuTableView.reloadData()
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = self.searchController.searchBar.text else { return }
        //var filteredData = [String]()
        //filteredData = self.filteredQuizzes
        //filteredData.removeAll(keepingCapacity: false)
        let updateArr = Globals.quizzesInStore.filter({
            return ($0.title.lowercased().contains(text.lowercased()) != false)
        })
        self.filteredQuizzes = updateArr
        print("*******")
        dump(self.filteredQuizzes)
        self.quizStoreCollectionView.reloadData()
    }

}

extension Store {

   func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
   }

   @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
    self.searchController.view.endEditing(true)
//       if let nav = self.navigationController {
//           nav.view.endEditing(true)
//       }
   }
}

