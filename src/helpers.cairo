fn generate_random_numbers() -> Vec<u32> {
    let mut rng = rand::thread_rng();
    let mut numbers = Vec::new();
    for _ in 0..100 {
        numbers.push(rng.gen_range(0, 100));
    }
    numbers
}