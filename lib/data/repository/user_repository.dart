// View -> Provider(전역 Provider, View Model) -> Repository
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/dto/user_request.dart';
import 'package:flutter_blog/data/model/user.dart';

class UserRepository {
  Future<ResponseDTO> fetchJoin(JoinReqDTO requestDTO) async {
    try {
      final response = await dio.post("/join", data: requestDTO.toJson());
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      // responseDTO.data = User.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      // 200이외의 상태코드는 무조건 catch로 감 (통신은 무조건 try-catch)
      return ResponseDTO(-1, "중복되는 유저명입니다.", null);
    }
  }

  Future<ResponseDTO> fetchLogin(LoginReqDTO requestDTO) async {
    try {
      final response = await dio.post("/login", data: requestDTO.toJson());
      print(response.headers);

      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);

      final jwt = response.headers["Authorization"]; // headers의 정확한 Type은 List<String>?

      if (jwt != null) {
        responseDTO.token = jwt.first;
      }

      return responseDTO;
    } catch (e) {
      // 200이외의 상태코드는 무조건 catch로 감 (통신은 무조건 try-catch)
      return ResponseDTO(-1, "유저네임 혹은 비밀번호가 틀렸습니다.", null);
    }
  }
}
