//
//  ViewController.swift
//  Bookly - Free Ebooks
//
//  Created by Akshansh Thakur on 26/07/20.
//  Copyright © 2020 Akshansh Thakur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var bookDetailDataSource = [BookDetail]()
    
    var titles = [
        "The Jungle Book",
        "King Kong",
        "Grand Delusions : A Short of Biography of Kolkata",
        "Harry Potter And The Goblet Of Fire",
        "Batman: The Dark Night Rises"
    ]
    
    var authors = [
        "Rudyard Kipling",
        "Merian C. Cooper ",
        "Indrajit Hazare",
        "J.K. Rowling",
        "Greg Cox"
    ]
    
    var ratings = [
        "4.5 (1823)",
        "4.9 (456)",
        "4.6 (122)",
        "4.3 (3231)",
        "4.1 (981)"
    ]
    
    var prices = [
        "19.50",
        "14.95",
        "19.99",
        "11.99",
        "23.99"
    ]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var leftTitle: UIImageView!
    @IBOutlet weak var centerTitle: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (1..<6).forEach {
            bookDetailDataSource.append(
                BookDetail(imageName: "book\($0)_image", title: titles[$0 - 1], author: authors[$0 - 1], rating: ratings[$0 - 1], price: prices[$0 - 1]
            ))
            
        }
        
        centerTitle.alpha = 0.0
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BookReusableView", for: indexPath) as! BookReusableView
            
            reusableView.setupViews()
            
            return reusableView
            
        default:
            assert(false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 400.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailCell", for: indexPath) as! BookDetailCell
        
        cell.imageView.image = UIImage(named: bookDetailDataSource[indexPath.row].imageName)
        cell.title.text = bookDetailDataSource[indexPath.row].title
        cell.author.text = bookDetailDataSource[indexPath.row].author
        cell.rating.text = bookDetailDataSource[indexPath.row].rating
        cell.price.text = bookDetailDataSource[indexPath.row].price + " £"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookDetailDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 48.0, height: 170.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 24.0, bottom: 80.0, right: 24.0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        
        if offset > 10 {
            
            UIView.animate(withDuration: 0.5) {
                self.centerTitle.alpha = 1.0
                self.leftTitle.alpha = 0.0
                self.searchButton.alpha = 0.0
                
            }
            
        } else {
            UIView.animate(withDuration: 0.5) {
                self.centerTitle.alpha = 0.0
                self.leftTitle.alpha = 1.0
                self.searchButton.alpha = 1.0
            }
        }
        
    }
    
}

struct BookDetail {
    var imageName: String
    var title: String
    var author: String
    var rating: String
    var price: String
}

class BookDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var price: UILabel!
    
}

class BookCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
}


class BookReusableView: UICollectionReusableView {
    
    @IBOutlet weak var bookHorizontalCollectionView: UICollectionView!
    
    struct Book {
        var imageName: String
    }
    
    var bookDataSource = [Book]()
    var animationOngoing = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupViews() {
        
        bookHorizontalCollectionView.bounces = false
        
        if bookDataSource.isEmpty {
            (1..<6).forEach { bookDataSource.append(Book(imageName: "book\($0)_image")) }
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            bookHorizontalCollectionView.collectionViewLayout = layout
            
            bookHorizontalCollectionView.dataSource = self
            bookHorizontalCollectionView.delegate = self
        }
        
    }
    
}

extension BookReusableView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        
        cell.imageView.image = UIImage(named: bookDataSource[indexPath.row].imageName)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180.0, height: 270.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
}
