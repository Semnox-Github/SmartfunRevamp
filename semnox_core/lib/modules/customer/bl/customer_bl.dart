import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_login_request_dto.dart';
import 'package:semnox_core/modules/customer/repository/customer_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class CustomerBL {
  CustomerDTO? _customerDTO;
  int? _customerId;
  CustomerRepository? _customerRepository;

  CustomerBL.id(ExecutionContextDTO executionContextDTO, int id) {
    _customerRepository = CustomerRepository(executionContextDTO);
    _customerId = id;
  }

  CustomerBL.dto(ExecutionContextDTO executionContextDTO, CustomerDTO customerDTO) {
    _customerDTO = customerDTO;
    _customerRepository = CustomerRepository(executionContextDTO);
  }

  Future<CustomerDTO?> create() async {
    return _customerDTO;
  }

  Future<CustomerDTO?> signUp() async {
    _customerDTO = await _customerRepository?.signUp(_customerDTO);
    return _customerDTO;
  }

  Future<CustomerDTO?> update() async {
    return _customerDTO;
  }

  Future<CustomerDTO?> login(String password) async {
    var customerLoginRequestDTO = CustomerLoginRequestDTO(username: _customerDTO?.userName, password: password).toJson();
    final response = await _customerRepository?.login(customerLoginRequestDTO);
    return CustomerDTO.fromJson(response!);
  }

  Future<CustomerDTO?> getCustomerDTObyId() async {
    Map<CustomerDTOSearchParameter, dynamic> params = {
      CustomerDTOSearchParameter.customerId: _customerId,
      CustomerDTOSearchParameter.buildChildRecords: true,
      CustomerDTOSearchParameter.loadAdultOnly: true,
    };
    List<CustomerDTO>? customerDTOList = await _customerRepository?.getCustomerDTOList(params);
    if (customerDTOList!.isNotEmpty) {
      _customerDTO = customerDTOList.first;
    }
    return _customerDTO;
  }
}
