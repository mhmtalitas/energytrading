// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract EnergyTrading {
    struct EnergyRecord {
        address producer;
        uint256 amount;
        string certificateHash;
        bool isSold;
    }

    EnergyRecord[] public records;

    event RecordAdded(uint256 recordId, address producer, uint256 amount, string certificateHash);
    event RecordSold(uint256 recordId, address buyer);

    function addRecord(uint256 amount, string memory certificateHash) public {
        records.push(EnergyRecord(msg.sender, amount, certificateHash, false));
        emit RecordAdded(records.length - 1, msg.sender, amount, certificateHash);
    }

    function buyEnergy(uint256 recordId) public payable {
        require(recordId < records.length, "Record does not exist");
        require(!records[recordId].isSold, "Energy already sold");
        require(msg.value >= records[recordId].amount, "Insufficient payment");

        records[recordId].isSold = true;
        payable(records[recordId].producer).transfer(msg.value);

        emit RecordSold(recordId, msg.sender);
    }

    function getRecord(uint256 recordId) public view returns (address, uint256, string memory, bool) {
        require(recordId < records.length, "Record does not exist");
        EnergyRecord memory rec = records[recordId];
        return (rec.producer, rec.amount, rec.certificateHash, rec.isSold);
    }
}
