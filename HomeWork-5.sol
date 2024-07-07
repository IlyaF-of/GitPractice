// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Demo {
    uint public len;
    uint public var1 = 100;
    address public owner = msg.sender;
    bool public var2 = true;
    string public var3 = "Ilya";

    uint constant public DAYS = 365;
    uint constant public HOURS = 24;

    mapping (address => uint) public _addresses;

    uint[10] public array1;
    uint[] public array2 = [10, 20, 30];

    enum Status {Buy, Paid, Delivered}
    Status public statuses;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an OWNER!!!");
        _;
    }
    modifier ownerAddress() {
        require(msg.sender != address(0), "Zero ADDRESS!!!!");
        _;
    }

    event eventName(address _to, uint _amount, uint _timestamp);
    event eventName2(string var3, bool var2);

    error falseOwner(string);

    constructor () {
        require(msg.sender != address(0), "ZERO ADDRESS");
        owner = msg.sender;
    }
// -------------------------------------------------------------------------
    // 1. Без аргументов, которая прибавляет +1 к любой перменной uint.   
   function increment() external {
        var1++;
   }
    // 2. Без аргументов, которая вычитает из uint константу;    
    function decrement() external {
        var1 -= HOURS;
   } 
    // 3. С аргументами, которые складываются с константой и другой uint;
    function add(uint _var5, uint _var6) public view returns(uint) {
        return _var5 + _var6 + var1 + HOURS;
   }
    // 4. Которая устанавливает значение в мэппинг;
    function getAddress(address _addr, uint _amount) external {
        _addresses[_addr] = _amount;
    }
    // 5. Которая добавляет 3 значения в массив с фиксированной длиной;
     function pushArr() external {
        array1[0] = 27;
        array1[2] = 23;
        array1[5] = 48;
    }
    // 6. Которая удаляет значение из массива, без изменения его длины;
    function deleteArr() public returns(uint[] memory) { 
        delete array2[1];
        return array2;
    }
    // 7. Которая удаляет значение из массива, с изменение его длины;
    function changeLen() public returns(uint[] memory) {
        array2.pop();
        return array2;
    } 
       
    // 8. Которая измеряет длину массива; 
    function arrLen() public view returns(uint) {
        uint a = array2.length;
        return a;
    }

    // 9. Которая изменяет адрес владельца контракта с проверкой на нулевой адрес и текущего владельца;
    function changeOwnr(address _new) external onlyOwner ownerAddress() {
            owner = _new;
        } 

    // 10. Которая проходит в цикле и добавляет в массив 0-10 значения uint; 
       function getArray(uint[] memory _value) public {
            require (_value.length == 11, "Give me 11 values");

        for (uint i; i < _value.length; i++) {
            array2.push(_value[i]);
        }
    }

    // 11. Которая обнуляет значение в мэппинге и устанавливает 2 опцию из enum;
    function zeroMap(address _addre) external {
        delete _addresses[_addre];
        statuses = Status.Paid;
    }

    // 12. Которая будет добавлять значение в массив с фиксированной длиной и порождать событие;
    function getEvent() public {
        array2.push(13);
        array2.push(18);
        
        emit eventName2("Hello", true);
    }

    // 13. Которая будет делать сложение чисел с проверкой, что число не может быть меньше 10;
     function sum(uint a, uint b) public pure returns(uint) {
        require(a > 10 && b > 10, "ERROR.larger than 10");
        return a + b;
    }
    
     // 14. Которая будет с помощью тернарного оператора выводить число uint;
        function ternarFunc(uint _b) external view returns(uint) {
        uint a = (_b == 0) ? var1 : HOURS;
        return a;
    }

    // // 15. Которая будет делать revert при попытке изменить значение в мэппинге;
         function fooReturn(address _address, uint _value) external view returns (string memory) {
                if (_addresses[_address] != _value)
                revert falseOwner("Bad job!");
                return "You win!";
  }

    // 16. Которая будет выводить значение из массива по индексу;
        function getIndex(uint index) public view returns(uint) {
        require(index <= array2.length, "Error, parameter should be lesses than Array lenght");
            return array2[index];
    }
}


 



