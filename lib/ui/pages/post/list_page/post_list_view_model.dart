// 1. 창고 데이터
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListModel {
  List<Post> posts;

  PostListModel(this.posts);
}

// 2. 창고
class PostListViewModel extends StateNotifier<PostListModel?> {
  PostListViewModel(super.state, this.ref);

  Ref ref;

  Future<void> notifyInit() async {
    // jwt 가져오기
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().fetchPostList(sessionUser.jwt!);

    state = PostListModel(responseDTO.data);
  }
}

// 3. 창고 관리자 (View 빌드되기 직전에 생성됨)
final postListProvider = StateNotifierProvider<PostListViewModel, PostListModel?>((ref) {
  return PostListViewModel(null, ref)..notifyInit();
});
