
# this will fail to parse the environment
# error stacktrace:
#java.lang.UnsupportedOperationException: JsonObject
#        at com.google.gson.JsonElement.getAsString(JsonElement.java:187)
#        at com.intellij.httpClient.cli.HttpClientMain.loadEnvironment(HttpClientMain.kt:300)
#        at com.intellij.httpClient.cli.HttpClientOptions.call(HttpClientMain.kt:186)
#        at com.intellij.httpClient.cli.HttpClientOptions.call(HttpClientMain.kt:44)
#        at picocli.CommandLine.executeUserObject(CommandLine.java:1953)
#        at picocli.CommandLine.access$1300(CommandLine.java:145)
#        at picocli.CommandLine$RunLast.executeUserObjectOfLastSubcommandWithSameParent(CommandLine.java:2358)
#        at picocli.CommandLine$RunLast.handle(CommandLine.java:2352)
#        at picocli.CommandLine$RunLast.handle(CommandLine.java:2314)
#        at picocli.CommandLine$AbstractParseResultHandler.execute(CommandLine.java:2179)
#        at picocli.CommandLine$RunLast.execute(CommandLine.java:2316)
#        at picocli.CommandLine.execute(CommandLine.java:2078)
#        at com.intellij.httpClient.cli.HttpClientMain.main(HttpClientMain.kt:39)

docker run --rm -i -t \
    -v ./jetbrains-http-client-tests:/workdir \
    jetbrains/intellij-http-client:232.10203.10 \
    --env-file http-client.env.json \
    --private-env-file http-client.private.env.json \
    --env with-enable \
    -L VERBOSE \
    run.http
