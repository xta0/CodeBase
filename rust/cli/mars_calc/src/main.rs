fn main() {
    println!("Mars Weight: {}kg", calculate_weight_on_mars(50.0));
}

fn calculate_weight_on_mars(weight: f32) -> f32 {
    return (weight / 9.81) * 3.71
}