class RoleContent {
  final String role;
  final String content;

  RoleContent({required this.role, required this.content});

  Map<String, String> toMap() {
    return {"role": role, "content": content};
  }
}
