//
//  UserDetailsViewModel.swift
//  lydia
//
//  Created by Mohamed Tolba Sayed on 07/02/2021.
//

import Foundation

class UserDetailsViewModel {
    
    /**
     *  Function returning cell information need for stackview items
     */
    func getDataCellList(user: User?) -> [UserDetailsDataCell] {
        var cells: [UserDetailsDataCell] = []
        cells.append(UserDetailsDataCell(labelTitle: "Age", labelInfo: getFullBirth(user: user)))
        cells.append(UserDetailsDataCell(labelTitle: "Gender", labelInfo: getGender(user: user)))
        cells.append(UserDetailsDataCell(labelTitle: "Email", labelInfo: getEmail(user: user)))
        cells.append(UserDetailsDataCell(labelTitle: "Phone", labelInfo: getPhone(user: user)))
        cells.append(UserDetailsDataCell(labelTitle: "Cell phone", labelInfo: getCellPhone(user: user)))
        cells.append(UserDetailsDataCell(labelTitle: "Street", labelInfo: getStreet(user: user)))
        cells.append(UserDetailsDataCell(labelTitle: "City", labelInfo: getCity(user: user)))
        cells.append(UserDetailsDataCell(labelTitle: "Country", labelInfo: getCountry(user: user)))
        return cells
    }
    
    /**
     *  Function returning string with the age of user else "--"
     */
    func getAge(user: User?) -> String {
        let age = user?.birthday?.age ?? -1
        if age == -1 {
            return "--"
        } else {
            return "\(age) ans"
        }
    }
    
    /**
     *  Function returning string with the  birthdate of user else "--"
     */
    func getBirthdate(user: User?) -> String {
        guard let date = user?.birthday?.date else {
            return "--"
        }
        let convertedDate = date.toDate()
        return convertedDate?.toString() ?? "--"
    }
    
    /**
     *  Function returning string with age and birthdate concatenate
     */
    func getFullBirth(user: User?) -> String {
        return "\(getAge(user: user)) | \(getBirthdate(user: user))"
    }
    
    /**
     *  Function returning string with the gender of user else "--"
     */
    func getGender(user: User?) -> String {
        return user?.gender ?? "--"
    }
    
    /**
     *  Function returning string with the email of user else "--"
     */
    func getEmail(user: User?) -> String {
        return user?.email ?? "--"
    }
    
    /**
     *  Function returning string with the phone number of user else "--"
     */
    func getPhone(user: User?) -> String {
        return user?.phone ?? "--"
    }
    
    /**
     *  Function returning string with the cellPhone number of user else "--"
     */
    func getCellPhone(user: User?) -> String {
        return user?.cell ?? "--"
    }
    
    /**
     *  Function returning string with the street of user else "--"
     */
    func getStreet(user: User?) -> String {
        let streetNumber = user?.location?.street?.number ?? -1
        var streetNumberString = "--"
        if streetNumber != -1 {
            streetNumberString = "\(streetNumber)"
        }
        return "\(streetNumberString) \(user?.location?.street?.name ?? "unknown")"
    }
    
    /**
     *  Function returning string with the city of user else "--"
     */
    func getCity(user: User?) -> String {
        return user?.location?.city ?? "--"
    }
    
    /**
     *  Function returning string with the country of user else "--"
     */
    func getCountry(user: User?) -> String {
        return "\(user?.location?.country ?? "--") (\(getNationality(user: user)))"
    }
    
    /**
     *  Function returning string with the nationality iso code of user else "--"
     */
    func getNationality(user: User?) -> String {
        return user?.nat ?? "--"
    }
    
}
