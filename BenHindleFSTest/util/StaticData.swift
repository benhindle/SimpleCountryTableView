//
//  StaticData.swift
//  BenHindleFSTest
//
//  Created by Ben Hindle on 1/4/2022.
//

import Foundation

struct StaticData {
    static let locations = ["Afghanistan", "Albania", "Algeria","Andorra","Angola","Argentina","Armenia","Aruba","Australia","Austria","Azer baijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize"," Benin","Bermuda","Bhutan","Bolivia","Botswana","Brazil","Bulgaria","Burundi","Camb odia","Cameroon","Canada","Chad","Chile","China","Colombia","Comoros","Congo"," Croatia","Cuba","Cyprus","Denmark","Djibouti","Dominica"].map { $0.trimmingCharacters(in: .whitespaces) }.sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
    
}
