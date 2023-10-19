import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_provider.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// 1. 창고 데이터

class PostDetailModel {
  Post post;
  PostDetailModel(this.post);
}

// 2. 창고
class PostDetailViewModel extends StateNotifier<PostDetailModel?> {
  PostDetailViewModel(super.state, this.ref);
  Ref ref;

  Future<void> notifyInit(int id) async {
    Logger().d("notifyInit");
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().fetchPost(sessionUser.jwt!, id);
    state = PostDetailModel(responseDTO.data);
  }
}

// 3. 창고 관리자
// TODO 4 : Provider.family에 대해서 정리
// TODO 5 : Provider 결합에 대해서 정리
// family를 사용하면 창고관리자가 직접 파라미터를 전달 받을 수 있음
final postDetailProvider = StateNotifierProvider.autoDispose<PostDetailViewModel, PostDetailModel?>((ref) {
  int postId = ref.read(paramProvider).postDetailId!;
  return PostDetailViewModel(null, ref)..notifyInit(postId);
});
