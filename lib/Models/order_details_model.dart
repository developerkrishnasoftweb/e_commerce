class OrderDetails {
  String baseCurrencyCode;
  int baseDiscountAmount;
  int baseGrandTotal;
  int baseDiscountTaxCompensationAmount;
  int baseShippingAmount;
  int baseShippingDiscountAmount;
  int baseShippingDiscountTaxCompensationAmnt;
  int baseShippingInclTax;
  int baseShippingTaxAmount;
  int baseSubtotal;
  int baseSubtotalInclTax;
  int baseTaxAmount;
  int baseTotalDue;
  int baseToGlobalRate;
  int baseToOrderRate;
  int billingAddressId;
  String createdAt;
  String customerDob;
  String customerEmail;
  String customerFirstname;
  int customerGender;
  int customerGroupId;
  int customerId;
  int customerIsGuest;
  String customerLastname;
  String customerMiddlename;
  int customerNoteNotify;
  int discountAmount;
  int entityId;
  String globalCurrencyCode;
  int grandTotal;
  int discountTaxCompensationAmount;
  String incrementId;
  int isVirtual;
  String orderCurrencyCode;
  String protectCode;
  int quoteId;
  String remoteIp;
  int shippingAmount;
  int shippingDiscountAmount;
  int shippingDiscountTaxCompensationAmount;
  int shippingInclTax;
  int shippingTaxAmount;
  String state;
  String status;
  String storeCurrencyCode;
  int storeId;
  String storeName;
  int storeToBaseRate;
  int storeToOrderRate;
  int subtotal;
  int subtotalInclTax;
  int taxAmount;
  int totalDue;
  int totalItemCount;
  int totalQtyOrdered;
  String updatedAt;
  int weight;
  String xForwardedFor;
  List<Items> items;
  BillingAddress billingAddress;
  Payment payment;
  List statusHistories;
  ExtensionAttributes extensionAttributes;

  OrderDetails(
      {this.baseCurrencyCode,
        this.baseDiscountAmount,
        this.baseGrandTotal,
        this.baseDiscountTaxCompensationAmount,
        this.baseShippingAmount,
        this.baseShippingDiscountAmount,
        this.baseShippingDiscountTaxCompensationAmnt,
        this.baseShippingInclTax,
        this.baseShippingTaxAmount,
        this.baseSubtotal,
        this.baseSubtotalInclTax,
        this.baseTaxAmount,
        this.baseTotalDue,
        this.baseToGlobalRate,
        this.baseToOrderRate,
        this.billingAddressId,
        this.createdAt,
        this.customerDob,
        this.customerEmail,
        this.customerFirstname,
        this.customerGender,
        this.customerGroupId,
        this.customerId,
        this.customerIsGuest,
        this.customerLastname,
        this.customerMiddlename,
        this.customerNoteNotify,
        this.discountAmount,
        this.entityId,
        this.globalCurrencyCode,
        this.grandTotal,
        this.discountTaxCompensationAmount,
        this.incrementId,
        this.isVirtual,
        this.orderCurrencyCode,
        this.protectCode,
        this.quoteId,
        this.remoteIp,
        this.shippingAmount,
        this.shippingDiscountAmount,
        this.shippingDiscountTaxCompensationAmount,
        this.shippingInclTax,
        this.shippingTaxAmount,
        this.state,
        this.status,
        this.storeCurrencyCode,
        this.storeId,
        this.storeName,
        this.storeToBaseRate,
        this.storeToOrderRate,
        this.subtotal,
        this.subtotalInclTax,
        this.taxAmount,
        this.totalDue,
        this.totalItemCount,
        this.totalQtyOrdered,
        this.updatedAt,
        this.weight,
        this.xForwardedFor,
        this.items,
        this.billingAddress,
        this.payment,
        this.statusHistories,
        this.extensionAttributes});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    baseCurrencyCode = json['base_currency_code'];
    baseDiscountAmount = json['base_discount_amount'];
    baseGrandTotal = json['base_grand_total'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    baseShippingDiscountTaxCompensationAmnt =
    json['base_shipping_discount_tax_compensation_amnt'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    baseSubtotal = json['base_subtotal'];
    baseSubtotalInclTax = json['base_subtotal_incl_tax'];
    baseTaxAmount = json['base_tax_amount'];
    baseTotalDue = json['base_total_due'];
    baseToGlobalRate = json['base_to_global_rate'];
    baseToOrderRate = json['base_to_order_rate'];
    billingAddressId = json['billing_address_id'];
    createdAt = json['created_at'];
    customerDob = json['customer_dob'];
    customerEmail = json['customer_email'];
    customerFirstname = json['customer_firstname'];
    customerGender = json['customer_gender'];
    customerGroupId = json['customer_group_id'];
    customerId = json['customer_id'];
    customerIsGuest = json['customer_is_guest'];
    customerLastname = json['customer_lastname'];
    customerMiddlename = json['customer_middlename'];
    customerNoteNotify = json['customer_note_notify'];
    discountAmount = json['discount_amount'];
    entityId = json['entity_id'];
    globalCurrencyCode = json['global_currency_code'];
    grandTotal = json['grand_total'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    incrementId = json['increment_id'];
    isVirtual = json['is_virtual'];
    orderCurrencyCode = json['order_currency_code'];
    protectCode = json['protect_code'];
    quoteId = json['quote_id'];
    remoteIp = json['remote_ip'];
    shippingAmount = json['shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'];
    shippingInclTax = json['shipping_incl_tax'];
    shippingTaxAmount = json['shipping_tax_amount'];
    state = json['state'];
    status = json['status'];
    storeCurrencyCode = json['store_currency_code'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeToBaseRate = json['store_to_base_rate'];
    storeToOrderRate = json['store_to_order_rate'];
    subtotal = json['subtotal'];
    subtotalInclTax = json['subtotal_incl_tax'];
    taxAmount = json['tax_amount'];
    totalDue = json['total_due'];
    totalItemCount = json['total_item_count'];
    totalQtyOrdered = json['total_qty_ordered'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    xForwardedFor = json['x_forwarded_for'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    billingAddress = json['billing_address'] != null
        ? new BillingAddress.fromJson(json['billing_address'])
        : null;
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    statusHistories = json['status_histories'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_currency_code'] = this.baseCurrencyCode;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['base_grand_total'] = this.baseGrandTotal;
    data['base_discount_tax_compensation_amount'] =
        this.baseDiscountTaxCompensationAmount;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['base_shipping_discount_tax_compensation_amnt'] =
        this.baseShippingDiscountTaxCompensationAmnt;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['base_subtotal'] = this.baseSubtotal;
    data['base_subtotal_incl_tax'] = this.baseSubtotalInclTax;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['base_total_due'] = this.baseTotalDue;
    data['base_to_global_rate'] = this.baseToGlobalRate;
    data['base_to_order_rate'] = this.baseToOrderRate;
    data['billing_address_id'] = this.billingAddressId;
    data['created_at'] = this.createdAt;
    data['customer_dob'] = this.customerDob;
    data['customer_email'] = this.customerEmail;
    data['customer_firstname'] = this.customerFirstname;
    data['customer_gender'] = this.customerGender;
    data['customer_group_id'] = this.customerGroupId;
    data['customer_id'] = this.customerId;
    data['customer_is_guest'] = this.customerIsGuest;
    data['customer_lastname'] = this.customerLastname;
    data['customer_middlename'] = this.customerMiddlename;
    data['customer_note_notify'] = this.customerNoteNotify;
    data['discount_amount'] = this.discountAmount;
    data['entity_id'] = this.entityId;
    data['global_currency_code'] = this.globalCurrencyCode;
    data['grand_total'] = this.grandTotal;
    data['discount_tax_compensation_amount'] =
        this.discountTaxCompensationAmount;
    data['increment_id'] = this.incrementId;
    data['is_virtual'] = this.isVirtual;
    data['order_currency_code'] = this.orderCurrencyCode;
    data['protect_code'] = this.protectCode;
    data['quote_id'] = this.quoteId;
    data['remote_ip'] = this.remoteIp;
    data['shipping_amount'] = this.shippingAmount;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['shipping_discount_tax_compensation_amount'] =
        this.shippingDiscountTaxCompensationAmount;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    data['state'] = this.state;
    data['status'] = this.status;
    data['store_currency_code'] = this.storeCurrencyCode;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_to_base_rate'] = this.storeToBaseRate;
    data['store_to_order_rate'] = this.storeToOrderRate;
    data['subtotal'] = this.subtotal;
    data['subtotal_incl_tax'] = this.subtotalInclTax;
    data['tax_amount'] = this.taxAmount;
    data['total_due'] = this.totalDue;
    data['total_item_count'] = this.totalItemCount;
    data['total_qty_ordered'] = this.totalQtyOrdered;
    data['updated_at'] = this.updatedAt;
    data['weight'] = this.weight;
    data['x_forwarded_for'] = this.xForwardedFor;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.billingAddress != null) {
      data['billing_address'] = this.billingAddress.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    if (this.statusHistories != null) {
      data['status_histories'] =
          this.statusHistories.map((v) => v.toJson()).toList();
    }
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    return data;
  }
}

class Items {
  int amountRefunded;
  int baseAmountRefunded;
  int baseDiscountAmount;
  int baseDiscountInvoiced;
  int baseDiscountTaxCompensationAmount;
  int baseOriginalPrice;
  int basePrice;
  int basePriceInclTax;
  int baseRowInvoiced;
  int baseRowTotal;
  int baseRowTotalInclTax;
  int baseTaxAmount;
  int baseTaxInvoiced;
  String createdAt;
  int discountAmount;
  int discountInvoiced;
  int discountPercent;
  int freeShipping;
  int discountTaxCompensationAmount;
  int isQtyDecimal;
  int isVirtual;
  int itemId;
  String name;
  int noDiscount;
  int orderId;
  int originalPrice;
  int price;
  int priceInclTax;
  int productId;
  String productType;
  int qtyCanceled;
  int qtyInvoiced;
  int qtyOrdered;
  int qtyRefunded;
  int qtyShipped;
  int quoteItemId;
  int rowInvoiced;
  int rowTotal;
  int rowTotalInclTax;
  int rowWeight;
  String sku;
  int storeId;
  int taxAmount;
  int taxInvoiced;
  int taxPercent;
  String updatedAt;
  int weight;
  ProductOption productOption;
  int parentItemId;
  ParentItem parentItem;

  Items(
      {this.amountRefunded,
        this.baseAmountRefunded,
        this.baseDiscountAmount,
        this.baseDiscountInvoiced,
        this.baseDiscountTaxCompensationAmount,
        this.baseOriginalPrice,
        this.basePrice,
        this.basePriceInclTax,
        this.baseRowInvoiced,
        this.baseRowTotal,
        this.baseRowTotalInclTax,
        this.baseTaxAmount,
        this.baseTaxInvoiced,
        this.createdAt,
        this.discountAmount,
        this.discountInvoiced,
        this.discountPercent,
        this.freeShipping,
        this.discountTaxCompensationAmount,
        this.isQtyDecimal,
        this.isVirtual,
        this.itemId,
        this.name,
        this.noDiscount,
        this.orderId,
        this.originalPrice,
        this.price,
        this.priceInclTax,
        this.productId,
        this.productType,
        this.qtyCanceled,
        this.qtyInvoiced,
        this.qtyOrdered,
        this.qtyRefunded,
        this.qtyShipped,
        this.quoteItemId,
        this.rowInvoiced,
        this.rowTotal,
        this.rowTotalInclTax,
        this.rowWeight,
        this.sku,
        this.storeId,
        this.taxAmount,
        this.taxInvoiced,
        this.taxPercent,
        this.updatedAt,
        this.weight,
        this.productOption,
        this.parentItemId,
        this.parentItem});

  Items.fromJson(Map<String, dynamic> json) {
    amountRefunded = json['amount_refunded'];
    baseAmountRefunded = json['base_amount_refunded'];
    baseDiscountAmount = json['base_discount_amount'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseOriginalPrice = json['base_original_price'];
    basePrice = json['base_price'];
    basePriceInclTax = json['base_price_incl_tax'];
    baseRowInvoiced = json['base_row_invoiced'];
    baseRowTotal = json['base_row_total'];
    baseRowTotalInclTax = json['base_row_total_incl_tax'];
    baseTaxAmount = json['base_tax_amount'];
    baseTaxInvoiced = json['base_tax_invoiced'];
    createdAt = json['created_at'];
    discountAmount = json['discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    discountPercent = json['discount_percent'];
    freeShipping = json['free_shipping'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    isQtyDecimal = json['is_qty_decimal'];
    isVirtual = json['is_virtual'];
    itemId = json['item_id'];
    name = json['name'];
    noDiscount = json['no_discount'];
    orderId = json['order_id'];
    originalPrice = json['original_price'];
    price = json['price'];
    priceInclTax = json['price_incl_tax'];
    productId = json['product_id'];
    productType = json['product_type'];
    qtyCanceled = json['qty_canceled'];
    qtyInvoiced = json['qty_invoiced'];
    qtyOrdered = json['qty_ordered'];
    qtyRefunded = json['qty_refunded'];
    qtyShipped = json['qty_shipped'];
    quoteItemId = json['quote_item_id'];
    rowInvoiced = json['row_invoiced'];
    rowTotal = json['row_total'];
    rowTotalInclTax = json['row_total_incl_tax'];
    rowWeight = json['row_weight'];
    sku = json['sku'];
    storeId = json['store_id'];
    taxAmount = json['tax_amount'];
    taxInvoiced = json['tax_invoiced'];
    taxPercent = json['tax_percent'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    productOption = json['product_option'] != null
        ? new ProductOption.fromJson(json['product_option'])
        : null;
    parentItemId = json['parent_item_id'];
    parentItem = json['parent_item'] != null
        ? new ParentItem.fromJson(json['parent_item'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount_refunded'] = this.amountRefunded;
    data['base_amount_refunded'] = this.baseAmountRefunded;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['base_discount_invoiced'] = this.baseDiscountInvoiced;
    data['base_discount_tax_compensation_amount'] =
        this.baseDiscountTaxCompensationAmount;
    data['base_original_price'] = this.baseOriginalPrice;
    data['base_price'] = this.basePrice;
    data['base_price_incl_tax'] = this.basePriceInclTax;
    data['base_row_invoiced'] = this.baseRowInvoiced;
    data['base_row_total'] = this.baseRowTotal;
    data['base_row_total_incl_tax'] = this.baseRowTotalInclTax;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['base_tax_invoiced'] = this.baseTaxInvoiced;
    data['created_at'] = this.createdAt;
    data['discount_amount'] = this.discountAmount;
    data['discount_invoiced'] = this.discountInvoiced;
    data['discount_percent'] = this.discountPercent;
    data['free_shipping'] = this.freeShipping;
    data['discount_tax_compensation_amount'] =
        this.discountTaxCompensationAmount;
    data['is_qty_decimal'] = this.isQtyDecimal;
    data['is_virtual'] = this.isVirtual;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['no_discount'] = this.noDiscount;
    data['order_id'] = this.orderId;
    data['original_price'] = this.originalPrice;
    data['price'] = this.price;
    data['price_incl_tax'] = this.priceInclTax;
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['qty_canceled'] = this.qtyCanceled;
    data['qty_invoiced'] = this.qtyInvoiced;
    data['qty_ordered'] = this.qtyOrdered;
    data['qty_refunded'] = this.qtyRefunded;
    data['qty_shipped'] = this.qtyShipped;
    data['quote_item_id'] = this.quoteItemId;
    data['row_invoiced'] = this.rowInvoiced;
    data['row_total'] = this.rowTotal;
    data['row_total_incl_tax'] = this.rowTotalInclTax;
    data['row_weight'] = this.rowWeight;
    data['sku'] = this.sku;
    data['store_id'] = this.storeId;
    data['tax_amount'] = this.taxAmount;
    data['tax_invoiced'] = this.taxInvoiced;
    data['tax_percent'] = this.taxPercent;
    data['updated_at'] = this.updatedAt;
    data['weight'] = this.weight;
    if (this.productOption != null) {
      data['product_option'] = this.productOption.toJson();
    }
    data['parent_item_id'] = this.parentItemId;
    if (this.parentItem != null) {
      data['parent_item'] = this.parentItem.toJson();
    }
    return data;
  }
}

class ProductOption {
  ExtensionAttributes extensionAttributes;

  ProductOption({this.extensionAttributes});

  ProductOption.fromJson(Map<String, dynamic> json) {
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    return data;
  }
}

class ExtensionAttributes {
  List<ConfigurableItemOptions> configurableItemOptions;

  ExtensionAttributes({this.configurableItemOptions});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['configurable_item_options'] != null) {
      configurableItemOptions = new List<ConfigurableItemOptions>();
      json['configurable_item_options'].forEach((v) {
        configurableItemOptions.add(new ConfigurableItemOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.configurableItemOptions != null) {
      data['configurable_item_options'] =
          this.configurableItemOptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConfigurableItemOptions {
  String optionId;
  int optionValue;

  ConfigurableItemOptions({this.optionId, this.optionValue});

  ConfigurableItemOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionValue = json['option_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['option_value'] = this.optionValue;
    return data;
  }
}

class ParentItem {
  int amountRefunded;
  int baseAmountRefunded;
  int baseDiscountAmount;
  int baseDiscountInvoiced;
  int baseDiscountTaxCompensationAmount;
  int baseOriginalPrice;
  int basePrice;
  int basePriceInclTax;
  int baseRowInvoiced;
  int baseRowTotal;
  int baseRowTotalInclTax;
  int baseTaxAmount;
  int baseTaxInvoiced;
  String createdAt;
  int discountAmount;
  int discountInvoiced;
  int discountPercent;
  int freeShipping;
  int discountTaxCompensationAmount;
  int isQtyDecimal;
  int isVirtual;
  int itemId;
  String name;
  int noDiscount;
  int orderId;
  int originalPrice;
  int price;
  int priceInclTax;
  int productId;
  String productType;
  int qtyCanceled;
  int qtyInvoiced;
  int qtyOrdered;
  int qtyRefunded;
  int qtyShipped;
  int quoteItemId;
  int rowInvoiced;
  int rowTotal;
  int rowTotalInclTax;
  int rowWeight;
  String sku;
  int storeId;
  int taxAmount;
  int taxInvoiced;
  int taxPercent;
  String updatedAt;
  int weight;
  ProductOption productOption;

  ParentItem(
      {this.amountRefunded,
        this.baseAmountRefunded,
        this.baseDiscountAmount,
        this.baseDiscountInvoiced,
        this.baseDiscountTaxCompensationAmount,
        this.baseOriginalPrice,
        this.basePrice,
        this.basePriceInclTax,
        this.baseRowInvoiced,
        this.baseRowTotal,
        this.baseRowTotalInclTax,
        this.baseTaxAmount,
        this.baseTaxInvoiced,
        this.createdAt,
        this.discountAmount,
        this.discountInvoiced,
        this.discountPercent,
        this.freeShipping,
        this.discountTaxCompensationAmount,
        this.isQtyDecimal,
        this.isVirtual,
        this.itemId,
        this.name,
        this.noDiscount,
        this.orderId,
        this.originalPrice,
        this.price,
        this.priceInclTax,
        this.productId,
        this.productType,
        this.qtyCanceled,
        this.qtyInvoiced,
        this.qtyOrdered,
        this.qtyRefunded,
        this.qtyShipped,
        this.quoteItemId,
        this.rowInvoiced,
        this.rowTotal,
        this.rowTotalInclTax,
        this.rowWeight,
        this.sku,
        this.storeId,
        this.taxAmount,
        this.taxInvoiced,
        this.taxPercent,
        this.updatedAt,
        this.weight,
        this.productOption});

  ParentItem.fromJson(Map<String, dynamic> json) {
    amountRefunded = json['amount_refunded'];
    baseAmountRefunded = json['base_amount_refunded'];
    baseDiscountAmount = json['base_discount_amount'];
    baseDiscountInvoiced = json['base_discount_invoiced'];
    baseDiscountTaxCompensationAmount =
    json['base_discount_tax_compensation_amount'];
    baseOriginalPrice = json['base_original_price'];
    basePrice = json['base_price'];
    basePriceInclTax = json['base_price_incl_tax'];
    baseRowInvoiced = json['base_row_invoiced'];
    baseRowTotal = json['base_row_total'];
    baseRowTotalInclTax = json['base_row_total_incl_tax'];
    baseTaxAmount = json['base_tax_amount'];
    baseTaxInvoiced = json['base_tax_invoiced'];
    createdAt = json['created_at'];
    discountAmount = json['discount_amount'];
    discountInvoiced = json['discount_invoiced'];
    discountPercent = json['discount_percent'];
    freeShipping = json['free_shipping'];
    discountTaxCompensationAmount = json['discount_tax_compensation_amount'];
    isQtyDecimal = json['is_qty_decimal'];
    isVirtual = json['is_virtual'];
    itemId = json['item_id'];
    name = json['name'];
    noDiscount = json['no_discount'];
    orderId = json['order_id'];
    originalPrice = json['original_price'];
    price = json['price'];
    priceInclTax = json['price_incl_tax'];
    productId = json['product_id'];
    productType = json['product_type'];
    qtyCanceled = json['qty_canceled'];
    qtyInvoiced = json['qty_invoiced'];
    qtyOrdered = json['qty_ordered'];
    qtyRefunded = json['qty_refunded'];
    qtyShipped = json['qty_shipped'];
    quoteItemId = json['quote_item_id'];
    rowInvoiced = json['row_invoiced'];
    rowTotal = json['row_total'];
    rowTotalInclTax = json['row_total_incl_tax'];
    rowWeight = json['row_weight'];
    sku = json['sku'];
    storeId = json['store_id'];
    taxAmount = json['tax_amount'];
    taxInvoiced = json['tax_invoiced'];
    taxPercent = json['tax_percent'];
    updatedAt = json['updated_at'];
    weight = json['weight'];
    productOption = json['product_option'] != null
        ? new ProductOption.fromJson(json['product_option'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount_refunded'] = this.amountRefunded;
    data['base_amount_refunded'] = this.baseAmountRefunded;
    data['base_discount_amount'] = this.baseDiscountAmount;
    data['base_discount_invoiced'] = this.baseDiscountInvoiced;
    data['base_discount_tax_compensation_amount'] =
        this.baseDiscountTaxCompensationAmount;
    data['base_original_price'] = this.baseOriginalPrice;
    data['base_price'] = this.basePrice;
    data['base_price_incl_tax'] = this.basePriceInclTax;
    data['base_row_invoiced'] = this.baseRowInvoiced;
    data['base_row_total'] = this.baseRowTotal;
    data['base_row_total_incl_tax'] = this.baseRowTotalInclTax;
    data['base_tax_amount'] = this.baseTaxAmount;
    data['base_tax_invoiced'] = this.baseTaxInvoiced;
    data['created_at'] = this.createdAt;
    data['discount_amount'] = this.discountAmount;
    data['discount_invoiced'] = this.discountInvoiced;
    data['discount_percent'] = this.discountPercent;
    data['free_shipping'] = this.freeShipping;
    data['discount_tax_compensation_amount'] =
        this.discountTaxCompensationAmount;
    data['is_qty_decimal'] = this.isQtyDecimal;
    data['is_virtual'] = this.isVirtual;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['no_discount'] = this.noDiscount;
    data['order_id'] = this.orderId;
    data['original_price'] = this.originalPrice;
    data['price'] = this.price;
    data['price_incl_tax'] = this.priceInclTax;
    data['product_id'] = this.productId;
    data['product_type'] = this.productType;
    data['qty_canceled'] = this.qtyCanceled;
    data['qty_invoiced'] = this.qtyInvoiced;
    data['qty_ordered'] = this.qtyOrdered;
    data['qty_refunded'] = this.qtyRefunded;
    data['qty_shipped'] = this.qtyShipped;
    data['quote_item_id'] = this.quoteItemId;
    data['row_invoiced'] = this.rowInvoiced;
    data['row_total'] = this.rowTotal;
    data['row_total_incl_tax'] = this.rowTotalInclTax;
    data['row_weight'] = this.rowWeight;
    data['sku'] = this.sku;
    data['store_id'] = this.storeId;
    data['tax_amount'] = this.taxAmount;
    data['tax_invoiced'] = this.taxInvoiced;
    data['tax_percent'] = this.taxPercent;
    data['updated_at'] = this.updatedAt;
    data['weight'] = this.weight;
    if (this.productOption != null) {
      data['product_option'] = this.productOption.toJson();
    }
    return data;
  }
}

class BillingAddress {
  String addressType;
  String city;
  String countryId;
  int customerAddressId;
  String email;
  int entityId;
  String firstname;
  String lastname;
  int parentId;
  String postcode;
  String region;
  String regionCode;
  int regionId;
  List<String> street;
  String telephone;

  BillingAddress(
      {this.addressType,
        this.city,
        this.countryId,
        this.customerAddressId,
        this.email,
        this.entityId,
        this.firstname,
        this.lastname,
        this.parentId,
        this.postcode,
        this.region,
        this.regionCode,
        this.regionId,
        this.street,
        this.telephone});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    addressType = json['address_type'];
    city = json['city'];
    countryId = json['country_id'];
    customerAddressId = json['customer_address_id'];
    email = json['email'];
    entityId = json['entity_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    parentId = json['parent_id'];
    postcode = json['postcode'];
    region = json['region'];
    regionCode = json['region_code'];
    regionId = json['region_id'];
    street = json['street'].cast<String>();
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_type'] = this.addressType;
    data['city'] = this.city;
    data['country_id'] = this.countryId;
    data['customer_address_id'] = this.customerAddressId;
    data['email'] = this.email;
    data['entity_id'] = this.entityId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['parent_id'] = this.parentId;
    data['postcode'] = this.postcode;
    data['region'] = this.region;
    data['region_code'] = this.regionCode;
    data['region_id'] = this.regionId;
    data['street'] = this.street;
    data['telephone'] = this.telephone;
    return data;
  }
}

class Payment {
  String accountStatus;
  List<String> additionalInformation;
  int amountOrdered;
  int baseAmountOrdered;
  int baseShippingAmount;
  String ccExpYear;
  String ccLast4;
  String ccSsStartMonth;
  String ccSsStartYear;
  int entityId;
  String method;
  int parentId;
  int shippingAmount;

  Payment(
      {this.accountStatus,
        this.additionalInformation,
        this.amountOrdered,
        this.baseAmountOrdered,
        this.baseShippingAmount,
        this.ccExpYear,
        this.ccLast4,
        this.ccSsStartMonth,
        this.ccSsStartYear,
        this.entityId,
        this.method,
        this.parentId,
        this.shippingAmount});

  Payment.fromJson(Map<String, dynamic> json) {
    accountStatus = json['account_status']?.toString();
    additionalInformation = json['additional_information'].cast<String>();
    amountOrdered = json['amount_ordered'];
    baseAmountOrdered = json['base_amount_ordered'];
    baseShippingAmount = json['base_shipping_amount'];
    ccExpYear = json['cc_exp_year'];
    ccLast4 = json['cc_last4']?.toString();
    ccSsStartMonth = json['cc_ss_start_month'];
    ccSsStartYear = json['cc_ss_start_year'];
    entityId = json['entity_id'];
    method = json['method'];
    parentId = json['parent_id'];
    shippingAmount = json['shipping_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_status'] = this.accountStatus;
    data['additional_information'] = this.additionalInformation;
    data['amount_ordered'] = this.amountOrdered;
    data['base_amount_ordered'] = this.baseAmountOrdered;
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['cc_exp_year'] = this.ccExpYear;
    data['cc_last4'] = this.ccLast4;
    data['cc_ss_start_month'] = this.ccSsStartMonth;
    data['cc_ss_start_year'] = this.ccSsStartYear;
    data['entity_id'] = this.entityId;
    data['method'] = this.method;
    data['parent_id'] = this.parentId;
    data['shipping_amount'] = this.shippingAmount;
    return data;
  }
}

class Extension {
  List<ShippingAssignments> shippingAssignments;
  List<PaymentAdditionalInfo> paymentAdditionalInfo;
  List appliedTaxes;
  List itemAppliedTaxes;

  Extension(
      {this.shippingAssignments,
        this.paymentAdditionalInfo,
        this.appliedTaxes,
        this.itemAppliedTaxes});

  Extension.fromJson(Map<String, dynamic> json) {
    if (json['shipping_assignments'] != null) {
      shippingAssignments = new List<ShippingAssignments>();
      json['shipping_assignments'].forEach((v) {
        shippingAssignments.add(new ShippingAssignments.fromJson(v));
      });
    }
    if (json['payment_additional_info'] != null) {
      paymentAdditionalInfo = new List<PaymentAdditionalInfo>();
      json['payment_additional_info'].forEach((v) {
        paymentAdditionalInfo.add(new PaymentAdditionalInfo.fromJson(v));
      });
    }
    if (json['applied_taxes'] != null) {
      appliedTaxes = json['applied_taxes'];
    }
    if (json['item_applied_taxes'] != null) {
      itemAppliedTaxes = json['item_applied_taxes'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingAssignments != null) {
      data['shipping_assignments'] =
          this.shippingAssignments.map((v) => v.toJson()).toList();
    }
    if (this.paymentAdditionalInfo != null) {
      data['payment_additional_info'] =
          this.paymentAdditionalInfo.map((v) => v.toJson()).toList();
    }
    if (this.appliedTaxes != null) {
      data['applied_taxes'] = this.appliedTaxes.map((v) => v.toJson()).toList();
    }
    if (this.itemAppliedTaxes != null) {
      data['item_applied_taxes'] =
          this.itemAppliedTaxes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingAssignments {
  Shipping shipping;
  List<Items> items;

  ShippingAssignments({this.shipping, this.items});

  ShippingAssignments.fromJson(Map<String, dynamic> json) {
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipping {
  Total total;

  Shipping({this.total});

  Shipping.fromJson(Map<String, dynamic> json) {
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    return data;
  }
}

class Total {
  int baseShippingAmount;
  int baseShippingDiscountAmount;
  int baseShippingDiscountTaxCompensationAmnt;
  int baseShippingInclTax;
  int baseShippingTaxAmount;
  int shippingAmount;
  int shippingDiscountAmount;
  int shippingDiscountTaxCompensationAmount;
  int shippingInclTax;
  int shippingTaxAmount;

  Total(
      {this.baseShippingAmount,
        this.baseShippingDiscountAmount,
        this.baseShippingDiscountTaxCompensationAmnt,
        this.baseShippingInclTax,
        this.baseShippingTaxAmount,
        this.shippingAmount,
        this.shippingDiscountAmount,
        this.shippingDiscountTaxCompensationAmount,
        this.shippingInclTax,
        this.shippingTaxAmount});

  Total.fromJson(Map<String, dynamic> json) {
    baseShippingAmount = json['base_shipping_amount'];
    baseShippingDiscountAmount = json['base_shipping_discount_amount'];
    baseShippingDiscountTaxCompensationAmnt =
    json['base_shipping_discount_tax_compensation_amnt'];
    baseShippingInclTax = json['base_shipping_incl_tax'];
    baseShippingTaxAmount = json['base_shipping_tax_amount'];
    shippingAmount = json['shipping_amount'];
    shippingDiscountAmount = json['shipping_discount_amount'];
    shippingDiscountTaxCompensationAmount =
    json['shipping_discount_tax_compensation_amount'];
    shippingInclTax = json['shipping_incl_tax'];
    shippingTaxAmount = json['shipping_tax_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_shipping_amount'] = this.baseShippingAmount;
    data['base_shipping_discount_amount'] = this.baseShippingDiscountAmount;
    data['base_shipping_discount_tax_compensation_amnt'] =
        this.baseShippingDiscountTaxCompensationAmnt;
    data['base_shipping_incl_tax'] = this.baseShippingInclTax;
    data['base_shipping_tax_amount'] = this.baseShippingTaxAmount;
    data['shipping_amount'] = this.shippingAmount;
    data['shipping_discount_amount'] = this.shippingDiscountAmount;
    data['shipping_discount_tax_compensation_amount'] =
        this.shippingDiscountTaxCompensationAmount;
    data['shipping_incl_tax'] = this.shippingInclTax;
    data['shipping_tax_amount'] = this.shippingTaxAmount;
    return data;
  }
}

class PaymentAdditionalInfo {
  String key;
  String value;

  PaymentAdditionalInfo({this.key, this.value});

  PaymentAdditionalInfo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
