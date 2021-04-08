import 'dart:convert';

class PaymentDetails {
  List<Methods> paymentMethods;
  Totals totals;

  PaymentDetails({this.paymentMethods, this.totals});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    if (json['payment_methods'] != null) {
      paymentMethods = new List<Methods>();
      json['payment_methods'].forEach((v) {
        paymentMethods.add(new Methods.fromJson(v));
      });
    }
    totals =
        json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods.map((v) => v.toJson()).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals.toJson();
    }
    return data;
  }
}

class Methods {
  String code, title;

  Methods({this.code, this.title});

  Methods.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    return data;
  }
}

class Totals {
  String grandTotal,
      baseGrandTotal,
      subtotal,
      baseSubtotal,
      discountAmount,
      baseDiscountAmount,
      subtotalWithDiscount,
      baseSubtotalWithDiscount,
      shippingAmount,
      baseShippingAmount,
      shippingDiscountAmount,
      baseShippingDiscountAmount,
      taxAmount,
      baseTaxAmount,
      weeeTaxAppliedAmount,
      shippingTaxAmount,
      baseShippingTaxAmount,
      subtotalInclTax,
      shippingInclTax,
      baseShippingInclTax,
      baseCurrencyCode,
      quoteCurrencyCode,
      itemsQty;
  List<Items> items;
  List<TotalSegments> totalSegments;

  Totals(
      {this.grandTotal,
      this.baseGrandTotal,
      this.subtotal,
      this.baseSubtotal,
      this.discountAmount,
      this.baseDiscountAmount,
      this.subtotalWithDiscount,
      this.baseSubtotalWithDiscount,
      this.shippingAmount,
      this.baseShippingAmount,
      this.shippingDiscountAmount,
      this.baseShippingDiscountAmount,
      this.taxAmount,
      this.baseTaxAmount,
      this.weeeTaxAppliedAmount,
      this.shippingTaxAmount,
      this.baseShippingTaxAmount,
      this.subtotalInclTax,
      this.shippingInclTax,
      this.baseShippingInclTax,
      this.baseCurrencyCode,
      this.quoteCurrencyCode,
      this.itemsQty,
      this.items,
      this.totalSegments});

  Totals.fromJson(Map<String, dynamic> json) {
    grandTotal = json['grand_total']?.toString();
    baseGrandTotal = json['base_grand_total']?.toString();
    subtotal = json['subtotal']?.toString();
    baseSubtotal = json['base_subtotal']?.toString();
    discountAmount = json['discount_amount']?.toString();
    baseDiscountAmount = json['base_discount_amount']?.toString();
    subtotalWithDiscount = json['subtotal_with_discount']?.toString();
    baseSubtotalWithDiscount = json['base_subtotal_with_discount']?.toString();
    shippingAmount = json['shipping_amount']?.toString();
    baseShippingAmount = json['base_shipping_amount']?.toString();
    shippingDiscountAmount = json['shipping_discount_amount']?.toString();
    baseShippingDiscountAmount = json['base_shipping_discount_amount']?.toString();
    taxAmount = json['tax_amount']?.toString();
    baseTaxAmount = json['base_tax_amount']?.toString();
    weeeTaxAppliedAmount = json['weee_tax_applied_amount']?.toString();
    shippingTaxAmount = json['shipping_tax_amount']?.toString();
    baseShippingTaxAmount = json['base_shipping_tax_amount']?.toString();
    subtotalInclTax = json['subtotal_incl_tax']?.toString();
    shippingInclTax = json['shipping_incl_tax']?.toString();
    baseShippingInclTax = json['base_shipping_incl_tax']?.toString();
    baseCurrencyCode = json['base_currency_code']?.toString();
    quoteCurrencyCode = json['quote_currency_code']?.toString();
    itemsQty = json['items_qty']?.toString();
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    if (json['total_segments'] != null) {
      totalSegments = new List<TotalSegments>();
      json['total_segments'].forEach((v) {
        totalSegments.add(new TotalSegments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grand_total'] = this.grandTotal;
    data['base_grand_total'] = this.baseGrandTotal;
    data['subtotal'] = this.subtotal;
    data['base_subtotal'] = this.baseSubtotal;
    data['discount_amount'] = this.discountAmount;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['subtotal_with_discount'] = this.subtotalWithDiscount;
    data['base_subtotal_with_discount'] = this.baseSubtotalWithDiscount;
    data['shipping_amount'] = this.shippingAmount;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['tax_amount'] = this.taxAmount;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['weee_tax_applied_amount'] = this.weeeTaxAppliedAmount;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['subtotal_incl_tax'] = this.subtotalInclTax;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_currency_code'] = this.baseCurrencyCode;
    data['quote_currency_code'] = this.quoteCurrencyCode;
    data['items_qty'] = this.itemsQty;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.totalSegments != null) {
      data['total_segments'] =
          this.totalSegments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String itemId,
      price,
      basePrice,
      qty,
      rowTotal,
      baseRowTotal,
      rowTotalWithDiscount,
      taxAmount,
      baseTaxAmount,
      taxPercent,
      discountAmount,
      baseDiscountAmount,
      discountPercent,
      priceInclTax,
      basePriceInclTax,
      rowTotalInclTax,
      baseRowTotalInclTax,
      weeeTaxAppliedAmount,
      weeeTaxApplied,
      name;
  List<Option> options;

  Items(
      {this.itemId,
      this.price,
      this.basePrice,
      this.qty,
      this.rowTotal,
      this.baseRowTotal,
      this.rowTotalWithDiscount,
      this.taxAmount,
      this.baseTaxAmount,
      this.taxPercent,
      this.discountAmount,
      this.baseDiscountAmount,
      this.discountPercent,
      this.priceInclTax,
      this.basePriceInclTax,
      this.rowTotalInclTax,
      this.baseRowTotalInclTax,
      this.options,
      this.weeeTaxAppliedAmount,
      this.weeeTaxApplied,
      this.name});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id']?.toString();
    price = json['price']?.toString();
    basePrice = json['base_price']?.toString();
    qty = json['qty']?.toString();
    rowTotal = json['row_total']?.toString();
    baseRowTotal = json['base_row_total']?.toString();
    rowTotalWithDiscount = json['row_total_with_discount']?.toString();
    taxAmount = json['tax_amount']?.toString();
    baseTaxAmount = json['base_tax_amount']?.toString();
    taxPercent = json['tax_percent']?.toString();
    discountAmount = json['discount_amount']?.toString();
    baseDiscountAmount = json['base_discount_amount']?.toString();
    discountPercent = json['discount_percent']?.toString();
    priceInclTax = json['price_incl_tax']?.toString();
    basePriceInclTax = json['base_price_incl_tax']?.toString();
    rowTotalInclTax = json['row_total_incl_tax']?.toString();
    baseRowTotalInclTax = json['base_row_total_incl_tax']?.toString();
    weeeTaxAppliedAmount = json['weee_tax_applied_amount']?.toString();
    weeeTaxApplied = json['weee_tax_applied']?.toString();
    name = json['name']?.toString();
    List itemOptions = jsonDecode(json['options'] ?? "[]");
    options = <Option>[];
    itemOptions.forEach((v) {
      options.add(Option.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['price'] = this.price;
    data['base_price'] = this.basePrice;
    data['qty'] = this.qty;
    data['row_total'] = this.rowTotal;
    data['base_row_total'] = this.baseRowTotal;
    data['row_total_with_discount'] = this.rowTotalWithDiscount;
    data['tax_amount'] = this.taxAmount;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['tax_percent'] = this.taxPercent;
    data['discount_amount'] = this.discountAmount;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['discount_percent'] = this.discountPercent;
    data['price_incl_tax'] = this.priceInclTax;
    data['base_price_incl_tax'] = this.basePriceInclTax;
    data['row_total_incl_tax'] = this.rowTotalInclTax;
    data['base_row_total_incl_tax'] = this.baseRowTotalInclTax;
    data['options'] = this.options;
    data['weee_tax_applied_amount'] = this.weeeTaxAppliedAmount;
    data['weee_tax_applied'] = this.weeeTaxApplied;
    data['name'] = this.name;
    return data;
  }
}

class Option {
  String value, label;
  Option.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }
}

class TotalSegments {
  String code, title, value;

  TotalSegments(
      {this.code, this.title, this.value});

  TotalSegments.fromJson(Map<String, dynamic> json) {
    code = json['code']?.toString();
    title = json['title']?.toString();
    value = json['value']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}