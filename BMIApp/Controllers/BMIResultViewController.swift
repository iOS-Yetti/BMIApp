//
//  BMIResultViewController.swift
//  BMIApp
//
//  Created by 예찬 on 11/23/23.
//

import UIKit

final class BMIResultViewController: UIViewController {
    var bmi: BMI?
    
    private let topResultLabel: UILabel = {
        let label = UILabel()
        label.text = "BMI 결과값"
        label.textAlignment = .center
        return label
    }()
    
    private let bmiNumberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    private let adviceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var recalculateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.setTitle("다시 계산하기", for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(recalculateButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraint()
        getBMIResult()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray5
        
        topResultLabel.translatesAutoresizingMaskIntoConstraints = false
        adviceLabel.translatesAutoresizingMaskIntoConstraints = false
        bmiNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        recalculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(recalculateButton)
        
        stackView.addArrangedSubview(topResultLabel)
        stackView.addArrangedSubview(bmiNumberLabel)
        stackView.addArrangedSubview(adviceLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            
            bmiNumberLabel.heightAnchor.constraint(equalToConstant: 50),
        
            recalculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recalculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recalculateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            recalculateButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func getBMIResult() {
        bmiNumberLabel.text = "\(bmi?.bmiValue ?? 0.0)"
        bmiNumberLabel.backgroundColor = bmi?.bmiColor
        adviceLabel.text = bmi?.bmiAdvice
    }
    
//    func showBMIResult() {
//        guard let bmi = bmi else { return }
//        bmiNumberLabel.text = String(bmi)
//        bmiNumberLabel.backgroundColor = showBMIColor().0
//        adviceLabel.text = showBMIColor().1
//    }
    
    @objc private func recalculateButtonTapped() {
        dismiss(animated: true)
    }
}
