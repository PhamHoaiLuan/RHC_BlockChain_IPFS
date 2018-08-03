pragma solidity ^0.4.18;

contract RemoteHealthcareSystem {
   
    //******************************************************//
    //******************************************************//
    //                                                      //
    //           Remote Healthcare System Owner             //
    //                                                      //
    //******************************************************//
    //******************************************************// 
    
    //*********** Create Smart Contract ***********//
    
    address public Remote_Healthcare_System_Owner;
    
    modifier onlyOwner() {
        require(msg.sender == Remote_Healthcare_System_Owner);
        _;
    }
    
    function RemoteHealthcareSystem() public {
        Remote_Healthcare_System_Owner = msg.sender;
    }
    
    //*********** Add Registrar ***********//
    
    uint    public Registrar_Id;
    
    event Registrar_Added(address _address);
    event Registrar_Modified(address _address);
    event Registrar_Removed(address _address);
    
    struct Registrar {
        bool    IsRegistered;
        uint    Registrar_ID;
        string  Registrar_Name;
        uint8   Registrar_Age;
        string  Registrar_Address;
    }
    
    mapping (address => Registrar) registrars;
    
    function Add_Registrar(address _address,string _Registrar_Name, uint8 _Registrar_Age,string _Registrar_Address) onlyOwner public {
        
        require(_address != 0);
        var registrar           = registrars[_address];
        require(registrar.IsRegistered == false);
        
        Registrar_Id++;
        registrar.Registrar_ID      = Registrar_Id;
        registrar.Registrar_Name    = _Registrar_Name;
        registrar.Registrar_Age     = _Registrar_Age;
        registrar.Registrar_Address = _Registrar_Address;
        registrar.IsRegistered      = true;
        
        Registrar_Added(_address);
        
    }
    
    function Modify_Registrar(address _address,string _Registrar_Name, uint8 _Registrar_Age,string _Registrar_Address) onlyOwner public {
        
        require(_address != 0);
        var registrar           = registrars[_address];
        require(registrar.IsRegistered == true);
        
        registrar.Registrar_Name    = _Registrar_Name;
        registrar.Registrar_Age     = _Registrar_Age;
        registrar.Registrar_Address = _Registrar_Address;
        
        Registrar_Modified(_address);
        
    }
    
    function Remove_Registrar(address _address) onlyOwner public {
        
        require(_address != 0);
        var registrar           = registrars[_address];
        require(registrar.IsRegistered == true);
        
        registrar.IsRegistered = false;
        
        Registrar_Removed(_address);
        
    }

    function Get_Registrar(address _address) view public returns (uint, string, uint8, string) {
        
        require(registrars[_address].IsRegistered == true); 
        
        require((msg.sender == Remote_Healthcare_System_Owner)||(msg.sender == _address));
        
        return (registrars[_address].Registrar_ID, registrars[_address].Registrar_Name, registrars[_address].Registrar_Age, registrars[_address].Registrar_Address);
    }
    
    //*********** Add Authorizer ***********//
    
    uint    public Authorizer_Id;
    
    event Authorizer_Added(address _address);
    event Authorizer_Modified(address _address);
    event Authorizer_Removed(address _address);
    
    struct Authorizer {
        bool    IsRegistered;
        uint    Authorizer_ID;
        string  Authorizer_Name;
        uint8   Authorizer_Age;
        string  Authorizer_Address;
    }
    
    mapping (address => Authorizer) authorizers;
    
    function Add_Authorizer(address _address,string _Authorizer_Name, uint8 _Authorizer_Age,string _Authorizer_Address) onlyOwner public {
        
        require(_address != 0);
        var authorizer           = authorizers[_address];
        require(authorizer.IsRegistered == false);
        
        Authorizer_Id++;
        authorizer.Authorizer_ID      = Authorizer_Id;
        authorizer.Authorizer_Name    = _Authorizer_Name;
        authorizer.Authorizer_Age     = _Authorizer_Age;
        authorizer.Authorizer_Address = _Authorizer_Address;
        authorizer.IsRegistered       = true;
        
        Authorizer_Added(_address);
        
    }
    
    function Modify_Authorizer(address _address,string _Authorizer_Name, uint8 _Authorizer_Age,string _Authorizer_Address) onlyOwner public {
        
        require(_address != 0);
        var authorizer           = authorizers[_address];
        require(authorizer.IsRegistered == true);
        
        authorizer.Authorizer_Name    = _Authorizer_Name;
        authorizer.Authorizer_Age     = _Authorizer_Age;
        authorizer.Authorizer_Address = _Authorizer_Address;
        
        Authorizer_Modified(_address);
        
    }
    
    function Remove_Authorizer(address _address) onlyOwner public {
        
        require(_address != 0);
        var authorizer           = authorizers[_address];
        require(authorizer.IsRegistered == true);
        
        authorizer.IsRegistered = false;
        
        Authorizer_Removed(_address);
        
    }
    
    function Get_Authorizer(address _address) view public returns (uint, string, uint8, string) {
        
        require(authorizers[_address].IsRegistered == true); 
        
        require((msg.sender == Remote_Healthcare_System_Owner)||(msg.sender == _address));
        
        return (authorizers[_address].Authorizer_ID, authorizers[_address].Authorizer_Name, authorizers[_address].Authorizer_Age, authorizers[_address].Authorizer_Address);
    }

    //******************************************************//
    //******************************************************//
    //                                                      //
    //                       Registrar                      //
    //                                                      //
    //******************************************************//
    //******************************************************//
    
    //*********** Add Doctor ***********//
     
    uint    public NumberOfDoctors;
    uint    public Doctor_Id;
    
    event Doctor_Added(address _address);
    event Doctor_Modified(address _address);
    event Doctor_Removed(address _address);
    
    struct Doctor {
        bool    IsRegistered;
        uint    Doctor_ID;
        string  Doctor_Name;
        uint8   Doctor_Age;
        string  Doctor_Address;
    }
    
    modifier onlyRegistrar(address _address){
        require(registrars[_address].IsRegistered == true);
        _;
    }
    
    mapping (address => Doctor) doctors;
    
    function Add_Doctor(address _address,string _Doctor_Name, uint8 _Doctor_Age,string _Doctor_Address) onlyRegistrar(msg.sender) public {
        
        require(_address != 0);
        
        var doctor              = doctors[_address];
        
        require(doctor.IsRegistered == false);
        
        Doctor_Id++;
        doctor.Doctor_ID        =  Doctor_Id;
        doctor.Doctor_Name      = _Doctor_Name;
        doctor.Doctor_Age       = _Doctor_Age;
        doctor.Doctor_Address   = _Doctor_Address;
        doctor.IsRegistered     =  true;
        NumberOfDoctors++;
        
        Doctor_Added(_address);
        
    }
    
    function Modify_Doctor(address _address,string _Doctor_Name, uint8 _Doctor_Age,string _Doctor_Address) onlyRegistrar(msg.sender) public {
        
        require(_address != 0);
        
        var doctor              = doctors[_address];
        
        require(doctor.IsRegistered == true);
        
        doctors[_address].Doctor_Name       = _Doctor_Name;
        doctors[_address].Doctor_Age        = _Doctor_Age;
        doctors[_address].Doctor_Address    = _Doctor_Address;
        
        Doctor_Modified(_address);
        
    }
    
    function Remove_Doctor(address _address) onlyRegistrar(msg.sender) public {
       
        var doctor              = doctors[_address];
        require(doctor.IsRegistered == true);

        doctor.IsRegistered = false;
 
        Doctor_Removed(_address);
    }
    
    function Get_Doctor(address _address) view public  returns (uint, string, uint8, string) {
        require( doctors[_address].IsRegistered == true);
        require((registrars[msg.sender].IsRegistered == true)||(msg.sender == _address));
        
        return (doctors[_address].Doctor_ID, doctors[_address].Doctor_Name, doctors[_address].Doctor_Age, doctors[_address].Doctor_Address);
    }
        
    //*********** Add Patient ***********//
    
    uint    public NumberOfPatients;
    uint    public Patient_Id;
    
    event Patient_Added(address _address);
    event Patient_Modified(address _address);
    event Patient_Removed(address _address);
    
    struct Patient {
        bool    IsRegistered;
        uint    Patient_ID;
        string  Patient_Name;
        uint8   Patient_Age;
        string  Patient_Address;
    }
    
    mapping (address => Patient) patients;
    
    function Add_Patient(address _address,string _Patient_Name, uint8 _Patient_Age,string _Patient_Address) onlyRegistrar(msg.sender) public {
        
        require(_address != 0);
        
        var patient              = patients[_address];
        
        require(patient.IsRegistered == false);
        
        Patient_Id++;
        patient.Patient_ID      = Patient_Id;
        patient.Patient_Name    = _Patient_Name;
        patient.Patient_Age     = _Patient_Age;
        patient.Patient_Address = _Patient_Address;
        patient.IsRegistered    =  true;
        NumberOfPatients++;

        Patient_Added(_address);
        
    }
    
    function Modify_Patient(address _address,string _Patient_Name, uint8 _Patient_Age,string _Patient_Address) onlyRegistrar(msg.sender) public {
        
        require(patients[_address].IsRegistered == true);
        
        patients[_address].Patient_Name     = _Patient_Name;
        patients[_address].Patient_Age      = _Patient_Age;
        patients[_address].Patient_Address  = _Patient_Address;
        
        Patient_Modified(_address);
        
    }
    
    function Remove_Patient(address _address) onlyRegistrar(msg.sender) public {
        
        require(patients[_address].IsRegistered == true);
        
        patients[_address].IsRegistered = false;
        
        NumberOfPatients--;
        Patient_Removed(_address);
    }
    
    function Get_Patient(address _address) view public returns (uint, string, uint8, string) {
        
        require(patients[_address].IsRegistered == true);
        require((registrars[msg.sender].IsRegistered == true)||(Registered_Doctor[msg.sender].Patient_IsAuthorized[_address]==true)|| (msg.sender == _address));
        
        return (patients[_address].Patient_ID, patients[_address].Patient_Name, patients[_address].Patient_Age, patients[_address].Patient_Address);
    }


    //******************************************************//
    //******************************************************//
    //                                                      //
    //                      Authorizer                      //
    //                                                      //
    //******************************************************//
    //******************************************************//
    
    struct Registered_Patient {
        mapping (address => bool) Patient_IsAuthorized;
    }
    mapping (address => Registered_Patient) Registered_Doctor;
    
    modifier onlyAuthorizer(address _address){
        require(authorizers[_address].IsRegistered == true);
        _;
    }
    function Authorize_Patient_For_Doctor (address _Doctor_address,address _Patient_address) onlyAuthorizer(msg.sender) public{
        
        require((doctors[_Doctor_address].IsRegistered == true)&&(patients[_Patient_address].IsRegistered == true));
        
        Registered_Doctor[_Doctor_address].Patient_IsAuthorized[_Patient_address] = true;
    }
    
    function Cancel_Patient_For_Doctor (address _Doctor_address,address _Patient_address) onlyAuthorizer(msg.sender) public{
        
        require((doctors[_Doctor_address].IsRegistered == true)&&(patients[_Patient_address].IsRegistered == true));
        
        Registered_Doctor[_Doctor_address].Patient_IsAuthorized[_Patient_address] = false;
    }
    
    function Get_Authorize_Patient_For_Doctor (address _Doctor_address,address _Patient_address) onlyAuthorizer(msg.sender) view public returns(bool) {
        
        require((doctors[_Doctor_address].IsRegistered == true)&&(patients[_Patient_address].IsRegistered == true));
        
        return (Registered_Doctor[_Doctor_address].Patient_IsAuthorized[_Patient_address]);
    }
    
    //******************************************************//
    //******************************************************//
    //                                                      //
    //               Sensors Data Storage                   //
    //                                                      //
    //******************************************************//
    //******************************************************//
   
     modifier onlyPatient() {
        require(patients[msg.sender].IsRegistered == true);
        _;
    }
 
    struct Timestamp_Storage{
       uint index;
       mapping (uint => string)  Hash;
       mapping (uint => uint )  Begin_Timestamp;
       mapping (uint => uint )  End_Timestamp;
    }
    
    mapping (address => Timestamp_Storage) timestamps_storage;
    
    function set_Timestamp_Storage(uint _begin_timestamp, uint _end_timestamp, string _hash) onlyPatient {
        timestamps_storage[msg.sender].index = timestamps_storage[msg.sender].index + 1;
        timestamps_storage[msg.sender].Hash[timestamps_storage[msg.sender].index] = _hash;
        timestamps_storage[msg.sender].Begin_Timestamp[timestamps_storage[msg.sender].index] = _begin_timestamp;
        timestamps_storage[msg.sender].End_Timestamp[timestamps_storage[msg.sender].index] = _end_timestamp;
    }
    
    function get_index(address _address) view public returns(uint){
        require(patients[_address].IsRegistered == true);
        require((registrars[msg.sender].IsRegistered == true)||(Registered_Doctor[msg.sender].Patient_IsAuthorized[_address]==true)|| (msg.sender == _address));
        return timestamps_storage[_address].index;
    }
   
  function get_start(address _address, uint _start_timestamp) view public returns(uint){
        require(patients[_address].IsRegistered == true);
        require((Registered_Doctor[msg.sender].Patient_IsAuthorized[_address]==true)|| (msg.sender == _address));
        uint mid;
        uint l = 1;
        uint r = timestamps_storage[_address].index;
        if(timestamps_storage[_address].End_Timestamp[r]< _start_timestamp)
            mid = 0;
        else{
            while(l < r){
                mid = (l + r) / 2;
                if((timestamps_storage[_address].Begin_Timestamp[mid] <= _start_timestamp)&&(timestamps_storage[_address].End_Timestamp[mid] >= _start_timestamp))
                    break;
                else if((timestamps_storage[_address].End_Timestamp[mid] < _start_timestamp)&& (timestamps_storage[_address].Begin_Timestamp[mid+1] > _start_timestamp)){
                    mid = mid +1;
                    break;
                }
                else if(timestamps_storage[_address].End_Timestamp[mid] < _start_timestamp)
                    l = mid;
                else            
                    r = mid;
                }   
        }
    return mid;                  
   }
   
   function get_end(address _address, uint _end_timestamp) view public returns(uint){
        require(patients[_address].IsRegistered == true);
        require((Registered_Doctor[msg.sender].Patient_IsAuthorized[_address]==true)|| (msg.sender == _address));
        uint mid;
        uint l = 1;
        uint r = timestamps_storage[_address].index;
        if(timestamps_storage[_address].End_Timestamp[r]< _end_timestamp)
            mid = 0;
        else{
            while(l < r){
                mid = (l + r) / 2;
                if((timestamps_storage[_address].Begin_Timestamp[mid] <= _end_timestamp)&&(timestamps_storage[_address].End_Timestamp[mid] >= _end_timestamp))
                    break;
                else if((timestamps_storage[_address].End_Timestamp[mid] < _end_timestamp)&& (timestamps_storage[_address].Begin_Timestamp[mid+1] > _end_timestamp)){
                    break;
                }
                else if(timestamps_storage[_address].End_Timestamp[mid] < _end_timestamp)
                    l = mid;
                else            
                    r = mid;
                }
        }
    return mid;                  

   }
    
    function get_Hash(address _address, uint i) view public returns(string, uint, uint){
        require(patients[_address].IsRegistered == true);
        require((Registered_Doctor[msg.sender].Patient_IsAuthorized[_address]==true)|| (msg.sender == _address));
        return (timestamps_storage[_address].Hash[i],timestamps_storage[_address].Begin_Timestamp[i],timestamps_storage[_address].End_Timestamp[i]);
    }
    
}