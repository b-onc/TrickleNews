//
//  Array+elementAt.swift
//  TrickleNews
//
//  Created by Bahadir Oncel on 6.11.2019.
//  Copyright © 2019 Piyuv OU. All rights reserved.
//

import Foundation

extension Array {
    func element(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
}
