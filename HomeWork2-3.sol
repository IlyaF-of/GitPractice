
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Demo {

    //1. Создать вложенный мэппинг (nested mapping);
    mapping (address => mapping (address => uint)) public adresses;

    //2. Создать мэппинг со структурой;
    struct Payment {
        uint amount;
        address _to;
        uint timestamp;
    }
    mapping (address => Payment) public payments;

//     //3. Создать структуру, в которой будет другая структура;
    struct Cash {
       uint amount;
       address _to;
       uint timestamp;
    }
    struct Ownr {
        string text;
        Cash cash;
    }
    mapping (address => Ownr) public cashing;

    //4. Создать структуру с мэппингом внутри;
    struct Ownered {
        string text;
        uint amount;
        mapping (address => uint) adresses;
    }
    
    //5. Создать массив структур;
    struct Pay {
        uint amount1;
        address _to1;
        uint timestamp1;
        }
        Pay[] public demoArray;   

    //6. Создать мэппинг с массивом структур//
    struct MyStruct {
        uint256 id;
        string name;
    }

    struct MyStructs {
        MyStruct[] myStructs;
    }
    mapping (address => MyStruct) public newArrayStructs;

   // Ф У Н К Ц И И
   //1. Которая будет добавлять значение в мэппинге с массивом;
    mapping (address => uint[]) public amountes;

    function getAmount(address _addr, uint _amount) public {
        amountes[_addr].push(_amount);
    }
    // function get(address _amount) public view returns (uint[] memory) {
    //     return amountes[_amount];
    // }
       mapping(address => uint) public confirmationsTxAmount; 
       function confirm(address id) external {        
       
        confirmationsTxAmount[id]++;   
       }
}  
  

