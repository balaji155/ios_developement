//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 18/08/25.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section {
        case main
    }
    var followers: [Follower] = []
    var userName: String?
    var followersCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var page = 1
    var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(userName: userName!,page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        followersCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UIHelperClass.createThreeGridCollectionFlowLayout(in: view)
        )
        view.addSubview(followersCollectionView)
        followersCollectionView.delegate = self
        followersCollectionView.backgroundColor = .systemBackground
        followersCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            followersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            followersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            followersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            followersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        followersCollectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers(userName: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dissmissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty {
                    let message = "This User doesn't have followers.Please follow them 😃."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                }
                self.updateFollowers()
            case .failure(let error):
                self.presentAlertVCOnMainThread(alertTitle: "Bad things happens", message: error.rawValue, buttonText: "Ok")
            }
            
            
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: followersCollectionView ) { collectionView, indexPath, follower -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        }
    }
    
    func updateFollowers(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.height
        
        if offsetY > contentHeight - screenHeight {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(userName: userName!,page: page)
        }
    }
}


