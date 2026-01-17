function proxy_off
    set -e all_proxy
    set -e http_proxy
    set -e https_proxy
    echo "🚫 Proxy OFF"
end
