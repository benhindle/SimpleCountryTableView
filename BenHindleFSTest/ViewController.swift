//
//  ViewController.swift
//  BenHindleFSTest
//
//  Created by Ben Hindle on 1/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let currentDataSource = StaticData.locations
    private var filteredData: [String] = StaticData.locations
    private var currentSelection = ""
    
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select region"
        initObservers()
        configureNavbar()
        configureTableview()
        configureSearchController()
        initSearchController()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: - Observers
    private func initObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    
    //MARK: - Layout config
    func configureNavbar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.systemGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    private func initSearchController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureTableview() {
        tableView.register(LocationTVCell.self, forCellReuseIdentifier: LocationTVCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.isHidden = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search countries"
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    
    //MARK: - Data manipulation
    func filterData(usingText text: String) {
        filteredData = currentDataSource.filter({ (country: String) in
            return country.lowercased().contains(text.lowercased())
        })
        tableView.reloadData()
    }
    
    private func resetSelection() {
        navigationItem.setRightBarButton(nil, animated: true)
        currentSelection = ""
    }
    
    
    //MARK: - User actions
    @objc func doneButtonHandler() {
        let title = "You selected " + currentSelection
        let buttonTitle = "Awesome!"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil ))
        self.present(alert, animated: true)
    }
    
    private func addBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonHandler))
    }
    
    
    //MARK: - Keyboard config - allows swipe to dismiss keyboard functionality
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Prevents glitch at bottom of view when hiding keyboard
        guard let keyboardWindow: UIWindow = getKeyboardWindow() else { return }
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        keyboardWindow.frame = CGRect(x: 0, y: 50, width: screenWidth, height: screenHeight)
    }
    
    private func getKeyboardWindow() -> UIWindow? {
        for window in UIApplication.shared.windows {
            if (NSStringFromClass(type(of: window).self) == "UIRemoteKeyboardWindow") {
                return window
            }
        }
        return nil
    }
}


//MARK: - Extensions
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTVCell.identifier) as! LocationTVCell
        cell.label.text = filteredData[indexPath.row]
        if filteredData[indexPath.row] == currentSelection {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimension.standardCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelection = filteredData[indexPath.row]
        addBarButtonItem()
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
           indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: false)
            resetSelection()
            return nil
        }
        return indexPath
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredData = currentDataSource
            tableView.reloadData()
            return
        }
        filterData(usingText: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData = currentDataSource
        tableView.reloadData()
    }
}
