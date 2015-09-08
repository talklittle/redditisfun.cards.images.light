-- local aliases for globals
local TEXT_SIZE_LARGE = redditisfun.TEXT_SIZE_LARGE
local TEXT_SIZE_MEDIUM = redditisfun.TEXT_SIZE_MEDIUM
local TEXT_SIZE_SMALL = redditisfun.TEXT_SIZE_SMALL
local TEXT_COLOR_PRIMARY = redditisfun.TEXT_COLOR_PRIMARY
local TEXT_COLOR_SECONDARY = redditisfun.TEXT_COLOR_SECONDARY
local SELECTABLE_ITEM_BACKGROUND = redditisfun.SELECTABLE_ITEM_BACKGROUND
local Fonts = redditisfun.Fonts
local Spans = redditisfun.Spans
local Toasts = redditisfun.Toasts

---
-- @usage exported
function newView(Builder)
    local view1 = Builder:beginLinearLayout("root_container")
    view1:setLayoutSize("fill_parent", "wrap_content")
    view1:setOrientation("vertical")
        local karma_layout = Builder:beginLinearLayout("karma_layout")
        karma_layout:setLayoutSize("fill_parent", "wrap_content")
        karma_layout:setOrientation("horizontal")
        karma_layout:setPadding("10dp")
            local link_karma_layout = Builder:beginLinearLayout("link_karma_layout")
            link_karma_layout:setLayoutSize("wrap_content", "wrap_content")
            link_karma_layout:setLayoutWeight(1.0)
            link_karma_layout:setOrientation("vertical")
            link_karma_layout:setGravity("center")
                local link_karma = Builder:addTextView("link_karma")
                link_karma:setLayoutSize("wrap_content", "wrap_content")
                link_karma:setGravity("center")
                link_karma:setText("?")
                link_karma:setTextSize(TEXT_SIZE_LARGE)
                local link_karma_label = Builder:addTextView("link_karma_label")
                link_karma_label:setLayoutSize("wrap_content", "wrap_content")
                link_karma_label:setGravity("center")
                link_karma_label:setText("link karma")
            Builder:endLinearLayout()

            local comment_karma_layout = Builder:beginLinearLayout("comment_karma_layout")
            comment_karma_layout:setLayoutSize("wrap_content", "wrap_content")
            comment_karma_layout:setLayoutWeight(1.0)
            comment_karma_layout:setOrientation("vertical")
            comment_karma_layout:setGravity("center")
                local comment_karma = Builder:addTextView("comment_karma")
                comment_karma:setLayoutSize("wrap_content", "wrap_content")
                comment_karma:setGravity("center")
                comment_karma:setText("?")
                comment_karma:setTextSize(TEXT_SIZE_LARGE)
                local comment_karma_label = Builder:addTextView("comment_karma_label")
                comment_karma_label:setLayoutSize("wrap_content", "wrap_content")
                comment_karma_label:setGravity("center")
                comment_karma_label:setText("comment karma")
            Builder:endLinearLayout()
        Builder:endLinearLayout()

        local trophy_case_area = Builder:beginLinearLayout("trophy_case_area")
        trophy_case_area:setLayoutSize("match_parent", "wrap_content")
        trophy_case_area:setOrientation("vertical")
        trophy_case_area:setBackground("#ffdfdfdf")

            local trophies_title = Builder:addTextView("trophies_title")
            trophies_title:setLayoutSize("wrap_content", "wrap_content")
            trophies_title:setPadding("15dp", "10dp", "15dp", "10dp")

            local trophies_scroll = Builder:beginHorizontalScrollView("trophies_scroll")
            trophies_scroll:setLayoutSize("match_parent", "wrap_content")
                local trophy_layout = Builder:beginLinearLayout("trophy_layout")
                trophy_layout:setLayoutSize("wrap_content", "wrap_content")
                trophy_layout:setOrientation("horizontal")
                trophy_layout:setPadding("10dp")
                Builder:endLinearLayout()
            Builder:endHorizontalScrollView()

        Builder:endLinearLayout()
    Builder:endLinearLayout()

    Fonts:registerNormal("Roboto", "fonts/Roboto-Regular.ttf")
    Fonts:registerBold("Roboto", "fonts/Roboto-Bold.ttf")
    Fonts:registerItalic("Roboto", "fonts/Roboto-Italic.ttf")
    Fonts:registerBoldItalic("Roboto", "fonts/Roboto-BoldItalic.ttf")
    view1:setTypeface("Roboto")

end

---
-- http://lua-users.org/wiki/FormattingNumbers
local function comma_value(n) -- credit http://richard.warburton.it
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

---
-- @param Thing may be nil if there was an error retrieving the user's profile
-- @usage exported
function bindView(Holder, Thing, ListItem)
    if Thing then
        Holder:getView("link_karma"):setText(comma_value(Thing:getLink_karma()))
        Holder:getView("comment_karma"):setText(comma_value(Thing:getComment_karma()))
    end
end
