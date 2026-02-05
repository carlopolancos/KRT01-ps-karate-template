package globomantics.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

class PerfTest extends Simulation {

    //1 - Define protocol
    val protocol = karateProtocol(
        "/api/product/{productId}" -> Nil
    )

    protocol.nameResolver = (req, ctx) => req.getHeader("karate-request")

    val csvFeeder = csv("src/test/java/globomantics/performance/data/products.csv").circular

    //2 - Load scenarios
    val listProducts = scenario("List all products")
        .exec(karateFeature("classpath:globomantics/performance/ListProducts.feature"))

    val createProduct = scenario("Create and Delete a Product")
        .feed(csvFeeder)
        .exec(karateFeature("classpath:globomantics/performance/CreateProduct.feature"))

    //3 - Load simulation
    setUp(
        listProducts.inject(atOnceUsers(1),
            nothingFor(5),
            rampUsers(10).during(10),
            constantUsersPerSec(5).during(10),
            rampUsersPerSec(1).to(5).during(10)
        ).protocols(protocol),
//        createProduct.inject(atOnceUsers(1)).protocols(protocol)
        createProduct.inject(rampUsers(20).during(20)).protocols(protocol)
    )
}