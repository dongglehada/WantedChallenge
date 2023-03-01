//
//  MyTableViewCell.swift
//  WantedChallenge
//
//  Created by SeoJunYoung on 2023/02/17.
//

import UIKit

final class MyTableViewCell: UITableViewCell {

    var urlArray: [UrlData] = []
    
    var dataManager = DataManager()
    
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let loadButton: UIButton = {
        let load = UIButton()
        load.setTitle("Load", for: .normal)
        load.backgroundColor = .link
        load.layer.cornerRadius = 3
        return load
    }()

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution  = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupStackView()
        
    }
    
    func setupStackView() {
        
        self.addSubview(mainImageView)
        
        // 뷰컨트롤러의 기본뷰 위에 스택뷰 올리기
        self.addSubview(stackView)
        stackView.addSubview(loadButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 오토레이아웃 정하는 정확한 시점
    override func updateConstraints() {
        setupData()
        setMainImageViewConstraints()
        setloadButtonConstraints()
        setStackViewConstraints()
        super.updateConstraints()
    }

    
    func setMainImageViewConstraints() {
        
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 100),
            mainImageView.widthAnchor.constraint(equalToConstant: 133),
            
            // self.leadingAnchor로 잡는 것보다 self.contentView.leadingAnchor로 잡는게 더 정확함 ⭐️
            // (cell은 기본뷰로 contentView를 가지고 있기 때문)
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            mainImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setloadButtonConstraints() {
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        loadButton.addTarget(self, action: #selector(loadButtonTapped(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loadButton.heightAnchor.constraint(equalToConstant: 40),
            loadButton.widthAnchor.constraint(equalToConstant: 80),
            loadButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            loadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            
            // self.trailingAnchor로 잡는 것보다 self.contentView.trailingAnchor로 잡는게 더 정확함 ⭐️
            // (cell은 기본뷰로 contentView를 가지고 있기 때문)
            stackView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.mainImageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor)
        ])
    }
    func setupData(){
        dataManager.makeUrlArray()
        urlArray = dataManager.getUrlArray()
    }
    
    @objc func loadButtonTapped(_ sender: UIButton){
        mainImageView.image = UIImage(systemName: "photo")
        mainImageView.load(url: urlArray[sender.tag].url!)
    }
    
}
