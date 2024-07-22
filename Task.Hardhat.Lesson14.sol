// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts-08/token/ERC20/IERC20.sol";
import "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import "openzeppelin-contracts-08/access/Ownable.sol";

///@title наследование контракта Dex от Ownable из OZ
///@notice в контракте определяем две переменные с типом адрес token1 token2
contract Dex is Ownable {
  address public token1;
  address public token2;
  constructor() {}

///@notice Функция помещает аргументы в state
  function setTokens(address _token1, address _token2) public onlyOwner {
    token1 = _token1;
    token2 = _token2;
  }
  
///@notice Добавляет ликвидности адресу токена
///@param token_address адрес для добавления токенов
///@param amount количество добавляемых токенов
///@dev добавляем onlyOwner для проверки? только собственник контракта может добавлять ликвидность
///@dev на адрес token_address переводим от msg.sender количество токенов
  function addLiquidity(address token_address, uint amount) public onlyOwner {
    IERC20(token_address).transferFrom(msg.sender, address(this), amount);
  }
  
///@notice меняем с одного адреса на другой введеное количество токенов
///@param from адрес отправителя
///@param to адрес получателя
///@param amount количество токенов для отправки
///@dev выполняем первую проверку, то что адреса токенов 1 и 2 неодинаковые. Иначе ошибка
///@dev выпоняем вторую проверку на то, что на балансе адреса отправителя денег больше чем переводимое значение. Иначе ошибка
///@dev заводим переменную swapAmount которая получает расчитанный прайс из функции ниже
///@dev IERC20(from) переводит с адреса владельца количество токенов на текущий адрес
///@dev IERC20(to) получает разрешение на перевод с текущего адреса комиссии
///@dev IERC20(to) переводит комиссию с текущего адреса на адрес владельца
  function swap(address from, address to, uint amount) public {
    require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");
    require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");
    uint swapAmount = getSwapPrice(from, to, amount);
    IERC20(from).transferFrom(msg.sender, address(this), amount);
    IERC20(to).approve(address(this), swapAmount);
    IERC20(to).transferFrom(address(this), msg.sender, swapAmount);
  }

///@notice расчитываем получаемую комиссию с обмена
///@param from адрес отправителя
///@param to адрес получателя
///@param amount количество токенов для отправки
///@return возвращаемое значение расчитываем по формуле (передваемое кол-во токенов * баланс на адресе получателя и / на баланс адреса отправителя)
  function getSwapPrice(address from, address to, uint amount) public view returns(uint){
    return((amount * IERC20(to).balanceOf(address(this)))/IERC20(from).balanceOf(address(this)));
  }

///@notice разрешение владельцу контракта переводить токен1 и токен2 получателю
///@dev SwappableToken для токена1 и токена2 разрешение на перевод
  function approve(address spender, uint amount) public {
    SwappableToken(token1).approve(msg.sender, spender, amount);
    SwappableToken(token2).approve(msg.sender, spender, amount);
  }

///@notice функция проверки текущего баланса
///@param token адрес токена
///@param account адрес аккаунта
///@return числовое возращаемое значение баланса на аккаунте
  function balanceOf(address token, address account) public view returns (uint){
    return IERC20(token).balanceOf(account);
  }
}

///@title контракт SwappableToken наследует обязательные функции ERC20
///@notice в storage создаем переменную _dex с типом адрес
///@param dexInstance адрес любого контракта
///@param name имя 
///@param symbol символ
///@param initialSupply количество токенов для передачи
///@dev _mint для добавления токенов на адрес владельца

contract SwappableToken is ERC20 {
  address private _dex;
  constructor(address dexInstance, string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        _dex = dexInstance;
  }

///@notice функция approve разрешает переводить определенное число токенов с адреса владельца на адрес получателя
///@dev осуществляем проверку что владелец контракта не равен адресу который определили в конструкторе выше
///@dev super. дает доступ к родительскому контракту в котором определена функция
  function approve(address owner, address spender, uint256 amount) public {
    require(owner != _dex, "InvalidApprover");
    super._approve(owner, spender, amount);
  }
}