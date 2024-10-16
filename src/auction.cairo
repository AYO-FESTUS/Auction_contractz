#[starknet::interface]
trait IAuction<T>{
    fn register_item(ref self:T,item_name: ByteArray);

    fn unregister_item(ref self:T,item_name: ByteArray);

    fn bid(ref self:T,item_name:ByteArray,amount:u32);

    fn get_highest_bidder(self:@T, item_name:ByteArray)->u32;
    
    fn is_registered(self:@T, item_name:ByteArray)->bool;

}

#[starknet::contract]
mod Auction{

    #[storage]
    struct Storage{
         bid : Map<ByteArray,u32>,
         register:  Map<ByteArray,bool>
    }
    //TODO Implement interface and events .. deploy contract
    namespace I_auction:
    func plac_bid(bid_amount: Uint256, name: felt252) ->();
    func end_auction() -> (winner: felt252);
    
    
    //Import the interface
from auction_interfaces import I_Auction
    @contract
    namespace Auction:
    @storage_var
    func current_highest_bid() -> (Uint256);



    @storage_var
    func get_highest_bidder() -> (felt);

    //  Implementing the interface functions

    @external
    func plac_bid(bid_amount: Uint256, name: felt) -> {
        let(current_bid)= current_highest_bid();
        assert(bid_amount > current_bid, 'bid is high enough');
        current_highest_bid.write(bid_amount);
        highest_bid.write(bid_amount);
        BidPlaced.emit(name, bid_amount);
        return();
    }
    @external
    func end_auction() -> (winner: felt) {
        let (winner_name) = get_highest_bidder();
        AuctionEnded.emit(winner_name);
        return (winner_name);
    }

    // DEine event for a bid is place
    @event
    func BidPlaced(bidder: felt, bid_amount: Uint256) {}

    // define event for when the auction ens
    @event
    func AuctionEnded(winner: felt) {}
}
