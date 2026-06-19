//
//  ScriptUtils.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import Foundation

struct ScriptUtils {
    static func loadExtractScript(for name: String) -> String? {
        guard let url = Bundle.main.url(forResource: "\(name)ExtractScript", withExtension: "js"),
              let code = try? String(contentsOf: url, encoding: .utf8) else {
            print("无法加载js文件")
            return nil
        }
        return code
    }
}
