//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by Jaehui Yu on 4/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BoxOfficeViewController: UIViewController {
    
    let viewModel = BoxOfficeViewModel()
    
    let bag = DisposeBag()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        datePicker.date = yesterday
        datePicker.maximumDate = yesterday
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        bind()
    }
    
    func configure() {
        view.addSubview(datePicker)
        view.addSubview(tableView)
        
        datePicker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind() {
        let selectedDate = datePicker.rx.date
        let input = BoxOfficeViewModel.Input(selectedDate: selectedDate)
        
        let output = viewModel.transform(input: input)
        output.boxOfficeSubject
            .debug()
            .bind(to: tableView.rx.items(cellIdentifier: BoxOfficeTableViewCell.identifier, cellType: BoxOfficeTableViewCell.self)) { (row, element, cell) in
                cell.rankLabel.text = element.rank
                cell.movieTitleLabel.text = element.movieNm
                cell.openDateLabel.text = element.openDt
            }.disposed(by: bag)
    }
}
