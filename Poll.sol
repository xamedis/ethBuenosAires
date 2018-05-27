pragma solidity ^0.4.18;
/*

A proof of concept of the Poll App, can be integrated further within Aragon, 
but you get the idea.
Any resemblance to the Voting app is not a coincidence =P
*/

import "@aragon/os/contracts/apps/AragonApp.sol";

contract Poll is AragonApp { 

    bytes32 constant public CREATE_POLL_ROLE = keccak256("CREATE_POLL_ROLE");

    /*
    * @dev Topic model: a particular topic with different options to score
    */
    struct Topic{
        bytes32 name;
        address creator;
        mapping (bytes32 => uint) optionBalances;
        bytes32[] optionNames;
    }

    mapping(uint => Topic) private topics;
    bytes32[] public topicNames;
    uint128 public topicLen; // keep track number of topics
    uint public totalVotes;

    mapping(bytes32 => bool) private voters;

    event TopicAdded(
        bytes32 topic,
        address creator
    );

    /* 
    * Modifiers
    */
    modifier hasVoted(bytes32 _voterOptAddr){
        require(!voters[_voterOptAddr]);
        _;
    }
    
    /*
    * @notice Initilize as Aragon app
    */
    function initialize() onlyInit external
    {
        initialized();
    }

   /*
    * @notice Create a new Topic
    * @param _topicName
    */
    function createTopic(bytes32 _topicName) auth(CREATE_POLL_ROLE) isInitialized external {
        require(_topicName != (bytes32("")));
        
        uint256 topicId = topicLen;

        Topic storage topic = topics[topicId];
        topic.name = _topicName;
        topic.creator = msg.sender;
        topicNames[topicId] = _topicName;
        topicLen++;

          TopicAdded(_topicName, msg.sender);
    }

    /*
    * @notice Add Option to Topic
    * @param _topicId
    * @param _optionName
    */

    function addOptionToTopic(uint _topicId, bytes32 _optionName) auth(CREATE_POLL_ROLE) isInitialized external {
        require(_optionName != (bytes32("")));
        require(topics[_topicId].name != bytes32(0)); //object exists
        topics[_topicId].optionNames.push(_optionName);
        topics[_topicId].optionBalances[_optionName] = 0;
    }

    /*
    * @notice Score an Option
    * @param _topicId
    * @param _optionName
    * @param score. Less than 10
    */  
    function scoreToOption(uint _topicId, bytes32 _optionName, uint _score) hasVoted(keccak256(_optionName,msg.sender)) isInitialized external {
        require(_optionName != (bytes32("")));
        require(_score <= uint(10));
        topics[_topicId].optionBalances[_optionName]++;
        voters[keccak256(_optionName,msg.sender)] = true;
    }

    /*
    * @notice List options for a topics
    * @param _topicId
    */
    function getListOfOptions(uint _topicId) view external returns(bytes32[]) {
        uint optionLenTmp = topics[_topicId].optionNames.length;
        bytes32[] memory retu = new bytes32[](optionLenTmp);
        for(uint i = 0; i < optionLenTmp; i++){
            retu[i] = (topics[_topicId].optionNames[i]);    
        }    
        return retu;
    }

    /*
    * @notice Total votes in a topic
    * @param _topicId
    */
    function getTotalTopicVotes(uint _topicId) view external returns(uint totalVotes) {

        uint optionLenTmp = topics[_topicId].optionNames.length;
        
        for(uint i = 0; i < optionLenTmp; i++){
            bytes32 idx = topics[_topicId].optionNames[i];
            totalVotes += topics[_topicId].optionBalances[idx];    
        }    
        return totalVotes;
    }

    /*
    * @notice Total votes in the Poll
    * @param _topicId
    */
    function resultPoll() view external returns(uint result) {
 
       for(uint i = 0; i < topicLen; i++){
            result += this.getTotalTopicVotes(i);    
        }    
        return result;
    }

}