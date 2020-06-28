//
//  Bundle+Extension.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw "Failed to locate \(file) in bundle."
        }

        guard let data = try? Data(contentsOf: url) else {
            throw "Failed to load \(file) from bundle."
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            throw "Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)"
        } catch DecodingError.typeMismatch(_, let context) {
            throw "Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)"
        } catch DecodingError.valueNotFound(let type, let context) {
            throw "Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)"
        } catch DecodingError.dataCorrupted(_) {
            throw "Failed to decode \(file) from bundle because it appears to be invalid JSON"
        } catch {
            throw "Failed to decode \(file) from bundle: \(error.localizedDescription)"
        }
    }
}
