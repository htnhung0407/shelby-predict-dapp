module 0x73ba9269a0eb0d70e13ad6218a9909d6322f80a085d86cb73a19d9bb28f2ed6e::shelby_predict {
    use std::signer;
    use std::string::String;

    // Cấu trúc để lưu kèo dự đoán
    struct PredictionMarket has key {
        // Mã này trỏ đến hình ảnh/mô tả kèo lưu trên Shelby
        shelby_blob_id: String, 
        yes_votes: u64,
        no_votes: u64,
        is_active: bool,
    }

    // Hàm tạo kèo mới
    public entry fun create_market(admin: &signer, blob_id: String) {
        let market = PredictionMarket {
            shelby_blob_id: blob_id,
            yes_votes: 0,
            no_votes: 0,
            is_active: true,
        };
        move_to(admin, market);
    }

    // Hàm đặt cược YES
    public entry fun vote_yes(user: &signer, market_addr: address) acquires PredictionMarket {
        let market = borrow_global_mut<PredictionMarket>(market_addr);
        assert!(market.is_active, 1);
        market.yes_votes = market.yes_votes + 1;
    }
}