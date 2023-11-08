
# this will parse the environment successfully, and throws an SSLHandshakeException as expected
docker run --rm -i -t \
    -v ./jetbrains-http-client-tests:/workdir \
    jetbrains/intellij-http-client:232.10203.10 \
    --env-file http-client.env.json \
    --private-env-file http-client.private.env.json \
    --env default \
    -L VERBOSE \
    run.http
