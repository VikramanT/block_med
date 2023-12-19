pragma solidity ^0.5.0;

contract TodoList {
  uint public taskCount = 0;
  address public owner; // Add owner variable to store the contract owner's address

  struct HealthRecord {
    uint id;
    string patientName;
    string diagnosis;
    uint timestamp;
    address doctor;
  }

  mapping(uint => HealthRecord) public healthRecords;

  event HealthRecordCreated(
    uint id,
    string patientName,
    string diagnosis,
    uint timestamp,
    address doctor
  );

  event HealthRecordDeleted(
    uint id,
    string patientName,
    string diagnosis,
    uint timestamp,
    address doctor
  );

  modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can perform this action");
    _;
  }

  constructor() public {
    owner = msg.sender; // Set the contract deployer as the owner
    createHealthRecord("John Doe", "Initial Checkup", now, msg.sender);
  }

  function createHealthRecord(string memory _patientName, string memory _diagnosis, uint _timestamp, address _doctor) public {
    require(bytes(_patientName).length > 0, "Patient name cannot be empty");
    require(bytes(_diagnosis).length > 0, "Diagnosis cannot be empty");

    taskCount++;
    healthRecords[taskCount] = HealthRecord(taskCount, _patientName, _diagnosis, _timestamp, _doctor);
    emit HealthRecordCreated(taskCount, _patientName, _diagnosis, _timestamp, _doctor);
  }

  function deleteHealthRecord(uint _id) public onlyOwner {
    HealthRecord memory recordToDelete = healthRecords[_id];
    require(recordToDelete.id != 0, "Health record does not exist");

    delete healthRecords[_id];
    emit HealthRecordDeleted(recordToDelete.id, recordToDelete.patientName, recordToDelete.diagnosis, recordToDelete.timestamp, recordToDelete.doctor);
  }

  function toggleCompleted(uint _id) public {
    // Implementation for toggling completed status can be added if needed.
  }

  // Additional functions for updating or querying health records can be added as needed.
}
