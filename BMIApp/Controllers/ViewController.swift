//
//  ViewController.swift
//  BMIApp
//
//  Created by 예찬 on 11/23/23.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Property Closure
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "키와 몸무게를 입력해 주세요"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "키"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "몸무게"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " cm단위로 입력해주세요"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " kg단위로 입력해주세요"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.keyboardType = .decimalPad
        textField.addDoneToolbar()
        return textField
    }()
    
    private lazy var calculateBMIButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitle("BMI 계산하기", for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(calculateBMIButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    private let heightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .fill
        return stackView
    }()
    
    private let weightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - Property
    private var bmiManager = BMICalculatorManager()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraint()
        configureTextField()
    }
    
    // MARK: - Method
    private func configureUI() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        heightStackView.translatesAutoresizingMaskIntoConstraints = false
        weightStackView.translatesAutoresizingMaskIntoConstraints = false
        calculateBMIButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemGray5
        
        view.addSubview(stackView)
        view.addSubview(calculateBMIButton)
        
        heightStackView.addArrangedSubview(heightLabel)
        heightStackView.addArrangedSubview(heightTextField)
        
        weightStackView.addArrangedSubview(weightLabel)
        weightStackView.addArrangedSubview(weightTextField)
        
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(heightStackView)
        stackView.addArrangedSubview(weightStackView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            calculateBMIButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            calculateBMIButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calculateBMIButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calculateBMIButton.heightAnchor.constraint(equalToConstant: 45),
            
            heightLabel.widthAnchor.constraint(equalToConstant: 40),
            weightLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureTextField() {
        heightTextField.delegate = self
        weightTextField.delegate = self
    }
    
    private func calculateBMIButtonAlert() {
        let alertController = UIAlertController(title: "키와 몸무게를 입력해주세요.",
                                                message: nil,
                                                preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    private func removeTextFieldText() {
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    // MARK: - objc Method
    @objc private func calculateBMIButtonTapped() {
        guard heightTextField.text != "" && weightTextField.text != "" else {
            calculateBMIButtonAlert()
            return
        }
        guard let height = heightTextField.text,
              let weight = weightTextField.text else { return }
        
        let bmiResultVC = BMIResultViewController()
        
        bmiManager.calculateBMI(height: height,weight: weight)
        bmiResultVC.bmi = bmiManager.getBMI(height: height, weight: weight)
        bmiResultVC.modalPresentationStyle = .fullScreen
        
        present(bmiResultVC, animated: true)
        removeTextFieldText()
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // 백스페이스로 지울 때도 호출 되기 때문에 string == ""까지 조건에 있어야 한다.
        guard Int(string) != nil || string == "." || string == "" else { return false }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightTextField.text != "" && weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}
