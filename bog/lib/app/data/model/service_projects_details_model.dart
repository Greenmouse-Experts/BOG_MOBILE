// To parse this JSON data, do
//
//     final serviceProjectDetailsModel = serviceProjectDetailsModelFromJson(jsonString);

import 'dart:convert';

class ServiceProjectDetailsModel {
    ServiceProjectDetailsModel({
        this.id,
        this.userId,
        this.title,
        this.projectSlug,
        this.description,
        this.projectTypes,
        this.status,
        this.approvalStatus,
        this.serviceProviderId,
        this.totalCost,
        this.estimatedCost,
        this.duration,
        this.progress,
        this.servicePartnerProgress,
        this.endDate,
        this.totalEndDate,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.serviceProvider,
        this.projectData,
        this.reviews,
        this.client,
        this.transactions,
    });

    String? id;
    String? userId;
    String? title;
    String? projectSlug;
    dynamic description;
    String? projectTypes;
    String? status;
    String? approvalStatus;
    String? serviceProviderId;
    int? totalCost;
    int? estimatedCost;
    int? duration;
    int? progress;
    dynamic servicePartnerProgress;
    DateTime? endDate;
    DateTime? totalEndDate;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    ServiceProvider? serviceProvider;
    List<ProjectDatum>? projectData;
    List<dynamic>? reviews;
    Client? client;
    Transactions? transactions;

    factory ServiceProjectDetailsModel.fromRawJson(String str) => ServiceProjectDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiceProjectDetailsModel.fromJson(Map<String, dynamic> json) => ServiceProjectDetailsModel(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        projectSlug: json["projectSlug"],
        description: json["description"],
        projectTypes: json["projectTypes"],
        status: json["status"],
        approvalStatus: json["approvalStatus"],
        serviceProviderId: json["serviceProviderId"],
        totalCost: json["totalCost"],
        estimatedCost: json["estimatedCost"],
        duration: json["duration"],
        progress: json["progress"],
        servicePartnerProgress: json["service_partner_progress"],
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        totalEndDate: json["totalEndDate"] == null ? null : DateTime.parse(json["totalEndDate"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        serviceProvider: json["serviceProvider"] == null ? null : ServiceProvider.fromJson(json["serviceProvider"]),
        projectData: json["projectData"] == null ? [] : List<ProjectDatum>.from(json["projectData"]!.map((x) => ProjectDatum.fromJson(x))),
        reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        transactions: json["transactions"] == null ? null : Transactions.fromJson(json["transactions"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "projectSlug": projectSlug,
        "description": description,
        "projectTypes": projectTypes,
        "status": status,
        "approvalStatus": approvalStatus,
        "serviceProviderId": serviceProviderId,
        "totalCost": totalCost,
        "estimatedCost": estimatedCost,
        "duration": duration,
        "progress": progress,
        "service_partner_progress": servicePartnerProgress,
        "endDate": endDate?.toIso8601String(),
        "totalEndDate": "${totalEndDate!.year.toString().padLeft(4, '0')}-${totalEndDate!.month.toString().padLeft(2, '0')}-${totalEndDate!.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "serviceProvider": serviceProvider?.toJson(),
        "projectData": projectData == null ? [] : List<dynamic>.from(projectData!.map((x) => x.toJson())),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
        "client": client?.toJson(),
        "transactions": transactions?.toJson(),
    };
}

class Client {
    Client({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.isActive,
        this.token,
        this.userType,
        this.address,
        this.state,
        this.city,
        this.street,
        this.level,
        this.photo,
        this.fname,
        this.lname,
        this.referralId,
        this.aboutUs,
        this.isSuspended,
        this.kycScore,
        this.kycTotal,
        this.app,
        this.facebookId,
        this.googleId,
        this.appleId,
        this.loginTrials,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    String? id;
    String? name;
    String? email;
    String? phone;
    bool? isActive;
    dynamic token;
    String? userType;
    String? address;
    String? state;
    String? city;
    dynamic street;
    int? level;
    dynamic photo;
    String? fname;
    String? lname;
    String? referralId;
    dynamic aboutUs;
    bool? isSuspended;
    String? kycScore;
    String? kycTotal;
    dynamic app;
    dynamic facebookId;
    dynamic googleId;
    dynamic appleId;
    dynamic loginTrials;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        isActive: json["isActive"],
        token: json["token"],
        userType: json["userType"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        street: json["street"],
        level: json["level"],
        photo: json["photo"],
        fname: json["fname"],
        lname: json["lname"],
        referralId: json["referralId"],
        aboutUs: json["aboutUs"],
        isSuspended: json["isSuspended"],
        kycScore: json["kycScore"],
        kycTotal: json["kycTotal"],
        app: json["app"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        appleId: json["apple_id"],
        loginTrials: json["login_trials"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "isActive": isActive,
        "token": token,
        "userType": userType,
        "address": address,
        "state": state,
        "city": city,
        "street": street,
        "level": level,
        "photo": photo,
        "fname": fname,
        "lname": lname,
        "referralId": referralId,
        "aboutUs": aboutUs,
        "isSuspended": isSuspended,
        "kycScore": kycScore,
        "kycTotal": kycTotal,
        "app": app,
        "facebook_id": facebookId,
        "google_id": googleId,
        "apple_id": appleId,
        "login_trials": loginTrials,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}

class ProjectDatum {
    ProjectDatum({
        this.id,
        this.userId,
        this.projectId,
        this.serviceFormId,
        this.value,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.serviceForm,
    });

    String? id;
    String? userId;
    String? projectId;
    String? serviceFormId;
    String? value;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    ServiceForm? serviceForm;

    factory ProjectDatum.fromRawJson(String str) => ProjectDatum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProjectDatum.fromJson(Map<String, dynamic> json) => ProjectDatum(
        id: json["id"],
        userId: json["userID"],
        projectId: json["projectID"],
        serviceFormId: json["serviceFormID"],
        value: json["value"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        serviceForm: json["serviceForm"] == null ? null : ServiceForm.fromJson(json["serviceForm"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "projectID": projectId,
        "serviceFormID": serviceFormId,
        "value": value,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "serviceForm": serviceForm?.toJson(),
    };
}

class ServiceForm {
    ServiceForm({
        this.id,
        this.serviceTypeId,
        this.serviceName,
        this.label,
        this.inputType,
        this.placeholder,
        this.name,
        this.value,
        this.required,
        this.isActive,
        this.access,
        this.inline,
        this.toggle,
        this.other,
        this.subLabel,
        this.selected,
        this.className,
        this.requireValidOption,
        this.multiple,
        this.subtype,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? serviceTypeId;
    String? serviceName;
    String? label;
    String? inputType;
    dynamic placeholder;
    String? name;
    String? value;
    dynamic required;
    bool? isActive;
    dynamic access;
    dynamic inline;
    dynamic toggle;
    dynamic other;
    String? subLabel;
    dynamic selected;
    String? className;
    dynamic requireValidOption;
    dynamic multiple;
    String? subtype;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory ServiceForm.fromRawJson(String str) => ServiceForm.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiceForm.fromJson(Map<String, dynamic> json) => ServiceForm(
        id: json["id"],
        serviceTypeId: json["serviceTypeID"],
        serviceName: json["serviceName"],
        label: json["label"],
        inputType: json["inputType"],
        placeholder: json["placeholder"],
        name: json["name"],
        value: json["value"],
        required: json["required"],
        isActive: json["isActive"],
        access: json["access"],
        inline: json["inline"],
        toggle: json["toggle"],
        other: json["other"],
        subLabel: json["subLabel"],
        selected: json["selected"],
        className: json["className"],
        requireValidOption: json["requireValidOption"],
        multiple: json["multiple"],
        subtype: json["subtype"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "serviceTypeID": serviceTypeId,
        "serviceName": serviceName,
        "label": label,
        "inputType": inputType,
        "placeholder": placeholder,
        "name": name,
        "value": value,
        "required": required,
        "isActive": isActive,
        "access": access,
        "inline": inline,
        "toggle": toggle,
        "other": other,
        "subLabel": subLabel,
        "selected": selected,
        "className": className,
        "requireValidOption": requireValidOption,
        "multiple": multiple,
        "subtype": subtype,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class ServiceProvider {
    ServiceProvider({
        this.id,
        this.userId,
        this.userType,
        this.isVerified,
        this.companyAddress,
        this.companyState,
        this.companyCity,
        this.companyStreet,
        this.companyName,
        this.cacNumber,
        this.tin,
        this.bvn,
        this.yearsOfExperience,
        this.certificateOfOperation,
        this.professionalCertificate,
        this.taxCertificate,
        this.serviceTypeId,
        this.kycPoint,
        this.planId,
        this.expiredAt,
        this.hasActiveSubscription,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.details,
    });

    String? id;
    String? userId;
    String? userType;
    bool? isVerified;
    dynamic companyAddress;
    dynamic companyState;
    dynamic companyCity;
    dynamic companyStreet;
    String? companyName;
    dynamic cacNumber;
    dynamic tin;
    dynamic bvn;
    dynamic yearsOfExperience;
    dynamic certificateOfOperation;
    dynamic professionalCertificate;
    dynamic taxCertificate;
    String? serviceTypeId;
    int? kycPoint;
    String? planId;
    DateTime? expiredAt;
    bool? hasActiveSubscription;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    Details? details;

    factory ServiceProvider.fromRawJson(String str) => ServiceProvider.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiceProvider.fromJson(Map<String, dynamic> json) => ServiceProvider(
        id: json["id"],
        userId: json["userId"],
        userType: json["userType"],
        isVerified: json["isVerified"],
        companyAddress: json["company_address"],
        companyState: json["company_state"],
        companyCity: json["company_city"],
        companyStreet: json["company_street"],
        companyName: json["company_name"],
        cacNumber: json["cac_number"],
        tin: json["tin"],
        bvn: json["bvn"],
        yearsOfExperience: json["years_of_experience"],
        certificateOfOperation: json["certificate_of_operation"],
        professionalCertificate: json["professional_certificate"],
        taxCertificate: json["tax_certificate"],
        serviceTypeId: json["serviceTypeId"],
        kycPoint: json["kycPoint"],
        planId: json["planId"],
        expiredAt: json["expiredAt"] == null ? null : DateTime.parse(json["expiredAt"]),
        hasActiveSubscription: json["hasActiveSubscription"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userType": userType,
        "isVerified": isVerified,
        "company_address": companyAddress,
        "company_state": companyState,
        "company_city": companyCity,
        "company_street": companyStreet,
        "company_name": companyName,
        "cac_number": cacNumber,
        "tin": tin,
        "bvn": bvn,
        "years_of_experience": yearsOfExperience,
        "certificate_of_operation": certificateOfOperation,
        "professional_certificate": professionalCertificate,
        "tax_certificate": taxCertificate,
        "serviceTypeId": serviceTypeId,
        "kycPoint": kycPoint,
        "planId": planId,
        "expiredAt": expiredAt?.toIso8601String(),
        "hasActiveSubscription": hasActiveSubscription,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "details": details?.toJson(),
    };
}

class Details {
    Details({
        this.name,
        this.email,
        this.phone,
        this.userType,
        this.createdAt,
        this.isActive,
        this.address,
        this.state,
        this.city,
        this.street,
    });

    String? name;
    String? email;
    String? phone;
    String? userType;
    DateTime? createdAt;
    bool? isActive;
    String? address;
    String? state;
    String? city;
    dynamic street;

    factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        userType: json["userType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        isActive: json["isActive"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        street: json["street"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "userType": userType,
        "createdAt": createdAt?.toIso8601String(),
        "isActive": isActive,
        "address": address,
        "state": state,
        "city": city,
        "street": street,
    };
}

class Transactions {
    Transactions({
        this.commitmentFee,
        this.payouts,
    });

    CommitmentFee? commitmentFee;
    List<CommitmentFee>? payouts;

    factory Transactions.fromRawJson(String str) => Transactions.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        commitmentFee: json["commitmentFee"] == null ? null : CommitmentFee.fromJson(json["commitmentFee"]),
        payouts: json["payouts"] == null ? [] : List<CommitmentFee>.from(json["payouts"]!.map((x) => CommitmentFee.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "commitmentFee": commitmentFee?.toJson(),
        "payouts": payouts == null ? [] : List<dynamic>.from(payouts!.map((x) => x.toJson())),
    };
}

class CommitmentFee {
    CommitmentFee({
        this.id,
        this.transactionId,
        this.userId,
        this.amount,
        this.status,
        this.type,
        this.paymentReference,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    String? id;
    String? transactionId;
    String? userId;
    int? amount;
    String? status;
    String? type;
    String? paymentReference;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory CommitmentFee.fromRawJson(String str) => CommitmentFee.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CommitmentFee.fromJson(Map<String, dynamic> json) => CommitmentFee(
        id: json["id"],
        transactionId: json["TransactionId"],
        userId: json["userId"],
        amount: json["amount"],
        status: json["status"],
        type: json["type"],
        paymentReference: json["paymentReference"],
        description: json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "TransactionId": transactionId,
        "userId": userId,
        "amount": amount,
        "status": status,
        "type": type,
        "paymentReference": paymentReference,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
