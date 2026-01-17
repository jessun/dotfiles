function proxy_on
    set -gx all_proxy $LOCAL_HTTP_PROXY
    set -gx http_proxy $LOCAL_HTTP_PROXY
    set -gx https_proxy $LOCAL_HTTP_PROXY
    echo "🌐 Proxy ON (HTTP: $LOCAL_HTTP_PROXY)"
end
