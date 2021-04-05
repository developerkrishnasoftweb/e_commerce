class EstimateShippingMethod {
  String carrierCode;
  String methodCode;
  String carrierTitle;
  String methodTitle;
  String amount;
  String baseAmount;
  String available;
  String errorMessage;
  String priceExclTax;
  String priceInclTax;

  EstimateShippingMethod(
      {this.carrierCode,
        this.methodCode,
        this.carrierTitle,
        this.methodTitle,
        this.amount,
        this.baseAmount,
        this.available,
        this.errorMessage,
        this.priceExclTax,
        this.priceInclTax});

  EstimateShippingMethod.fromJson(Map<String, dynamic> json) {
    carrierCode = json['carrier_code']?.toString();
    methodCode = json['method_code']?.toString();
    carrierTitle = json['carrier_title']?.toString();
    methodTitle = json['method_title']?.toString();
    amount = json['amount']?.toString();
    baseAmount = json['base_amount']?.toString();
    available = json['available']?.toString();
    errorMessage = json['error_message']?.toString();
    priceExclTax = json['price_excl_tax']?.toString();
    priceInclTax = json['price_incl_tax']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carrier_code'] = this.carrierCode;
    data['method_code'] = this.methodCode;
    data['carrier_title'] = this.carrierTitle;
    data['method_title'] = this.methodTitle;
    data['amount'] = this.amount;
    data['base_amount'] = this.baseAmount;
    data['available'] = this.available;
    data['error_message'] = this.errorMessage;
    data['price_excl_tax'] = this.priceExclTax;
    data['price_incl_tax'] = this.priceInclTax;
    return data;
  }
}
