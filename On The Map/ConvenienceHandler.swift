//
//  ConvenienceHandler.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/24/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    // Get Session ID, User ID, Success of Login
    func loginFunc(_ completionHandlerForLogin: @escaping (_ success: Bool, _ sessionID: String?, _ errorString: String?) -> Void) {
        
        let _ = taskForPostMethod() { (results, error) in
            
            if let error = error {
                print(error)
                completionHandlerForLogin(false, nil, error.localizedDescription)
            } else if let results = results {
                //Check Acct Info
                guard let account = results["account"] as? [String:AnyObject] else {
                    print("There is an problem with your account information.")
                    return
                }
                //Get Key
                guard let uniqueKey = account["key"] as? String else {
                    print("There is a problem with your user ID.")
                    return
                }
                //Get Session Info
                guard let sessionInfo = results["session"] as? [String:AnyObject] else {
                    print("There is a problem with your session dictionary.")
                    return
                }
                //Get Session ID
                guard let session = sessionInfo["id"] as? String else {
                    print("There is a problem with your session ID.")
                    return
                }
                
                Constants.SessionInfo.sessionID = session
                Constants.LoginInformation.uniqueKey = uniqueKey
            
                completionHandlerForLogin(true, session, nil)
            }
        
        }
    
    }
    
    func facebookLoginFunc(_ completionHandlerForFacebookLoginFunc: @escaping (_ success: Bool, _ sessionID: String?, _ errorString: String?) -> Void) {
        let _ = taskForPostFacebookSession(){ (results, error) in
            if let error = error{
                print(error)
                completionHandlerForFacebookLoginFunc(false, nil, "Udacity/Facebook Login Failed")
            } else if let results = results {
                //Check Acct Info
                guard let account = results["account"] as? [String:AnyObject] else {
                    print("There is an problem with your account information.")
                    return
                }
                //Get Key
                guard let uniqueKey = account["key"] as? String else {
                    print("There is a problem with your user ID.")
                    return
                }
                //Get Session Info
                guard let sessionInfo = results["session"] as? [String:AnyObject] else {
                    print("There is a problem with your session dictionary.")
                    return
                }
                //Get Session ID
                guard let session = sessionInfo["id"] as? String else {
                    print("There is a problem with your session ID.")
                    return
                }
                
                Constants.SessionInfo.sessionID = session
                Constants.LoginInformation.uniqueKey = uniqueKey
                
                completionHandlerForFacebookLoginFunc(true, session, nil)
            }
        }
    }
    
    func logOutFunc(_ completionHandlerForLogOut: @escaping (_ success: Bool, _ sessionID: String?, _ errorString: String?) -> Void) {
        
        let _ = taskForDeleteMethod() { (results, error) in
            if let error = error {
                print(error)
                completionHandlerForLogOut(false, nil, "LogOut Failed.")
            } else if let results = results {
                
                //Get Session Info
                guard let sessionInfo = results["session"] as? [String:AnyObject] else {
                    print("There is a problem with your session dictionary.")
                    return
                }
                //Get Session ID
                guard let session = sessionInfo["id"] as? String else {
                    print("There is a problem with your session ID.")
                    return
                }
                
                completionHandlerForLogOut(true, session, nil)
                
                
            }
        }
    }
    
    func fetchUserData(_ completionHandlerForFetchUserData: @escaping (_ success: Bool,_ errorString: String?) -> Void) {
        
        let _ = taskForGetMethod() { (results, error) in
            if let error = error {
                print(error)
                completionHandlerForFetchUserData(false, "Failed to fetch User Data Udacity API")
            } else if let results = results {
                guard let userInfo = results["user"]  as? [String:AnyObject?] else {
                    print("user Info Not available")
                    return
                }
                
                guard let firstName = userInfo["first_name"] as? String else {
                    return
                }
                guard let secondName = userInfo["last_name"] as? String else {
                    return
                }
                
                Constants.myStudentData.firstName = firstName
                Constants.myStudentData.secondName = secondName
                
                completionHandlerForFetchUserData(true, nil)
            }
            
        }
    }
}
