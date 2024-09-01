#[starknet::interface]
trait ICounterContract<TContractState>{
    fn get_count(self: @TContractState) -> u32;
    fn increment_count(ref self: TContractState);
}


#[starknet::contract]
mod CounterContract {
    // use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        count: u32,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        count_:u32) {
        self.count.write(count_);
    }

    #[abi(embed_v0)]
    impl CounterContract of super::ICounterContract<ContractState>{
        fn get_count(self: @ContractState) -> u32{
            self.count.read()
        }
        fn increment_count(ref self: ContractState){
            let current_count = self.count.read();
            self.count.write(current_count + 1);
            
        }
    }
}

