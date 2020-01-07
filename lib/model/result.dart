

import 'package:carros/enuns/status.dart';

class Result<T>{
  Status status;
  T data;
  String message;

  Result.success(this.data){
    status = Status.SUCCESS;
  }

  Result.loading(){
    status = Status.LOADING;
  }

  Result.error(this.message){
    status = Status.ERROR;
  }




}