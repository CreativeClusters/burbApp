//
//  Extension+Encodable.swift
//  Burb
//
//  Created by Eugene on 26.02.2020.
//  Copyright © 2020 CC_Eugene. All rights reserved.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
