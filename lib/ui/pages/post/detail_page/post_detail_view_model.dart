import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고 데이터

class PostDetailModel {
  Post post;
  PostDetailModel(this.post);
}

// 2. 창고
class PostDetailViewModel extends StateNotifier<PostDetailModel?> {
  PostDetailViewModel(super.state, this.ref);
  Ref ref;

  void init(Post post) {
    state = PostDetailModel(post);
  }
}

// 3. 창고 관리자
final postDetailProvider = StateNotifierProvider<PostDetailViewModel, PostDetailModel?>((ref) {
  return PostDetailViewModel(null, ref);
});
