package helpers;

import com.github.javafaker.Faker;

public class TestDataGenerator {

    public static String getRandomProductName() {
        Faker faker = new Faker();
        return faker.commerce().productName() + faker.random().nextInt(100);
    }
}