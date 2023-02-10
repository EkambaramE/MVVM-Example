//
//  MVVM_FinalTests.swift
//  MVVM FinalTests
//
//  Created by Ekambaram E on 12/14/22.
//

import XCTest
@testable import MVVM_Final

final class MVVM_FinalTests: XCTestCase {
    
    // View Model
    var viewModel: UserViewModel?
    // Api Service class
    var apiService: MockAPIResponseManager?
    // Update View model to controller delegate
    var mockViewModelDelegate: MockViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewModelDelegate = MockViewModel()
        
        apiService = MockAPIResponseManager()
        viewModel = UserViewModel(apiService: apiService!)
        
        viewModel?.viewModelDelegate = mockViewModelDelegate
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        apiService = nil
        mockViewModelDelegate = nil
    }
    
    func testSuccess() throws {
        
        //Given
        let userData = UserResponseModel(data: [Users(email: "eka@gmail.com", firstName: "Ekambaram", lastName: "Eswaran")])
        apiService?.result = .success(userData)
        
        //When
        viewModel?.fetchUserInfo()
        
        //Then
        XCTAssertNotNil(mockViewModelDelegate?.users)
        XCTAssertEqual(mockViewModelDelegate?.users.count, 1)
        XCTAssertEqual(mockViewModelDelegate?.users[0].lastName, "Eswaran")
        XCTAssertEqual(mockViewModelDelegate?.users[0].firstName, "Ekambaram")
        XCTAssertEqual(mockViewModelDelegate?.users[0].email, "eka@gmail.com")
    }
    
    func testFailure() throws {
        
        //Given
        apiService?.result = .failure(NSError())
        
        //when
        viewModel?.fetchUserInfo()
        
        //Then
        XCTAssertEqual(mockViewModelDelegate?.users.count, 0)
    }
}

class MockViewModel: UserViewModelProtocol {
    
    var users: [Users] = []
    
    func updateSuccessResponse(userResponse: MVVM_Final.UserResponseModel) {
        self.users = userResponse.data ?? []
    }
    
    func updateFailureResponse(error: Error) {
        self.users = []
    }
}

class MockAPIResponseManager: APIManagerProtocol {
    
    var result: Result<Any, Error>?
    
    func fetch<T>(urlString: String, model: T.Type, completion: @escaping (Result<Any, Error>) -> Void) where T : Decodable, T : Encodable {
        if let result {
            completion(result)
        }
    }
}
