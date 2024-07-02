// To parse this JSON data, do
//
//     final iTunesResponse = iTunesResponseFromJson(jsonString);

import 'dart:convert';

ItunesResponse iTunesResponseFromJson(String str) => ItunesResponse.fromJson(json.decode(str));

String iTunesResponseToJson(ItunesResponse data) => json.encode(data.toJson());

class ItunesResponse {
  final int trackCount;
  final List<Track> tracks;

  ItunesResponse({
    required this.trackCount,
    required this.tracks,
  });

  factory ItunesResponse.fromJson(Map<String, dynamic> json) => ItunesResponse(
    trackCount: json["resultCount"],
    tracks: List<Track>.from(json["results"].map((x) => Track.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "resultCount": trackCount,
    "results": List<dynamic>.from(tracks.map((x) => x.toJson())),
  };
}

class Track {
  final String wrapperType;
  final String kind;
  final int artistId;
  final int collectionId;
  final int trackId;
  final String artistName;
  final String collectionName;
  final String trackName;
  final String collectionCensoredName;
  final String trackCensoredName;
  final String artistViewUrl;
  final String collectionViewUrl;
  final String trackViewUrl;
  final String previewUrl;
  final String artworkUrl30;
  final String artworkUrl60;
  final String artworkUrl100;
  final double collectionPrice;
  final double trackPrice;
  final DateTime releaseDate;
  final String collectionExplicitness;
  final String trackExplicitness;
  final int discCount;
  final int discNumber;
  final int trackCount;
  final int trackNumber;
  final int trackTimeMillis;
  final String country;
  final String currency;
  final String primaryGenreName;
  final bool? isStreamable;
  final String? contentAdvisoryRating;

  Track({
    required this.wrapperType,
    required this.kind,
    required this.artistId,
    required this.collectionId,
    required this.trackId,
    required this.artistName,
    required this.collectionName,
    required this.trackName,
    required this.collectionCensoredName,
    required this.trackCensoredName,
    required this.artistViewUrl,
    required this.collectionViewUrl,
    required this.trackViewUrl,
    required this.previewUrl,
    required this.artworkUrl30,
    required this.artworkUrl60,
    required this.artworkUrl100,
    required this.collectionPrice,
    required this.trackPrice,
    required this.releaseDate,
    required this.collectionExplicitness,
    required this.trackExplicitness,
    required this.discCount,
    required this.discNumber,
    required this.trackCount,
    required this.trackNumber,
    required this.trackTimeMillis,
    required this.country,
    required this.currency,
    required this.primaryGenreName,
    this.isStreamable,
    this.contentAdvisoryRating,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    wrapperType: json["wrapperType"],
    kind: json["kind"],
    artistId: json["artistId"],
    collectionId: json["collectionId"],
    trackId: json["trackId"],
    artistName: json["artistName"],
    collectionName: json["collectionName"],
    trackName: json["trackName"],
    collectionCensoredName: json["collectionCensoredName"],
    trackCensoredName: json["trackCensoredName"],
    artistViewUrl: json["artistViewUrl"],
    collectionViewUrl: json["collectionViewUrl"],
    trackViewUrl: json["trackViewUrl"],
    previewUrl: json["previewUrl"],
    artworkUrl30: json["artworkUrl30"],
    artworkUrl60: json["artworkUrl60"],
    artworkUrl100: json["artworkUrl100"],
    collectionPrice: json["collectionPrice"]?.toDouble(),
    trackPrice: json["trackPrice"]?.toDouble(),
    releaseDate: DateTime.parse(json["releaseDate"]),
    collectionExplicitness: json["collectionExplicitness"],
    trackExplicitness: json["trackExplicitness"],
    discCount: json["discCount"],
    discNumber: json["discNumber"],
    trackCount: json["trackCount"],
    trackNumber: json["trackNumber"],
    trackTimeMillis: json["trackTimeMillis"],
    country: json["country"],
    currency: json["currency"],
    primaryGenreName: json["primaryGenreName"],
    isStreamable: json["isStreamable"],
    contentAdvisoryRating: json["contentAdvisoryRating"],
  );

  Map<String, dynamic> toJson() => {
    "wrapperType": wrapperType,
    "kind": kind,
    "artistId": artistId,
    "collectionId": collectionId,
    "trackId": trackId,
    "artistName": artistName,
    "collectionName": collectionName,
    "trackName": trackName,
    "collectionCensoredName": collectionCensoredName,
    "trackCensoredName": trackCensoredName,
    "artistViewUrl": artistViewUrl,
    "collectionViewUrl": collectionViewUrl,
    "trackViewUrl": trackViewUrl,
    "previewUrl": previewUrl,
    "artworkUrl30": artworkUrl30,
    "artworkUrl60": artworkUrl60,
    "artworkUrl100": artworkUrl100,
    "collectionPrice": collectionPrice,
    "trackPrice": trackPrice,
    "releaseDate": releaseDate.toIso8601String(),
    "collectionExplicitness": collectionExplicitness,
    "trackExplicitness": trackExplicitness,
    "discCount": discCount,
    "discNumber": discNumber,
    "trackCount": trackCount,
    "trackNumber": trackNumber,
    "trackTimeMillis": trackTimeMillis,
    "country": country,
    "currency": currency,
    "primaryGenreName": primaryGenreName,
    "isStreamable": isStreamable,
    "contentAdvisoryRating": contentAdvisoryRating,
  };
}
