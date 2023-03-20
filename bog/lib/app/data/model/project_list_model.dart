// import 'dart:convert';
// /// id : "ff78ab5b-bb2b-4cea-99a4-ce59e8cddcf1"
// /// userId : "d2732310-d41a-4b64-870c-8734b0f560dd"
// /// title : "hey"
// /// description : ""
// /// projectTypes : "building_approval"
// /// status : "pending"
// /// createdAt : "2022-12-05T18:10:49.000Z"
// /// updatedAt : "2022-12-05T18:10:49.000Z"
// /// deletedAt : ""
// /// projectData : {"id":"80d78ed9-feec-4fa8-ac24-796dea933e7d","userId":"d2732310-d41a-4b64-870c-8734b0f560dd","projectId":"ff78ab5b-bb2b-4cea-99a4-ce59e8cddcf1","propertyName":"","propertyLocation":"","propertyLga":"","purpose":"Residential","propertyType":"","projectType":"","status":"pending","surveyPlan":"uploads/jHp3I2dIMG-20221205-WA0018.jpg","structuralPlan":"uploads/pVkVPi4IMG-20221205-WA0018.jpg","architecturalPlan":"uploads/pTLOP1IIMG-20221205-WA0018.jpg","mechanicalPlan":"uploads/kHaLeeRIMG-20221205-WA0018.jpg","electricalPlan":"uploads/nBLEbmrIMG-20221205-WA0018.jpg","soilTestReport":"uploads/rJc04HnIMG-20221205-WA0018.jpg","sitePlan":"uploads/kWM297TIMG-20221205-WA0018.jpg","siteAnalysisReport":"uploads/bUmw4jaIMG-20221205-WA0018.jpg","environmentImpactReport":"uploads/xggYSl8IMG-20221205-WA0018.jpg","clearanceCertificate":"uploads/prYMZ9CIMG-20221205-WA0018.jpg","supervisorLetter":"uploads/v1gKcQPIMG-20221205-WA0018.jpg","structuralCalculationSheet":"uploads/8yoP4v0IMG-20221205-WA0018.jpg","deedOfAgreement":"uploads/Hmsjhp3IMG-20221205-WA0018.jpg","createdAt":"2022-12-05T18:10:49.000Z","updatedAt":"2022-12-05T18:10:49.000Z","deletedAt":""}

// ProjectListModel projectListModelFromJson(String str) => ProjectListModel.fromJson(json.decode(str));
// String projectListModelToJson(ProjectListModel data) => json.encode(data.toJson());
// class ProjectListModel {
//   ProjectListModel({
//       String? id,
//       String? userId, 
//       String? title, 
//       String? description, 
//       String? projectTypes, 
//       String? status, 
//       String? createdAt, 
//       String? updatedAt, 
//       String? deletedAt, 
//       ProjectData? projectData,}){
//     _id = id;
//     _userId = userId;
//     _title = title;
//     _description = description;
//     _projectTypes = projectTypes;
//     _status = status;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _deletedAt = deletedAt;
//     _projectData = projectData;
// }

//   ProjectListModel.fromJson(dynamic json) {
//     _id = json['id'];
//     _userId = json['userId'];
//     _title = json['title'];
//     _description = json['description'];
//     _projectTypes = json['projectTypes'];
//     _status = json['status'];
//     _createdAt = json['createdAt'];
//     _updatedAt = json['updatedAt'];
//     _deletedAt = json['deletedAt'];
//     _projectData = json['projectData'] != null ? ProjectData.fromJson(json['projectData']) : null;
//   }
//   String? _id;
//   String? _userId;
//   String? _title;
//   String? _description;
//   String? _projectTypes;
//   String? _status;
//   String? _createdAt;
//   String? _updatedAt;
//   String? _deletedAt;
//   ProjectData? _projectData;
// ProjectListModel copyWith({  String? id,
//   String? userId,
//   String? title,
//   String? description,
//   String? projectTypes,
//   String? status,
//   String? createdAt,
//   String? updatedAt,
//   String? deletedAt,
//   ProjectData? projectData,
// }) => ProjectListModel(  id: id ?? _id,
//   userId: userId ?? _userId,
//   title: title ?? _title,
//   description: description ?? _description,
//   projectTypes: projectTypes ?? _projectTypes,
//   status: status ?? _status,
//   createdAt: createdAt ?? _createdAt,
//   updatedAt: updatedAt ?? _updatedAt,
//   deletedAt: deletedAt ?? _deletedAt,
//   projectData: projectData ?? _projectData,
// );
//   String? get id => _id;
//   String? get userId => _userId;
//   String? get title => _title;
//   String? get description => _description;
//   String? get projectTypes => _projectTypes;
//   String? get status => _status;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   String? get deletedAt => _deletedAt;
//   ProjectData? get projectData => _projectData;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['userId'] = _userId;
//     map['title'] = _title;
//     map['description'] = _description;
//     map['projectTypes'] = _projectTypes;
//     map['status'] = _status;
//     map['createdAt'] = _createdAt;
//     map['updatedAt'] = _updatedAt;
//     map['deletedAt'] = _deletedAt;
//     if (_projectData != null) {
//       map['projectData'] = _projectData?.toJson();
//     }
//     return map;
//   }

//   static List<ProjectListModel> fromJsonList(List list) {
//     if (list.isEmpty) return [];
//     return list.map((item) => ProjectListModel.fromJson(item)).toList();
//   }

// }

// /// id : "80d78ed9-feec-4fa8-ac24-796dea933e7d"
// /// userId : "d2732310-d41a-4b64-870c-8734b0f560dd"
// /// projectId : "ff78ab5b-bb2b-4cea-99a4-ce59e8cddcf1"
// /// propertyName : ""
// /// propertyLocation : ""
// /// propertyLga : ""
// /// purpose : "Residential"
// /// propertyType : ""
// /// projectType : ""
// /// status : "pending"
// /// surveyPlan : "uploads/jHp3I2dIMG-20221205-WA0018.jpg"
// /// structuralPlan : "uploads/pVkVPi4IMG-20221205-WA0018.jpg"
// /// architecturalPlan : "uploads/pTLOP1IIMG-20221205-WA0018.jpg"
// /// mechanicalPlan : "uploads/kHaLeeRIMG-20221205-WA0018.jpg"
// /// electricalPlan : "uploads/nBLEbmrIMG-20221205-WA0018.jpg"
// /// soilTestReport : "uploads/rJc04HnIMG-20221205-WA0018.jpg"
// /// sitePlan : "uploads/kWM297TIMG-20221205-WA0018.jpg"
// /// siteAnalysisReport : "uploads/bUmw4jaIMG-20221205-WA0018.jpg"
// /// environmentImpactReport : "uploads/xggYSl8IMG-20221205-WA0018.jpg"
// /// clearanceCertificate : "uploads/prYMZ9CIMG-20221205-WA0018.jpg"
// /// supervisorLetter : "uploads/v1gKcQPIMG-20221205-WA0018.jpg"
// /// structuralCalculationSheet : "uploads/8yoP4v0IMG-20221205-WA0018.jpg"
// /// deedOfAgreement : "uploads/Hmsjhp3IMG-20221205-WA0018.jpg"
// /// createdAt : "2022-12-05T18:10:49.000Z"
// /// updatedAt : "2022-12-05T18:10:49.000Z"
// /// deletedAt : ""

// ProjectData projectDataFromJson(String str) => ProjectData.fromJson(json.decode(str));
// String projectDataToJson(ProjectData data) => json.encode(data.toJson());
// class ProjectData {
//   ProjectData({
//       String? id, 
//       String? userId, 
//       String? projectId, 
//       String? propertyName, 
//       String? propertyLocation, 
//       String? propertyLga, 
//       String? purpose, 
//       String? propertyType, 
//       String? projectType, 
//       String? status, 
//       String? surveyPlan, 
//       String? structuralPlan, 
//       String? architecturalPlan, 
//       String? mechanicalPlan, 
//       String? electricalPlan, 
//       String? soilTestReport, 
//       String? sitePlan, 
//       String? siteAnalysisReport, 
//       String? environmentImpactReport, 
//       String? clearanceCertificate, 
//       String? supervisorLetter, 
//       String? structuralCalculationSheet, 
//       String? deedOfAgreement, 
//       String? createdAt, 
//       String? updatedAt, 
//       String? deletedAt,}){
//     _id = id;
//     _userId = userId;
//     _projectId = projectId;
//     _propertyName = propertyName;
//     _propertyLocation = propertyLocation;
//     _propertyLga = propertyLga;
//     _purpose = purpose;
//     _propertyType = propertyType;
//     _projectType = projectType;
//     _status = status;
//     _surveyPlan = surveyPlan;
//     _structuralPlan = structuralPlan;
//     _architecturalPlan = architecturalPlan;
//     _mechanicalPlan = mechanicalPlan;
//     _electricalPlan = electricalPlan;
//     _soilTestReport = soilTestReport;
//     _sitePlan = sitePlan;
//     _siteAnalysisReport = siteAnalysisReport;
//     _environmentImpactReport = environmentImpactReport;
//     _clearanceCertificate = clearanceCertificate;
//     _supervisorLetter = supervisorLetter;
//     _structuralCalculationSheet = structuralCalculationSheet;
//     _deedOfAgreement = deedOfAgreement;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _deletedAt = deletedAt;
// }

//   ProjectData.fromJson(dynamic json) {
//     _id = json['id'];
//     _userId = json['userId'];
//     _projectId = json['projectId'];
//     _propertyName = json['propertyName'];
//     _propertyLocation = json['propertyLocation'];
//     _propertyLga = json['propertyLga'];
//     _purpose = json['purpose'];
//     _propertyType = json['propertyType'];
//     _projectType = json['projectType'];
//     _status = json['status'];
//     _surveyPlan = json['surveyPlan'];
//     _structuralPlan = json['structuralPlan'];
//     _architecturalPlan = json['architecturalPlan'];
//     _mechanicalPlan = json['mechanicalPlan'];
//     _electricalPlan = json['electricalPlan'];
//     _soilTestReport = json['soilTestReport'];
//     _sitePlan = json['sitePlan'];
//     _siteAnalysisReport = json['siteAnalysisReport'];
//     _environmentImpactReport = json['environmentImpactReport'];
//     _clearanceCertificate = json['clearanceCertificate'];
//     _supervisorLetter = json['supervisorLetter'];
//     _structuralCalculationSheet = json['structuralCalculationSheet'];
//     _deedOfAgreement = json['deedOfAgreement'];
//     _createdAt = json['createdAt'];
//     _updatedAt = json['updatedAt'];
//     _deletedAt = json['deletedAt'];
//   }
//   String? _id;
//   String? _userId;
//   String? _projectId;
//   String? _propertyName;
//   String? _propertyLocation;
//   String? _propertyLga;
//   String? _purpose;
//   String? _propertyType;
//   String? _projectType;
//   String? _status;
//   String? _surveyPlan;
//   String? _structuralPlan;
//   String? _architecturalPlan;
//   String? _mechanicalPlan;
//   String? _electricalPlan;
//   String? _soilTestReport;
//   String? _sitePlan;
//   String? _siteAnalysisReport;
//   String? _environmentImpactReport;
//   String? _clearanceCertificate;
//   String? _supervisorLetter;
//   String? _structuralCalculationSheet;
//   String? _deedOfAgreement;
//   String? _createdAt;
//   String? _updatedAt;
//   String? _deletedAt;
// ProjectData copyWith({  String? id,
//   String? userId,
//   String? projectId,
//   String? propertyName,
//   String? propertyLocation,
//   String? propertyLga,
//   String? purpose,
//   String? propertyType,
//   String? projectType,
//   String? status,
//   String? surveyPlan,
//   String? structuralPlan,
//   String? architecturalPlan,
//   String? mechanicalPlan,
//   String? electricalPlan,
//   String? soilTestReport,
//   String? sitePlan,
//   String? siteAnalysisReport,
//   String? environmentImpactReport,
//   String? clearanceCertificate,
//   String? supervisorLetter,
//   String? structuralCalculationSheet,
//   String? deedOfAgreement,
//   String? createdAt,
//   String? updatedAt,
//   String? deletedAt,
// }) => ProjectData(  id: id ?? _id,
//   userId: userId ?? _userId,
//   projectId: projectId ?? _projectId,
//   propertyName: propertyName ?? _propertyName,
//   propertyLocation: propertyLocation ?? _propertyLocation,
//   propertyLga: propertyLga ?? _propertyLga,
//   purpose: purpose ?? _purpose,
//   propertyType: propertyType ?? _propertyType,
//   projectType: projectType ?? _projectType,
//   status: status ?? _status,
//   surveyPlan: surveyPlan ?? _surveyPlan,
//   structuralPlan: structuralPlan ?? _structuralPlan,
//   architecturalPlan: architecturalPlan ?? _architecturalPlan,
//   mechanicalPlan: mechanicalPlan ?? _mechanicalPlan,
//   electricalPlan: electricalPlan ?? _electricalPlan,
//   soilTestReport: soilTestReport ?? _soilTestReport,
//   sitePlan: sitePlan ?? _sitePlan,
//   siteAnalysisReport: siteAnalysisReport ?? _siteAnalysisReport,
//   environmentImpactReport: environmentImpactReport ?? _environmentImpactReport,
//   clearanceCertificate: clearanceCertificate ?? _clearanceCertificate,
//   supervisorLetter: supervisorLetter ?? _supervisorLetter,
//   structuralCalculationSheet: structuralCalculationSheet ?? _structuralCalculationSheet,
//   deedOfAgreement: deedOfAgreement ?? _deedOfAgreement,
//   createdAt: createdAt ?? _createdAt,
//   updatedAt: updatedAt ?? _updatedAt,
//   deletedAt: deletedAt ?? _deletedAt,
// );
//   String? get id => _id;
//   String? get userId => _userId;
//   String? get projectId => _projectId;
//   String? get propertyName => _propertyName;
//   String? get propertyLocation => _propertyLocation;
//   String? get propertyLga => _propertyLga;
//   String? get purpose => _purpose;
//   String? get propertyType => _propertyType;
//   String? get projectType => _projectType;
//   String? get status => _status;
//   String? get surveyPlan => _surveyPlan;
//   String? get structuralPlan => _structuralPlan;
//   String? get architecturalPlan => _architecturalPlan;
//   String? get mechanicalPlan => _mechanicalPlan;
//   String? get electricalPlan => _electricalPlan;
//   String? get soilTestReport => _soilTestReport;
//   String? get sitePlan => _sitePlan;
//   String? get siteAnalysisReport => _siteAnalysisReport;
//   String? get environmentImpactReport => _environmentImpactReport;
//   String? get clearanceCertificate => _clearanceCertificate;
//   String? get supervisorLetter => _supervisorLetter;
//   String? get structuralCalculationSheet => _structuralCalculationSheet;
//   String? get deedOfAgreement => _deedOfAgreement;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   String? get deletedAt => _deletedAt;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['userId'] = _userId;
//     map['projectId'] = _projectId;
//     map['propertyName'] = _propertyName;
//     map['propertyLocation'] = _propertyLocation;
//     map['propertyLga'] = _propertyLga;
//     map['purpose'] = _purpose;
//     map['propertyType'] = _propertyType;
//     map['projectType'] = _projectType;
//     map['status'] = _status;
//     map['surveyPlan'] = _surveyPlan;
//     map['structuralPlan'] = _structuralPlan;
//     map['architecturalPlan'] = _architecturalPlan;
//     map['mechanicalPlan'] = _mechanicalPlan;
//     map['electricalPlan'] = _electricalPlan;
//     map['soilTestReport'] = _soilTestReport;
//     map['sitePlan'] = _sitePlan;
//     map['siteAnalysisReport'] = _siteAnalysisReport;
//     map['environmentImpactReport'] = _environmentImpactReport;
//     map['clearanceCertificate'] = _clearanceCertificate;
//     map['supervisorLetter'] = _supervisorLetter;
//     map['structuralCalculationSheet'] = _structuralCalculationSheet;
//     map['deedOfAgreement'] = _deedOfAgreement;
//     map['createdAt'] = _createdAt;
//     map['updatedAt'] = _updatedAt;
//     map['deletedAt'] = _deletedAt;
//     return map;
//   }

// }