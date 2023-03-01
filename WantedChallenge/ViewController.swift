//
//  ViewController.swift
//  WantedChallenge
//
//  Created by SeoJunYoung on 2023/02/17.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    var urlArray: [UrlData] = []
    
    var dataManager = DataManager()
    
    var cell = MyTableViewCell()
    
    var buttonState:Bool = false
    
    var count:Int = 0
    
    let allLoadButton:UIButton = {
       let ab = UIButton()
        ab.translatesAutoresizingMaskIntoConstraints = false
        ab.setTitle("Load All Images", for: .normal)
        ab.backgroundColor = .link
        ab.layer.cornerRadius = 3
        return ab
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupTableView()
        setupTableViewConstraints()
        allLoadButtonConstraints()
    }

    func setupTableView() {
        // 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 110
        
        
        
        // 셀의 등록과정⭐️⭐️⭐️ (스토리보드 사용시에는 스토리보드에서 자동등록)
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.separatorStyle = .none
        
    }
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 110*5)
        ])
    }
    
    
    func allLoadButtonConstraints(){
        view.addSubview(allLoadButton)
        allLoadButton.addTarget(self, action: #selector(allLoadButtonTapped(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            allLoadButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            allLoadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            allLoadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            allLoadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupData(){
        dataManager.makeUrlArray()
        urlArray = dataManager.getUrlArray()
    }
    
    func delData(){
        dataManager.delDataArray()
        urlArray = dataManager.getUrlArray()
    }
        
    @objc func allLoadButtonTapped(_ sender: UIButton) {
        buttonState.toggle()
        tableView.reloadData()
    }
   

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return urlArray.count
    }
    
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // (힙에 올라간)재사용 가능한 셀을 꺼내서 사용하는 메서드 (애플이 미리 잘 만들어 놓음)
        // (사전에 셀을 등록하는 과정이 내부 메커니즘에 존재)
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyTableViewCell
        cell.selectionStyle = .none
        cell.loadButton.tag = indexPath.row
        cell.tag = indexPath.row
        cell.mainImageView.image = UIImage(systemName: "photo")
        cell.contentView.isUserInteractionEnabled = false // 테이블 뷰에서 버튼이 눌리지 않을 때
        
        if buttonState {
            cell.mainImageView.load(url: urlArray[indexPath.row].url!)
            count += 1
            if count == (urlArray.count) {
                buttonState.toggle()
                count = 0
            }
        }
        return cell
        
        
    }
    
   
 

    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            usleep(350000)
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
