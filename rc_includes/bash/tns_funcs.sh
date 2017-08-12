function tns_test() {
  docker run -it --rm --privileged -v /Users/baz/dev/alertsnap/app:/app kristophjunge/nativescript \
    bash -c "tns create my-app && mv ./my-app/* ./ && rm -r ./my-app && tns platform add android && tns run android"
}

