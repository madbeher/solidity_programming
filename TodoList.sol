pragma solidity >=0.4.2 <0.6.0;

contract TodoList {
    struct Todo {
        uint256 id;
        bytes32 content;
        address owner;
        bool isCompleted;
        uint256 timestamp;
    }
    uint256 public constant maxAmountOfTodos = 100;
    mapping(address => Todo[maxAmountOfTodos]) public todos;
    mapping(address => uint256) public lastIds;
    modifier onlyOwner(address _owner){
        require(msg.sender == _owner);_;
    }
    function addTodo(bytes32  _content) public{
        Todo memory myNote = Todo(lastIds[msg.sender], _content, msg.sender, false, now);
        todos[msg.sender][lastIds[msg.sender]] = myNote;
        if(lastIds[msg.sender] >= maxAmountOfTodos)
        lastIds[msg.sender] = 0;
        else lastIds[msg.sender]++;
    }
    function markTodoAsCompleted(uint256 _todoId) public onlyOwner(todos[msg.sender][_todoId].owner){
        require(_todoId < maxAmountOfTodos);
        require(!todos[msg.sender][_todoId].isCompleted);
        todos[msg.sender][_todoId].isCompleted= true;
    }
}