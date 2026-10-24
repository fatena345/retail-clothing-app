class StatusClass {
  final String type;
  final String? message;
  final int? statusCode;
 const  StatusClass._({
  required this.type,
  this.statusCode,
  this.message});
  static const StatusClass initial = StatusClass._(type: 'Initial');
  static const StatusClass loading = StatusClass._(type: 'loading');
  static const StatusClass noInternet = StatusClass._(type: 'noInternet');
  static const StatusClass noData = StatusClass._(type: 'noData');
  static StatusClass serverError({
   int? statusCode,
   String? message,
  }) =>
      StatusClass._(
       type: 'serverError',
       statusCode: statusCode,
       message: message,
      );
  static const StatusClass success = StatusClass._(type: 'success');

  static StatusClass anotherError ({required String message}) => StatusClass._(type: 'anotherError : ', message: message);

  bool get isNoInternet => type == 'noInternet';
  bool get isNoData => type == 'noData';
  bool get isServerError => type == 'serverError';
  bool get isSuccess => type == 'success';
  bool get isLoading => type == 'loading';
  bool get isAnotherError => type == 'anotherError';

}