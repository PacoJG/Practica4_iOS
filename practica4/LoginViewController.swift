//
//  LoginViewController.swift
//  practica4
//
//  Created by Francisco Jaime on 11/06/22.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    var ai = UIActivityIndicatorView()
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBAction func btnLoginAction(_ sender: Any) {
        ai.startAnimating()
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            if error != nil{
                let alert = UIAlertController(title: "", message: "Ocurrio un error\(error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                DispatchQueue.main.async {
                    self.ai.stopAnimating()
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    self.ai.stopAnimating()
                    self.performSegue(withIdentifier: "goHome", sender: nil)
                }
            }
        }
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let alert = UIAlertController(title: "Crear cuenta" , message: "Ingresa tus datos", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
        // agregar text fields a un alert
        alert.addTextField(configurationHandler: { txtEmail in
            txtEmail.placeholder = "Correo electrónico"
            txtEmail.clearButtonMode = .always
        })
        
        alert.addTextField(configurationHandler: { txtPass in
            txtPass.placeholder = "Password"
            txtPass.clearButtonMode = .always
            txtPass.isSecureTextEntry = true
        })
        
        let btnEnviar = UIAlertAction(title: "Enviar" , style: .default , handler: {action in
            
            guard let email = alert.textFields![0].text ,
            let pass  = alert.textFields![1].text
            else { return }
            self.ai.startAnimating()
            Auth.auth().createUser(withEmail: email, password: pass, completion: { auth , error in
                if error != nil {
                    print ("ocurrió un error \(String(describing: error))")
                    self.ai.stopAnimating()
                }
                self.performSegue(withIdentifier: "goHome", sender: nil)
            })
            
        })
        alert.addAction(btnEnviar)
        self.present(alert, animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ai.style = .large
        ai.color = .red
        ai.hidesWhenStopped = true
        ai.center = self.view.center
        self.view.addSubview(ai)
        emailTextField.setupLeftImageView(image: UIImage(named: "mail")!)
        passwordTextField.setupLeftImageView(image: UIImage(named: "lock")!)
    }
        
}
