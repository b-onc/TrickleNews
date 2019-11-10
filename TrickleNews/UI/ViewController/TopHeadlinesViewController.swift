//
//  ViewController.swift
//  TrickleNews
//
//  Created by Bahadir Oncel on 10.11.2019.
//  Copyright © 2019 Piyuv OU. All rights reserved.
//

import UIKit

class TopHeadlinesViewController: UIViewController {
    private let topHeadlinesViewModel: TopHeadlinesViewModel
    
    private let flowLayout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView!
    
    private var articles = [Article]()
    
    init(with viewModel: TopHeadlinesViewModel) {
        self.topHeadlinesViewModel = viewModel
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        flowLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        topHeadlinesViewModel.firstArticleSet { [weak self] (articles) in
            self?.articles += articles
            self?.collectionView.reloadData()
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.identifier)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TopHeadlinesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO open detail view
    }
}

extension TopHeadlinesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.identifier, for: indexPath) as? ArticleCollectionViewCell else {
            fatalError("ArticleCollectionViewCell is not registered for collection view!")
        }
        cell.configure(for: articles[indexPath.row])
        if indexPath.row == articles.count - 1 {
            topHeadlinesViewModel.nextArticleSet { [weak self] (articles) in
                self?.articles += articles
                self?.collectionView.reloadData()
            }
        }
        return cell
    }
}

extension TopHeadlinesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        
        func getHeight(for width: CGFloat) -> CGFloat {
            return width * 9.0/16.0 + 100
        }
        
        if indexPath.row % 7 == 0 {
            let width = collectionViewWidth - 8 * 2
            return CGSize(width: width, height: getHeight(for: width))
        } else {
            if traitCollection.verticalSizeClass == .compact {
                let width = floor((collectionViewWidth - 8 * 4) / 3)
                return CGSize(width: width, height: getHeight(for: width))
            } else {
                let width = floor((collectionViewWidth - 8 * 3) / 2)
                return CGSize(width: width, height: getHeight(for: width))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
