//
//  UserViewModel.swift
//  MVVM Final
//
//  Created by Ekambaram E on 12/14/22.
//

import Foundation

protocol UserViewModelProtocol: AnyObject {
    func updateSuccessResponse(userResponse: UserResponseModel)
    func updateFailureResponse(error: Error)
}

class UserViewModel {

    var apiService: APIManagerProtocol
    weak var viewModelDelegate: UserViewModelProtocol!
    
    init(apiService: APIManagerProtocol) {
        self.apiService = apiService
    }
    
    func fetchUserInfo() {
        self.apiService.fetch(urlString: "https://reqres.in/api/users", model: UserResponseModel.self) { result in
            switch result {
            case .success(let response):
                if let userModel = response as? UserResponseModel {
                    self.viewModelDelegate.updateSuccessResponse(userResponse: userModel)
                }
            case .failure(let error):
                self.viewModelDelegate.updateFailureResponse(error: error)
            }
        }
    }
    
}
