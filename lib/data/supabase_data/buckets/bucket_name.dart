enum BucketName {
  avatars;

  @override
  String toString() {
    switch (this) {
      case BucketName.avatars:
        return 'avatars';
    }
  }
}
