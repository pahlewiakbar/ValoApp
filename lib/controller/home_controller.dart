import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/agent_model.dart';
import '../model/maps_model.dart';
import '../model/mode_model.dart';
import '../model/weapon_model.dart';

class HomeController {
  Future<List<AgentModel>> allAgent() async {
    var response = await http.get(Uri.parse(
        'https://valorant-api.com/v1/agents?isPlayableCharacter=true&language=id-ID'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List agent = data['data'];
      return agent.map((e) => AgentModel.fromJson(e)).toList();
    } else {
      throw Exception('failed to get data');
    }
  }

  Future<AgentModel> singleAgent(String uuid) async {
    var response = await http.get(
        Uri.parse('https://valorant-api.com/v1/agents/$uuid?language=id-ID'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var agent = data['data'];
      return AgentModel.fromJson(agent);
    } else {
      throw Exception('failed to get data');
    }
  }

  Future<List<WeaponModel>> allWeapon() async {
    var response = await http
        .get(Uri.parse('https://valorant-api.com/v1/weapons?language=id-ID'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List weapon = data['data'];
      return weapon.map((e) => WeaponModel.fromJson(e)).toList();
    } else {
      throw Exception('failed to get data');
    }
  }

  Future<List<MapsModel>> allMap() async {
    var response = await http
        .get(Uri.parse('https://valorant-api.com/v1/maps?language=id-ID'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List maps = data['data'];
      return maps.map((e) => MapsModel.fromJson(e)).toList();
    } else {
      throw Exception('failed to get data');
    }
  }

  Future<List<ModeModel>> allMode() async {
    var response = await http
        .get(Uri.parse('https://valorant-api.com/v1/gamemodes?language=id-ID'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List mode = data['data'];
      return mode.map((e) => ModeModel.fromJson(e)).toList();
    } else {
      throw Exception('failed to get data');
    }
  }
}
