function proxy_socks5
    set -gx all_proxy $LOCAL_SOCKS5_PROXY
    set -gx http_proxy $LOCAL_SOCKS5_PROXY
    set -gx https_proxy $LOCAL_SOCKS5_PROXY
    echo "🌐 Proxy ON (SOCKS5: $LOCAL_SOCKS5_PROXY)"
end
