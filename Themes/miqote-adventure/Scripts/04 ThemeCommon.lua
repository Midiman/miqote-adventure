-- Define the widths and heights of our main menus, for easy plotting later

_header_height = 64
_footer_height = 72

MENU_HEADER_HEIGHT = _header_height
MENU_FOOTER_HEIGHT = _footer_height

MENU_TOP = _header_height
MENU_BOTTOM = SCREEN_BOTTOM - _footer_height
MENU_LEFT = SCREEN_LEFT
MENU_RIGHT = SCREEN_RIGHT
MENU_HEIGHT = SCREEN_HEIGHT - _header_height - _footer_height
MENU_WIDTH = SCREEN_WIDTH
MENU_CENTER_X = SCREEN_CENTER_X
MENU_CENTER_Y = _header_height + (MENU_HEIGHT/2)

MENU_LEFT_SAFE = MENU_LEFT + MENU_WIDTH * 0.075
MENU_RIGHT_SAFE = MENU_LEFT + MENU_WIDTH * 0.925
MENU_TOP_SAFE = MENU_TOP + MENU_HEIGHT * 0.075
MENU_BOTTOM_SAFE = MENU_TOP + MENU_HEIGHT * 0.925

-- Define default tween speeds
TIME_INSTANT = 0.05
TIME_SHORT  = 0.125
TIME_NORMAL = 0.25
TIME_LONG   = 0.8