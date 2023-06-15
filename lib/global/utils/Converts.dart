// ignore_for_file: file_names

class Converts {
  static double calculateProductPrice(
      double price, double discount, String discountType) {
    double newprice = 0;
    if (discount > 0) {
      if (discountType == "flat") {
        newprice = price - discount;
        return newprice;
      } else if (discountType == "percent") {
        newprice = price - ((price * discount) / 100);
        return newprice;
      }
    } 
      return newprice; 
  }
}
