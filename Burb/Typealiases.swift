//
//  Typealiases.swift
//  Burb
//
//  Created by Eugene on 02/10/2019.
//  Copyright © 2019 CC_Eugene. All rights reserved.
//

import Foundation

// typealias StaticCellProtocol = NibLoadable // & HeightContainable
typealias ItemClosure<T> = ((T) -> Void)
typealias OptionalItemClosure<T> = ((T?) -> Void)
typealias VoidClosure = (() -> Void)
//typealias ResultHandler<Value> = (Result<Value>) -> Void
