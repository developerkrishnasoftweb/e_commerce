class UserDetails {
  int id;
  int groupId;
  String defaultBilling;
  String defaultShipping;
  String createdAt;
  String updatedAt;
  String createdIn;
  String dob;
  String email;
  String firstname;
  String lastname;
  int gender;
  int storeId;
  int websiteId;
  List<Addresses> addresses;
  int disableAutoGroupChange;
  ExtensionAttributes extensionAttributes;
  List<CustomAttributes> customAttributes;

  UserDetails(
      {this.id,
        this.groupId,
        this.defaultBilling,
        this.defaultShipping,
        this.createdAt,
        this.updatedAt,
        this.createdIn,
        this.dob,
        this.email,
        this.firstname,
        this.lastname,
        this.gender,
        this.storeId,
        this.websiteId,
        this.addresses,
        this.disableAutoGroupChange,
        this.extensionAttributes,
        this.customAttributes});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    defaultBilling = json['default_billing'];
    defaultShipping = json['default_shipping'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdIn = json['created_in'];
    dob = json['dob'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    storeId = json['store_id'];
    websiteId = json['website_id'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    disableAutoGroupChange = json['disable_auto_group_change'];
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['custom_attributes'] != null) {
      customAttributes = new List<CustomAttributes>();
      json['custom_attributes'].forEach((v) {
        customAttributes.add(new CustomAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['default_billing'] = this.defaultBilling;
    data['default_shipping'] = this.defaultShipping;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_in'] = this.createdIn;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    data['store_id'] = this.storeId;
    data['website_id'] = this.websiteId;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['disable_auto_group_change'] = this.disableAutoGroupChange;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    if (this.customAttributes != null) {
      data['custom_attributes'] =
          this.customAttributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int id;
  int customerId;
  Region region;
  int regionId;
  String countryId;
  List<String> street;
  String company;
  String telephone;
  String postcode;
  String city;
  String firstname;
  String lastname;
  bool defaultShipping;
  bool defaultBilling;

  Addresses(
      {this.id,
        this.customerId,
        this.region,
        this.regionId,
        this.countryId,
        this.street,
        this.company,
        this.telephone,
        this.postcode,
        this.city,
        this.firstname,
        this.lastname,
        this.defaultShipping,
        this.defaultBilling});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    region =
    json['region'] != null ? new Region.fromJson(json['region']) : null;
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    company = json['company'];
    telephone = json['telephone'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    defaultShipping = json['default_shipping'];
    defaultBilling = json['default_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    data['region_id'] = this.regionId;
    data['country_id'] = this.countryId;
    data['street'] = this.street;
    data['company'] = this.company;
    data['telephone'] = this.telephone;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['default_shipping'] = this.defaultShipping;
    data['default_billing'] = this.defaultBilling;
    return data;
  }
}

class Region {
  String regionCode;
  String region;
  int regionId;

  Region({this.regionCode, this.region, this.regionId});

  Region.fromJson(Map<String, dynamic> json) {
    regionCode = json['region_code'];
    region = json['region'];
    regionId = json['region_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_code'] = this.regionCode;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    return data;
  }
}

class ExtensionAttributes {
  bool isSubscribed;

  ExtensionAttributes({this.isSubscribed});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    isSubscribed = json['is_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_subscribed'] = this.isSubscribed;
    return data;
  }
}

class CustomAttributes {
  String attributeCode;
  String value;

  CustomAttributes({this.attributeCode, this.value});

  CustomAttributes.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_code'] = this.attributeCode;
    data['value'] = this.value;
    return data;
  }
}