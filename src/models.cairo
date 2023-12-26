use starknet::ContractAddress;


#[derive(Serde, Drop, Copy, PartialEq, Introspect)]
enum TurnState {
    None,
    Waiting,
    Draw,
    Idle,
    Finished,
}

#[derive(Model, Drop, Serde)]
struct GameMetadata{
    #[key]
    gameID: u64,
    currentNumbers:u8,
    maxPlayers:u8,
    currentState:TurnState,
    winner:ContractAddress,
    latestDrawed:u8
}

#[derive(Model, Drop, Serde)]
struct AddressToUsername {
    #[key]
    address: ContractAddress,
    username: felt252,
}

#[derive(Model, Drop, Serde)]   
struct IsPlayerValid {
    #[key]
    gameID: u64,
    #[key]
    player: ContractAddress,
    playerID: u8,
}

#[derive(Model, Drop, Serde)]
struct GameID {
    #[key]
    singleton: u8,
    gameID: u64,
}


#[derive(Model,Drop,Serde)]
struct CardData {

    #[key]
    gameID: u64,
    #[key]
    player: ContractAddress,
    index: u8,
    number : u8,
}

#[derive(Model,Drop,Serde)]
struct CardHashes {
    #[key]
    gameID: u64,
    #[key]
    player: ContractAddress,
    hash : felt252,
}

