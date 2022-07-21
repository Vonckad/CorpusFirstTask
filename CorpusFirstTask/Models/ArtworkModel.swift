//
//  ArtworkModel.swift
//  CorpusFirstTask
//
//  Created by Vlad Ralovich on 21.07.22.
//

import Foundation

struct ArtworkModel: Codable {
    var id: Int
    var lang_id: Int
    var point: Point
    var point_name: String
    var visible: Bool
}

struct Point: Codable {
    var id: Int
    var point_district_id: Int
    var water_object_id: Int
    var point_geo_type: String
    var lat: Float
    var lng: Float
    var lat_2: Float?
    var lng_2: Float?
    var visible: Bool
}

/*
         "id": 1,
         "lang_id": 1,
         "point": {
             "id": 1,
             "point_district_id": 1,
             "water_object_id": 1,
             "point_geo_type": "Line",
             "lat": 51.6052,
             "lng": 30.5161,
             "lat_2": 51.5945,
             "lng_2": 30.5077,
             "visible": true
         },
         "point_name": "<p>Асарэвічы, Асарэвіцкі старык (Грушка &ndash; мясцовая назва). Ад выхаду з Асарэвіцкага старыка ўніз па цячэнні (мясцовая назва Грушка)</p>",
         "visible": true
 */
