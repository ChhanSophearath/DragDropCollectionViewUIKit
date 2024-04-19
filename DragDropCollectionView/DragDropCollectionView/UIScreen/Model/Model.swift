//
//  Model.swift
//  DragDropCollectionView
//
//  Created by Rath! on 19/4/24.
//

import Foundation
import UIKit



struct TitleImageModel: Codable {
    let imageData: Data
    let title: String

    var image: UIImage? {
        return UIImage(data: imageData)
    }

    init(image: UIImage, title: String) {
        self.imageData = image.pngData() ?? Data()
        self.title = title
    }

    private enum CodingKeys: String, CodingKey {
        case imageData
        case title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageData = try container.decode(Data.self, forKey: .imageData)
        title = try container.decode(String.self, forKey: .title)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(title, forKey: .title)
    }
}
