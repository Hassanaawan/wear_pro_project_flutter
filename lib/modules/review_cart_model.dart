class ReviewCartModel {
  String cartId;
  String cartName;
  String cartPrice;
  String cartImage;
  String cartQuantity;
  String vendorId;

  // String productRating;
  // bool productPublished;
  // bool productVerified;
  // String productDescription;

  ReviewCartModel(
      {this.cartId,
      this.cartImage,
      this.cartName,
      this.cartPrice,
      this.cartQuantity,
      this.vendorId});
}

// List<ReviewCartModel> myCarts = [
//
//   Cart(product: myProducts[0], numOfItem: 2),
//   Cart(product: myProducts[1], numOfItem: 1),
//   Cart(product: myProducts[3], numOfItem: 1),
//   Cart(product: myProducts[3], numOfItem: 3),
//
// ];
