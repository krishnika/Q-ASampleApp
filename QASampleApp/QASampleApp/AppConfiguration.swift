//
//  AppConfiguration.swift
//  QASampleApp
//
//  Created by krishnika agarwal on 17/12/16.
//  Copyright © 2016 krishnika agarwal. All rights reserved.
//

import Foundation

struct Pagination {
    var startPage = 0
    var pageSize = 30
    var currentCount = 0
    var totalCount = 0
    
    var isLoadingFirstPage = false
}
