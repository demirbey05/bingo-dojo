use starknet::ContractAddress;
use starknet::get_caller_address;


#[starknet::interface]
    trait IActions<ContractState> {
        fn initGame(
            self: @ContractState,
            maxPlayers:u8
        ) -> u64;
        fn initUsername(
            self: @ContractState,
            username: felt252,
        );
        fn joinGame(
            self: @ContractState,
            game_id: u64,
        );
    }


#[dojo::contract]
mod actions {
    use bingo::models::{TurnState,GameMetadata,AddressToUsername,IsPlayerValid,GameID,CardData,CardHashes};
    use super::{ContractAddress, IActions,get_caller_address};

    #[external(v0)]
    impl IActionsImpl of IActions<ContractState> {
        fn initGame(self:@ContractState,maxPlayers:u8) -> u64 {
            let world = self.world_dispatcher.read();
            let mut gameid = get!(world,(0),(GameID));

            set!(world,GameMetadata{gameID:gameid.gameID +1 ,currentNumbers:0,maxPlayers,currentState:TurnState::Waiting,winner:Zeroable::zero(),latestDrawed:0});
            set!(world,GameID{singleton:0,gameID:gameid.gameID +1});

            return gameid.gameID +1;
        }
        fn initUsername(
            self: @ContractState,
            username: felt252,
        ){
            let world = self.world_dispatcher.read();
            let caller: ContractAddress = get_caller_address();
            set!(world,AddressToUsername{address:caller,username});


        }
        fn joinGame(
            self: @ContractState,
            game_id: u64,
        ){
            let world = self.world_dispatcher.read();
            let caller: ContractAddress = get_caller_address();
            let mut game = get!(world,(game_id),(GameMetadata));
            set!(world,IsPlayerValid{gameID:game_id,player:caller,playerID:game.currentNumbers + 1});

        }

    }
}