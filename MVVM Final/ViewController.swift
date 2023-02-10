//
//  ViewController.swift
//  MVVM Final
//
//  Created by Ekambaram E on 12/14/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    let viewModel = UserViewModel(apiService: APIManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewModelDelegate = self
        viewModel.fetchUserInfo()
    }
}

extension ViewController: UserViewModelProtocol {
  
    func updateSuccessResponse(userResponse: UserResponseModel) {
        print(userResponse.data?.count ?? 0)
    }
    
    func updateFailureResponse(error: Error) {
        print(error)
    }
}

