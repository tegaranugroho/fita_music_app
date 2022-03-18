import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Music extends Equatable {
  Music({
    this.wrapperType,
    this.kind,
    this.artistId,
    this.collectionId,
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.collectionCensoredName,
    this.trackCensoredName,
    this.artistViewUrl,
    this.collectionViewUrl,
    this.trackViewUrl,
    this.previewUrl,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
    this.collectionPrice,
    this.trackPrice,
    this.releaseDate,
    this.collectionExplicitness,
    this.trackExplicitness,
    this.discCount,
    this.discNumber,
    this.trackCount,
    this.trackNumber,
    this.trackTimeMillis,
    this.country,
    this.currency,
    this.primaryGenreName,
    this.isStreamable,
    this.trackHdPrice,
    this.trackHdRentalPrice,
    this.contentAdvisoryRating,
    this.shortDescription,
    this.longDescription,
    this.hasITunesExtras,
    this.collectionArtistName,
  });

  String? wrapperType;
  String? kind;
  int? artistId;
  int? collectionId;
  int? trackId;
  String? artistName;
  String? collectionName;
  String? trackName;
  String? collectionCensoredName;
  String? trackCensoredName;
  String? artistViewUrl;
  String? collectionViewUrl;
  String? trackViewUrl;
  String? previewUrl;
  String? artworkUrl30;
  String? artworkUrl60;
  String? artworkUrl100;
  double? collectionPrice;
  double? trackPrice;
  String? releaseDate;
  String? collectionExplicitness;
  String? trackExplicitness;
  int? discCount;
  int? discNumber;
  int? trackCount;
  int? trackNumber;
  int? trackTimeMillis;
  String? country;
  String? currency;
  String? primaryGenreName;
  bool? isStreamable;
  double? trackHdPrice;
  double? trackHdRentalPrice;
  String? contentAdvisoryRating;
  String? shortDescription;
  String? longDescription;
  bool? hasITunesExtras;
  String? collectionArtistName;

  @override
  List<Object?> get props => [
        wrapperType,
        kind,
        artistId,
        collectionId,
        trackId,
        artistName,
        collectionName,
        trackName,
        collectionCensoredName,
        trackCensoredName,
        artistViewUrl,
        collectionViewUrl,
        trackViewUrl,
        previewUrl,
        artworkUrl30,
        artworkUrl60,
        artworkUrl100,
        collectionPrice,
        trackPrice,
        releaseDate,
        collectionExplicitness,
        trackExplicitness,
        discCount,
        discNumber,
        trackCount,
        trackNumber,
        trackTimeMillis,
        country,
        currency,
        primaryGenreName,
        isStreamable,
        trackHdPrice,
        trackHdRentalPrice,
        contentAdvisoryRating,
        shortDescription,
        longDescription,
        hasITunesExtras,
        collectionArtistName
      ];
}
