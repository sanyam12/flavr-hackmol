import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flavr/core/constants.dart';
import 'package:flavr/pages/profile_page/OrderData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

part 'orders_list_event.dart';
part 'orders_list_state.dart';

class OrdersListBloc extends Bloc<OrdersListEvent, OrdersListState> {
  OrdersListBloc() : super(OrdersListInitial()) {
    on<OrdersListEvent>((event, emit) async{
      if(event is GetProfileData){
        const secure = FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true)
        );
        final token = await secure.read(key: "token");
        http.Response response = await http.get(
            Uri.parse("${API_DOMAIN}user/userprofile"),
            headers: {
              "Authorization":"Bearer $token"
            }
        );
        if(response.statusCode==201){
          final json = jsonDecode(response.body);
          final userName = json["user"][0]["userName"];
          final email = json["user"][0]["email"];
          final profilePicUrl = json["user"][0]["userProfilePic"]["url"];
          List<OrderData> stream = await getOrders(token.toString());

          emit(ProfileDataState(userName, stream, email, profilePicUrl));
        }else{
          emit(ShowSnackbar(response.body));
        }
      }
    });
  }

  Future<List<OrderData>> getOrders(String token)async{
    final List<OrderData> orderList = [];
    final response = await http.get(
        Uri.parse("${API_DOMAIN}orders/getorders"),
        headers: {
          "Authorization":"Bearer $token"
        }
    );
    if(response.statusCode==200){
      final list = jsonDecode(response.body)["result"];
      for(var i in list){
        orderList.add(OrderData.fromJson(i));
      }
    }
    return orderList;
  }
}
