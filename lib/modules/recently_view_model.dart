class RecentlyViewModel {
  String productId;
  String productName;
  String productDescription;
  String productPrice;
  String productCategory;
  String productURL;
  String productRating;
  bool productPublished;
  bool productVerified;

  RecentlyViewModel(
      {this.productId,
        this.productName,
        this.productDescription,
        this.productCategory,
        this.productPrice,
        this.productURL,
        this.productRating,
        this.productPublished,
        this.productVerified});
}
