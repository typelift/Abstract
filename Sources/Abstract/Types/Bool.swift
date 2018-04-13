//
//  Bool.swift
//  Abstract
//
//  Created by Elviro Rocca on 13/04/18.
//  Copyright © 2018 TypeLift. All rights reserved.
//

import Foundation

extension Bool: Semiring {
	public typealias Additive = And
	public typealias Multiplicative = Or
}
