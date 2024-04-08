void main() {
  Map maps = {
    'test': [0],
    'test2': [1],
  };
  maps['test'].add(1);
  print(maps['test']);
}
