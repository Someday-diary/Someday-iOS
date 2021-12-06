//
//  DiaryNumberPad.swift
//  diary
//
//  Created by 김부성 on 2021/11/09.
//

import UIKit
import RxSwift

enum NumberPadType {
    case random
    case normal
}

class DiaryNumberPad: UIView {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Properties
    let currentState = PublishSubject<NumberButtonType>()
    
    // MARK: - UI
    let row1 = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let row2 = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let row3 = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let row4 = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let column = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Initializing
    init(type: NumberPadType) {
        super.init(frame: .zero)
        
        numberInit(type: type)
        
        self.column.addArrangedSubview(row1)
        self.column.addArrangedSubview(row2)
        self.column.addArrangedSubview(row3)
        self.column.addArrangedSubview(row4)
        self.addSubview(self.column)
        
        self.column.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberInit(type: NumberPadType) {
        let sequence = 0..<10
        let randomSeq: [Int]
        
        switch type {
        case .normal:
            randomSeq = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        case .random:
            randomSeq = sequence.shuffled().map { Int($0) }
        }
        
        self.row1.addArrangedSubview(NumberButton(.number(randomSeq[0]), self.currentState))
        self.row1.addArrangedSubview(NumberButton(.number(randomSeq[1]), self.currentState))
        self.row1.addArrangedSubview(NumberButton(.number(randomSeq[2]), self.currentState))
        
        self.row2.addArrangedSubview(NumberButton(.number(randomSeq[3]), self.currentState))
        self.row2.addArrangedSubview(NumberButton(.number(randomSeq[4]), self.currentState))
        self.row2.addArrangedSubview(NumberButton(.number(randomSeq[5]), self.currentState))
        
        self.row3.addArrangedSubview(NumberButton(.number(randomSeq[6]), self.currentState))
        self.row3.addArrangedSubview(NumberButton(.number(randomSeq[7]), self.currentState))
        self.row3.addArrangedSubview(NumberButton(.number(randomSeq[8]), self.currentState))
        
        self.row4.addArrangedSubview(UIView())
        self.row4.addArrangedSubview(NumberButton(.number(randomSeq[9]), self.currentState))
        self.row4.addArrangedSubview(NumberButton(.backspace, self.currentState))
    }
}
