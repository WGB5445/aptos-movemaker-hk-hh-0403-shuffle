module contract::shuffle {

    use std::signer;
    use std::vector;
    use aptos_framework::randomness;

    struct Players has key {
        vec: vector<u64>
    }

    #[view]
    public fun get_player_list( addr: address ):vector<u64> acquires Players {
        Players[addr].vec
    }

    #[view]
    public fun get_player_list_hk ():vector<u64> acquires Players {
        get_player_list(@0x7e402f5957980a68ce56ff6d775dd709d1dc45aa81ea0d538b9ffcdc44a91e20)
    }

    #[randomness]
    entry fun Shuffle(
        sender: &signer,
        player_account: u64
    ) acquires Players {
        if( exists<Players>(signer::address_of(sender)) ){
            Players[signer::address_of(sender)].vec = shuffle(Players[signer::address_of(sender)].vec)
        }else {
            let vec = vector[];
            for ( i in 0..player_account ) {
                vec.push_back(i + 1)
            };
            move_to(sender, Players {
                vec: shuffle(vec)
            });
        }
    }

    fun shuffle (
        vec: vector<u64>
    ): vector<u64>{
        let count = vec.length();
        let res = vector::empty();
        for ( i in 0..count){
            let index = randomness::u64_range(0, vec.length());
            let player = vec.remove(index);
            res.push_back(player)
        };
        res
    }
}
