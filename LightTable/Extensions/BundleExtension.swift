//
//  BundleExtension.swift
//  LightTable
//
//  Created by 空白 on 2026/7/5.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var fullVersionString: String {
        let version = releaseVersionNumber ?? "1.0.0"
        let build = buildVersionNumber ?? "1"
        return "\(version) (\(build))"
    }
}
