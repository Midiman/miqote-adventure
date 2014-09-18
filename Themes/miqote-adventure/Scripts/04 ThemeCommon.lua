-- Define the widths and heights of our main menus, for easy plotting later

_header_height = 80
_footer_height = 72

MENU_TOP = _header_height
MENU_BOTTOM = SCREEN_BOTTOM - _footer_height
MENU_LEFT = SCREEN_LEFT
MENU_RIGHT = SCREEN_RIGHT
MENU_HEIGHT = SCREEN_HEIGHT - _header_height - _footer_height
MENU_WIDTH = SCREEN_WIDTH
MENU_CENTER_X = SCREEN_CENTER_X
MENU_CENTER_Y = _header_height + (MENU_HEIGHT/2)

-- Define default tween speeds
TIME_SHORT  = 0.125
TIME_NORMAL = 0.25
TIME_LONG   = 0.8