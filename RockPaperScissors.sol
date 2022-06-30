//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Janken{
    address payable public playerOne;
    address payable public playerTwo;
    string[] choices;

    uint amntOfBet;

    event Occupy(address _occupant, uint _value);


    enum Status{Player1,Tie, Player2}
    Status public currentStatus;

    string gameResult;

    function Player1(string memory _choice1) public payable{
        playerOne = payable(msg.sender);
        choices.push(_choice1);
        amntOfBet += msg.value;
    }
    function Player2(string memory _choice2) public payable{
        playerTwo = payable(msg.sender);
        choices.push(_choice2);
        amntOfBet += msg.value;
    }
    
    function Check() public {
        uint p1 = bytes(choices[0]).length;
        uint p2 = bytes(choices[1]).length;

        if ((p1 == 4 && p2 ==8) || (p1==5 && p2==4) || (p1==8 && p2==4)) {
            currentStatus = Status.Player1;
            gameResult = string(abi.encodePacked("Player1 wins with ",choices[0]));
            
        }
        else if (p1 == p2){
            currentStatus = Status.Tie;
            gameResult = "Its a tie";
        }
        else{
            currentStatus = Status.Player2;
            gameResult = string(abi.encodePacked("Player2 wins with ",choices[1]));
        }

    }

    function GameResult() public view returns(string memory){
        return gameResult;
    }

    function transfer()public {
        if (currentStatus == Status.Player1){
        (bool sent, bytes memory data) = playerOne.call{value: amntOfBet}("");
        require(true);
        emit Occupy(msg.sender, amntOfBet);
        }

        else if (currentStatus == Status.Player2){
        (bool sent, bytes memory data) = playerTwo.call{value: amntOfBet}("");
        require(true);
        emit Occupy(msg.sender, amntOfBet);
        }
    }
}