FROM maven as build 
WORKDIR /app
COPY . .
RUN mvn clean install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/devops-integration.jar /app/
EXPOSE 8081
CMD ["java","-jar","devops-integration.jar"]
