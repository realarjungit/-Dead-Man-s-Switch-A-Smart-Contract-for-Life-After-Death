// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract DeadmanSwitch {
    
struct Owner{

address fundOwner;
address nominee;
uint ethAmount;
uint period;
uint lastCheckIn;
bool claimed;

}

mapping (address => Owner) public OwnerData;

//-------------------Modifiers-----------------------------------------------------------------

modifier onlyFundOwner() {
require(OwnerData[msg.sender].ethAmount > 0, "Address never Registered");
_;
}

modifier onlyNominee(address _ownerAddress){
require(msg.sender == OwnerData[_ownerAddress].nominee, "You are not nominee");
_;
}


//Function to deposit ETH and register Nominee
function depositAndNominee(address _nominee, uint _period) public payable {

require(msg.value > 0, "Invalid Amount");
require(OwnerData[msg.sender].ethAmount == 0, "User already Registered");
require(msg.sender != _nominee, "Owner and Nominee can't be same!");

OwnerData[msg.sender] = Owner({

fundOwner: msg.sender,
nominee: _nominee,
ethAmount: msg.value,
period: _period,
lastCheckIn: block.timestamp,
claimed: false
});

}

//Function to reset/update the last checkIn
function checkIn() public onlyFundOwner() {

require( block.timestamp < OwnerData[msg.sender].lastCheckIn + OwnerData[msg.sender].period, "You can no longer update the checkIn. Nominee can claim the funds now.");

OwnerData[msg.sender].lastCheckIn = block.timestamp;

}

//Function to claim the funds by Nominee.
function claimFunds(address _ownerAddress) public onlyNominee( _ownerAddress) {

require(block.timestamp > OwnerData[_ownerAddress].lastCheckIn + OwnerData[_ownerAddress].period, "Owner still alive, you can't claim the funds yet.");
require(!OwnerData[_ownerAddress].claimed,"Already Claimed");

OwnerData[_ownerAddress].claimed = true;
payable(msg.sender).transfer(OwnerData[_ownerAddress].ethAmount);

}

//Function to top-up deposit.
function topUp() public payable  onlyFundOwner {

require( msg.value > 0, " Enter the correct amount"); 
OwnerData[msg.sender].ethAmount += msg.value;

}

//Function to update/change the nominee
function updateNominee(address _newNominee) public onlyFundOwner(){
OwnerData[msg.sender].nominee = _newNominee;
}

//Function to check the remaining time by Owner.

function timeLeft() public onlyFundOwner view returns(string memory, uint) {

uint expiry = OwnerData[msg.sender].lastCheckIn + OwnerData[msg.sender].period;
    
if (block.timestamp > expiry) {
    return ("Time over, nominee can claim the funds now", 0);
}

else{

    return ("The time left is:", expiry - block.timestamp);
}
}

//contract ends here.
}
