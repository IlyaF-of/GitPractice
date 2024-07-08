// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Demo {
    //creat variable (uint, address, bool)
    uint public first;
    address public myAddress = msg.sender;
    bool public success;

    //creat const & immutable
    uint public constant FIRSTCONST = 12345;
    uint public immutable FIRSTUINT = 54321;

    // create mapping
    mapping (address => uint) public balances;

    //Create an array with dynamic length
    uint[] public myDynArr = [1,2,3,4,5];

    //modifier onlyOwner
    modifier onlyOwner() {
        require(msg.sender == myAddress, "Not an owner");
        _;
    }

    //modifier ZeroAddress
    modifier zeroAddress() {
        require(msg.sender != address(0), "Zero address");
        _;
    }

    //nested mapping
    mapping (address => mapping (uint => bool)) public addresses;

    //mapping with structure
    struct Pay {
        address from;
        uint amount;
    }
    mapping (uint => Pay) public Payable;

    //Struct in Struct
    struct Cash {
        Pay pay;
        bool success;
    }

    //array of structures
    Pay[] public pays;

    //____FUNCTIONS_____
    //1. Изменение адреса владельца контракта с проверкой на нулевой адрес;
    function changeAddr(address _newAddr) external zeroAddress {
       myAddress = _newAddr;
    }

    //2. Которая будет устанавливать immutable в конструкторе;
    constructor(uint _FIRSTUINT) {
        FIRSTUINT = _FIRSTUINT;
    }

    //3. Которая будет добавлять значение в динамический массив;
    function set(uint _i) external {
        myDynArr.push(_i);
    }

    //4. Которая будет удалять значение из массива с уменьшением его длины;
    function delArr() external {
        myDynArr.pop();
    }
    
    //5. Которая будет добавлять значение во вложенном мэппинге;
    function setAmountMapp(address _from, uint _i, bool _succsess) external {
        addresses[_from][_i] = _succsess; 
        }

    //6. Которая будет удалять значение во вложенном мэппинге;
    function deleteMapp(address _addr, uint _i) external {
        delete addresses[_addr][_i];
    }

    //7. Которая будет добавлять значения struct в мэппинге;
    function addStruct(uint _number, address _from, uint _amount) external {
        Payable[_number] = Pay(_from, _amount);
    }
    
    //8. Которая будет добавлять значение в массив структур;
    function addArrStruct(address _from, uint _amount) external {
        pays.push(Pay(_from, _amount));
    }

    //9. Которая будет добавлять в простой маппинг запись, что пользователю пришел эфир;
    function getEth() external payable  {
        balances[msg.sender] += msg.value;
    }
}
 




