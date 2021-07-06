//
//  RegisterViewController.swift
//  View4U
//
//  Created by admin on 06/07/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTapView(_ sender: Any) {
        self.view.endEditing(true)
    }
}
