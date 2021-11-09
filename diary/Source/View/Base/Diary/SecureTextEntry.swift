//
//  SecureTextEntry.swift
//  diary
//
//  Created by 김부성 on 2021/11/09.
//

import RxSwift
import UIKit

class SecureTextEntry: UIView {
    
    let disposeBag = DisposeBag()
    let subject = PublishSubject<NumberButtonType>()
    let currentText = PublishSubject<String>()
    
    fileprivate struct Metric {
        static let dotSize = 16.f
    }
    
    var arr = [Int]()
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let dot1 = UIView().then {
        $0.backgroundColor = R.color.passcodeDotLight()
        $0.layer.cornerRadius = Metric.dotSize / 2
    }
    
    let dot2 = UIView().then {
        $0.backgroundColor = R.color.passcodeDotLight()
        $0.layer.cornerRadius = Metric.dotSize / 2
    }

    let dot3 = UIView().then {
        $0.backgroundColor = R.color.passcodeDotLight()
        $0.layer.cornerRadius = Metric.dotSize / 2
    }
    
    let dot4 = UIView().then {
        $0.backgroundColor = R.color.passcodeDotLight()
        $0.layer.cornerRadius = Metric.dotSize / 2
    }
    
    init() {
        super.init(frame: .zero)
        
        self.stackView.addArrangedSubview(dot1)
        self.stackView.addArrangedSubview(dot2)
        self.stackView.addArrangedSubview(dot3)
        self.stackView.addArrangedSubview(dot4)
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        self.subject
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                switch response {
                case let .number(number):
                    if self.arr.count < 4 {
                        self.arr.append(number)
                    } else {
                        //
                    }
                case .backspace:
                    if self.arr.count >= 1 {
                        self.arr.removeLast()
                    }
                case .clear:
                    if self.arr.count >= 1 {
                        self.arr.removeAll()
                    }
                }
                self.updateDot()
                
                if self.arr.count >= 4 {
                    let text = self.arr.map { String($0) }.reduce("", +)
                    self.currentText.onNext(text)
                    self.arr.removeAll()
                    self.updateDot()
                }
            }).disposed(by: disposeBag)
    }
    
    func updateDot() {
        UIView.animate(withDuration: 0.1) {
            switch self.arr.count {
            case 0:
                self.dot1.backgroundColor = R.color.passcodeDotLight()
                self.dot2.backgroundColor = R.color.passcodeDotLight()
                self.dot3.backgroundColor = R.color.passcodeDotLight()
                self.dot4.backgroundColor = R.color.passcodeDotLight()
            case 1:
                self.dot1.backgroundColor = R.color.passcodeDotDark()
                self.dot2.backgroundColor = R.color.passcodeDotLight()
                self.dot3.backgroundColor = R.color.passcodeDotLight()
                self.dot4.backgroundColor = R.color.passcodeDotLight()
            case 2:
                self.dot1.backgroundColor = R.color.passcodeDotDark()
                self.dot2.backgroundColor = R.color.passcodeDotDark()
                self.dot3.backgroundColor = R.color.passcodeDotLight()
                self.dot4.backgroundColor = R.color.passcodeDotLight()
            case 3:
                self.dot1.backgroundColor = R.color.passcodeDotDark()
                self.dot2.backgroundColor = R.color.passcodeDotDark()
                self.dot3.backgroundColor = R.color.passcodeDotDark()
                self.dot4.backgroundColor = R.color.passcodeDotLight()
            case 4:
                self.dot1.backgroundColor = R.color.passcodeDotDark()
                self.dot2.backgroundColor = R.color.passcodeDotDark()
                self.dot3.backgroundColor = R.color.passcodeDotDark()
                self.dot4.backgroundColor = R.color.passcodeDotDark()
            default:
                return
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(self.stackView)

        self.stackView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }

        self.dot1.snp.makeConstraints { make in
            make.width.equalTo(Metric.dotSize)
            make.height.equalTo(Metric.dotSize)
        }

        self.dot2.snp.makeConstraints { make in
            make.width.equalTo(Metric.dotSize)
            make.height.equalTo(Metric.dotSize)
        }

        self.dot3.snp.makeConstraints { make in
            make.width.equalTo(Metric.dotSize)
            make.height.equalTo(Metric.dotSize)
        }

        self.dot4.snp.makeConstraints { make in
            make.width.equalTo(Metric.dotSize)
            make.height.equalTo(Metric.dotSize)
        }
    }
}

