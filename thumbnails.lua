local thumbnails = {}

local neturl = require "neturl"

function thumbnails.getImageUrl(url)
    local u = neturl.parse(url)

    local pathLower = u.path:lower()

    -- get common extensions (.jpg, .png, .gif)
    local last4 = pathLower:sub(-4)
    -- 4-char extensions (.jpeg, .gifv)
    local last5 = pathLower:sub(-5)

    if u.host:sub(1, 12) == "imgur.com/a/" then
        return url
    elseif u.host:sub(1, 18) == "imgur.com/gallery/" then
        return nil
    elseif u.host == "i.imgur.com" or u.host == "imgur.com" then
        if last4 == ".jpg" or last4 == ".gif" or last4 == ".png" then
            return url:sub(1, -5) .. "l.jpg"
        elseif last5 == ".jpeg" or last5 == ".gifv" then
            return url:sub(1, -6) .. "l.jpg"
        else
            return url .. "l.jpg"
        end
    elseif last4 == ".jpg" or last4 == ".gif" or last4 == ".png" or last5 == ".jpeg" then
        return url
    else
        return nil
    end
end

local methodExists, showThumbnails = pcall(redditisfun.isShowThumbnails, redditisfun)
thumbnails.enabled = (methodExists and showThumbnails)

return thumbnails