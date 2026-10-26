if status is-interactive
    # Commands to run in interactive sessions can go here
end

function proxy_on
    set -gx http_proxy http://10.67.176.113:10809
    set -gx https_proxy http://10.67.176.113:10809
    set -gx HTTP_PROXY http://10.67.176.113:10809
    set -gx HTTPS_PROXY http://10.67.176.113:10809
    echo "Прокси включен"
end

function proxy_off
    set -e http_proxy
    set -e https_proxy
    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    echo "Прокси выключен"
end
