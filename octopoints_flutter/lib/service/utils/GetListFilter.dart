class GetListFilter {
  int? id;
  bool? isActive;

  GetListFilter setId(int? id){
    this.id = id;
    return this;
  }

  GetListFilter setIsActive(bool isActive){
    this.isActive = isActive;
    return this;
  }
}