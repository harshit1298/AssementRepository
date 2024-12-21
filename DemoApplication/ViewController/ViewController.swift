//
//  ViewController.swift
//  ImageCarousal
//
//  Created by Harshit Bansal on 19/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var floatingButton: UIButton!
    
    var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    @IBAction func floatingButtonAction(_ sender: UIButton) {
        // Get the top occurrences from ViewModel
        let topOccurrences = viewModel.getTopOccurrences()
        
        var statisticsText = "Statistics\nList \(viewModel.currentPageIndex + 1) (\(viewModel.filteredList.count) items)\n"
        for occurrence in topOccurrences {
            statisticsText += "\(occurrence.character) = \(occurrence.count)\n"
        }
        
        if topOccurrences.isEmpty {
            statisticsText += "No letters to display"
        }
        
        // Display bottom sheet dialog
        let alertController = UIAlertController(title: nil, message: statisticsText, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func getTopOccurrences(from list: [String]) -> [(character: Character, count: Int)] {
        // Combine all strings into one
        let combinedString = list.joined().lowercased()
        
        // Count occurrences of each character
        var characterCount: [Character: Int] = [:]
        for char in combinedString where char.isLetter {
            characterCount[char, default: 0] += 1
        }
        
        // Sort by frequency in descending order
        let sortedOccurrences = characterCount.sorted { $0.value > $1.value }
        
        // Map the top 3 occurrences to the desired format
        return sortedOccurrences.prefix(3).map { (character: $0.key, count: $0.value) }
    }
    
    func setupView() {
        // Register Cells
        let carouselNib = UINib(nibName: "CarouselCollectionViewCell", bundle: nil)
        collectionView.register(carouselNib, forCellWithReuseIdentifier: "CarouselCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let listItemNib = UINib(nibName: "ListItemTableViewCell", bundle: nil)
        tableView.register(listItemNib, forCellReuseIdentifier: "ListItemTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // Initial Setup
        pageControl.numberOfPages = viewModel.carouselImages.count
        tableView.reloadData()
        
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.showsBookmarkButton = false
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.backgroundColor = .clear
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 230/255, alpha: 1)
            textField.layer.cornerRadius = 10
            textField.clipsToBounds = true
            textField.borderStyle = .none
        }
    }
}


// MARK: Table view delegate and datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemTableViewCell", for: indexPath) as? ListItemTableViewCell else {
            return UITableViewCell()
        }
        let listItem = viewModel.filteredList[indexPath.row]
        cell.locationImageView.image = UIImage(named: "image1")
        cell.title.text = listItem.title
        cell.subTitle.text = listItem.subtitle
        return cell
    }
}


// MARK: Collection view delegate and datasource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.carouselImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(named: viewModel.carouselImages[indexPath.item].name)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            
            guard pageIndex >= 0 && pageIndex < viewModel.allLists.count else { return }
            
            if pageIndex != viewModel.currentPageIndex {
                viewModel.updateFilteredList(forPage: pageIndex)
                pageControl.currentPage = pageIndex
                tableView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        return CGSize(width: collectionView.bounds.width, height: safeAreaHeight * 0.25)
    }
}


// MARK: Search bar delegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterList(withSearchText: searchText)
        tableView.reloadData()
    }
}
