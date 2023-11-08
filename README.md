# issue_intellij-http-client_error-on-disable-host-verification
A test repository for reproducing a runtime error in intellij's HTTP client when disabling the host verification.

**Issue**
_When adding the "SSLConfiguration" key (e.g. for adding "verifyHostCertificate") to the private env-file (as documented [here](https://www.jetbrains.com/help/idea/2023.2/http-client-in-product-code-editor.html#disable_certificate_verification)), the environment fails to load with an exception._
_This issue does not occur when executing directly in the IDE but when executing with a docker container._

Image: jetbrains/intellij-http-client:232.10203.10

Test Cases:
  - use ["default"](./run-docker_default.sh) (no sslconfig) → successful parse
  - use ["with-sslconfig"](./run-docker_with-sslconfig.sh) (empty sslconfig) → failing parse
  - use ["with-disable"](./run-docker_with-disable.sh) (sslconfig > verification disabled) → failing parse
  - use ["with-enable"](./run-docker_with-enable.sh) (sslconfig > verification enabled) → failing parse

```json
{
  "SSLConfiguration": {
    "verifyHostCertificate": false
  }
}
```

Exception:
```text
java.lang.UnsupportedOperationException: JsonObject
        at com.google.gson.JsonElement.getAsString(JsonElement.java:187)
        at com.intellij.httpClient.cli.HttpClientMain.loadEnvironment(HttpClientMain.kt:300)
        at com.intellij.httpClient.cli.HttpClientOptions.call(HttpClientMain.kt:186)
        at com.intellij.httpClient.cli.HttpClientOptions.call(HttpClientMain.kt:44)
        at picocli.CommandLine.executeUserObject(CommandLine.java:1953)
        at picocli.CommandLine.access$1300(CommandLine.java:145)
        at picocli.CommandLine$RunLast.executeUserObjectOfLastSubcommandWithSameParent(CommandLine.java:2358)
        at picocli.CommandLine$RunLast.handle(CommandLine.java:2352)
        at picocli.CommandLine$RunLast.handle(CommandLine.java:2314)
        at picocli.CommandLine$AbstractParseResultHandler.execute(CommandLine.java:2179)
        at picocli.CommandLine$RunLast.execute(CommandLine.java:2316)
        at picocli.CommandLine.execute(CommandLine.java:2078)
        at com.intellij.httpClient.cli.HttpClientMain.main(HttpClientMain.kt:39)
```

It does not seem to matter whether the key holds an empty object or additional properties.

Only removing the property from the configuration results in a successful environment load.
