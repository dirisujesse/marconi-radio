import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class MarconiTransformer extends DefaultTransformer {
  MarconiTransformer() : super(jsonDecodeCallback: _parseJson);
}

class HttpService {
  static Xml2Json myTransformer = Xml2Json();
  static String _apiKey = "xLPAqJgCLC7G8ccU";
  static Dio http = new Dio(
    BaseOptions(
      connectTimeout: 1000 * 10,
      receiveTimeout: 1000 * 10,
    ),
  )..transformer = MarconiTransformer();
  static String url = "http://api.shoutcast.com/legacy";
  static String tuneInUrl = "http://yp.shoutcast.com";
  static RegExp urlMatcher = new RegExp(
    r"=(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+",
    multiLine: true,
    caseSensitive: false,
  );

  final Map<String, String> tuneInData = {
    "base": "/sbin/tunein-station.pls",
    "base-m3u": "/sbin/tunein-station.m3u",
    "base-xspf": "/sbin/tunein-station.xspf"
  };

  static CancelToken cancelToken = new CancelToken();

  static Future<Map<String, dynamic>> searchStations(
      String query, BuildContext context) async {
    try {
      final req = await DefaultAssetBundle.of(context)
          .loadString('assets/data/$query.json');
      final Map<dynamic, dynamic> res = await _parseJson(req);
      return res["stationlist"];
    } catch (e) {
      throw e;
    }
  }

  static Future<Map<String, dynamic>> searchStationsOnline(String query) async {
    try {
      final req = await http.get(
        "http://api.shoutcast.com/station/nowplaying",
        queryParameters: {"k": _apiKey, "ct": query, "limit": 30, "f": "json"},
        cancelToken: cancelToken,
      );
      if (req.statusCode <= 201) {
        final Map<dynamic, dynamic> match = req.data;
        final bool hasStations =
            match["response"] != null && match["response"]["data"] != null && match["response"]["data"]["stationlist"] != null && match["response"]["data"]["stationlist"]["station"] != null;
        if (hasStations) {
          return match["response"]["data"]["stationlist"];
        }
        return {"station": []};
      }
      return {"station": []};
    } catch (e) {
      throw e;
    }
  }

  static Future<dynamic> getStream(String id) async {
    try {
      final req = await http.get(
        "$tuneInUrl/sbin/tunein-station.xspf",
        queryParameters: {"id": id},
        cancelToken: cancelToken,
      );
      if (req.statusCode <= 201) {
        myTransformer.parse(req.data);
        final Map<dynamic, dynamic> match =
            json.decode(myTransformer.toParker());
        final bool hasTracks =
            match["playlist"] != null && match["playlist"]["trackList"] != null;
        if (hasTracks) {
          if (match["playlist"]["trackList"]["track"] is List) {
            return match["playlist"]["trackList"]["track"][0]["location"];
          } else {
            return match["playlist"]["trackList"]["track"]["location"];
          }
        }
        throw "no data";
      }
    } catch (e) {
      throw e;
    }
  }

  void cancelReqs() {
    cancelToken.cancel("Request has been cancelled");
  }
}
