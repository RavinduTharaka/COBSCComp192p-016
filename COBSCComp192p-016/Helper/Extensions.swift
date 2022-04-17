//
//  Extensions.swift
//  COBSCComp192p-016
//
//  Created by Ravindu Tharaka Ranathunga on 2022-04-10.
//


import SwiftUI

//Regex Validation As String Extentsions

extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
    var isValidNIC: Bool {
        let nicRegex = "^\\d{9}$"
        let nicTest = NSPredicate(format: "SELF MATCHES %@", nicRegex)
        let isValidNIC = nicTest.evaluate(with: self)
        return isValidNIC
    }
}




