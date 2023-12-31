// View -> Provider(전역 Provider, View Model) -> Repository
import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';

class PostRepository {
  Future<ResponseDTO> fetchPostList(String jwt) async {
    try {
      // 1. 통신
      final response = await dio.get("/post", options: Options(headers: {"Authorization": "${jwt}"}));

      // 2. 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);

      // 3. ResponseDTO의 data파싱
      List<dynamic> mapList = responseDTO.data as List<dynamic>;
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
      responseDTO.data = postList;
      // responseDTO.data = User.fromJson(responseDTO.data);

      // 4. 파싱된 데이터를 다시 공통 dto로 덮어씌우기
      return responseDTO;
    } catch (e) {
      // 200이외의 상태코드는 무조건 catch로 감 (통신은 무조건 try-catch)
      return ResponseDTO(-1, "게시글 목록 불러오기 실패", null);
    }
  }
}
