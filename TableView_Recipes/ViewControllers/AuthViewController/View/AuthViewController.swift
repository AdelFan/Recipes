//
//  AuthViewController.swift
//  TableView_Recipes
//
//  Created by Адель Ахметшин on 30.11.2022.
//

import UIKit
import SnapKit

final class AuthViewController: UIViewController {
    
    var presenter: AuthViewPresenterProtocol!
    var login = String()
    var password = String()
    
    // MARK: - UI elements
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "WELCOME"
        return label
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Login"
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Password"
        return label
    }()
    
    private let loginTextField: UITextField = {
        let textField =  UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.placeholder = "Enter login"
        textField.becomeFirstResponder()
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField =  UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.placeholder = "Enter password"
        textField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let stripeView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("LOGIN", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("REGISTRATION", for: .normal)
        button.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        EmbedView()
        setupAppearance()
        setupLayout()
    }
    
    // MARK: - Embed View
    private func EmbedView() {
        view.addSubview(welcomeLabel)
        view.addSubview(loginLabel)
        view.addSubview(loginTextField)
        view.addSubview(stripeView)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registrationButton)
    }
    
    // MARK: - Setup appearance
    private func setupAppearance() {
        title = "WELCOME"
        view.backgroundColor = .white
    }
    
    // MARK: - Setup layout
    private func setupLayout() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(111)
            make.centerX.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.leading.equalToSuperview().inset(60)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(60)
        }
        
        stripeView.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(1)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(stripeView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(60)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview().inset(60)
            make.width.equalTo(100)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(80)
            make.trailing.equalToSuperview().inset(60)
            make.width.equalTo(160)
        }
    }
    
    // MARK: - Actions Buttons
    private func accountDataCasting() {
        login = loginTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        password = passwordTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
    }
    
    @objc private func loginButtonTapped() {
        accountDataCasting()
        presenter.loginButtonTapped(view: self, login: login, password: password)
    }
    
    @objc private func registrationButtonTapped() {
        accountDataCasting()
        presenter.registrationButtonTapped(login: login, password: password)
    }
}

// MARK: - AuthViewProtocol
extension AuthViewController: AuthViewProtocol {
    func present(alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func successRegistration() {
        login = ""
        password = ""
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
