# Pluralsight - Karate Fundamentals - Template Project

This repository is a simple Karate template to support the Pluralsight course [Karate Fundamentals](https://pluralsight.com)

It contains the skeleton files required to start building a Karate automation testing framework.

Run using:
TERMINAL 1
cd D:\'Karate Test Framework'\KRT02-globomantics-toys
.\mvnw spring-boot:run

TERMINAL 2
mvn clean test //ignores @ignore tag
mvn test "-Dkarate.options=--tags @debug"
mvn test "-Dkarate.options=--tags @stable"
mvn test "-Dkarate.options=--tags ~@skip"
mvn test "-Dkarate.env=dev" //or prod (fails)