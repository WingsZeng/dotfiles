c.colors.webpage.bg = '#222222'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.preferred_color_scheme = 'dark'

c.fonts.default_size = '23pt'
c.zoom.default = '200%'

c.auto_save.session = True
c.content.autoplay = False
c.content.default_encoding = 'utf-8'
c.content.javascript.clipboard = 'access-paste'
c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False
c.url.searchengines = {
    'DEFAULT': 'https://google.com/search?q={}'
}
c.editor.command = ['footclient', '-T', 'qutebrowser-editor', 'nvim', '-f', '{file}', '-c', 'normal {line}G{column0}l']

c.aliases = {
    'q': 'close',
}

c.bindings.commands = {
    'caret': {
        'yy': 'yank selection',
    },
    'hint': {
        'b': 'hint links -r tab-bg',
        'f': 'hint all',
        'F': 'hint all tab-fg',
        'i': 'hint images',
        'I': 'hint images tab',
        '/': 'hint inputs',
        'S': 'hint links download',
        'y': 'hint links yank',
        'o': 'hint links fill :open {hint-url}',
        'O': 'hint links fill :open -t -r {hint-url}',
        '<Escape>': 'mode-leave',
    },
    'normal': {
        '<Alt-9>': 'tab-focus 9',
        '<Alt-`>': 'tab-focus last',
        '<Ctrl-P>': 'print',
        '<Ctrl-T>': 'open -t',
        'J': 'tab-prev',
        'K': 'tab-next',
        'oo': 'cmd-set-text -s :open',
        'oO': 'cmd-set-text -s :open -t',
        'oe': 'cmd-set-text -s :open {url:pretty}',
        'oE': 'cmd-set-text -s :open -t {url:pretty}',
        'oq': 'cmd-set-text -s :quickmark-load',
        'oQ': 'cmd-set-text -s :quickmark-load -t',
        'ob': 'cmd-set-text -s :bookmark-load',
        'oB': 'cmd-set-text -s :bookmark-load -t',
        'op': 'open -- {clipboard}',
        'oP': 'open -t -- {clipboard}',
        'os': 'view-source',
        'es': 'view-source -e',
        'SB': 'bookmark-list -t',
        'SH': 'history -t',
        'SS': 'set -t',
        'gt': 'cmd-set-text -sr :tab-focus',
        'gp': 'navigate prev',
        'gn': 'navigate next',
        'gP': 'navigate -t prev',
        'gN': 'navigate -t next',
        'dd': 'tab-close',
        'dD': 'tab-only',
        'dc': 'download-clear',
        'dC': 'download-cancel',
        'do': 'download-open',
        'dr': 'download-retry',
        'dR': 'download-delete',
        'ss': 'cmd-set-text -s :session-save',
        'sl': 'cmd-set-text -s :session-load',
        'sd': 'cmd-set-text -s :session-delete',
        'bA': 'cmd-set-text -s :bookmark-add',
        'bD': 'cmd-set-text -s :bookmark-del',
        'bb': 'quickmark-save',
        'bd': 'cmd-set-text -s :quickmark-del',
        '<Ctrl-S>': 'download',
        '<F12>': 'devtools',
        'yy': 'yank pretty-url',
        'p': 'spawn --userscript qute-rbw --terminal footclient -d "fuzzel --dmenu"',
        'ud': 'config-cycle -t -p colors.webpage.darkmode.enabled true false',
        'uts': 'config-cycle -t -p tabs.show always multiple never switching',
        'utt': 'tabs.position top',
        'utl': 'tabs.position left',
        'utr': 'tabs.position right',
        'utb': 'tabs.position bottom',
        'uss': 'config-cycle -t -p statusbar.show always in-mode never',
    },
}

config.unbind('<Ctrl-Space>', mode='caret')
config.unbind('<Return>', mode='caret')
config.unbind('y', mode='caret')

del c.bindings.default['hint']

config.unbind('<Ctrl-E>', mode='insert')

config.unbind(';I', mode='normal')
config.unbind(';O', mode='normal')
config.unbind(';R', mode='normal')
config.unbind(';Y', mode='normal')
config.unbind(';b', mode='normal')
config.unbind(';d', mode='normal')
config.unbind(';f', mode='normal')
config.unbind(';h', mode='normal')
config.unbind(';i', mode='normal')
config.unbind(';o', mode='normal')
config.unbind(';r', mode='normal')
config.unbind(';t', mode='normal')
config.unbind(';y', mode='normal')

config.unbind('`', mode='normal')

config.unbind('<F5>', mode='normal')
config.unbind('<Ctrl-F5>', mode='normal')
config.unbind('<Ctrl-A>', mode='normal')
config.unbind('<Ctrl-X>', mode='normal')
config.unbind('<Ctrl-F>', mode='normal')
config.unbind('<Ctrl-B>', mode='normal')
config.unbind('<Ctrl-D>', mode='normal')
config.unbind('<Ctrl-U>', mode='normal')
config.unbind('<Ctrl-PgDown>', mode='normal')
config.unbind('<Ctrl-PgUp>', mode='normal')
config.unbind('<Ctrl-Q>', mode='normal')
config.unbind('<Ctrl-Return>', mode='normal')
config.unbind('<Ctrl-Shift-T>', mode='normal')
config.unbind('<Ctrl-Shift-Tab>', mode='normal')
config.unbind('<Ctrl-Shift-W>', mode='normal')
config.unbind('<Ctrl-T>', mode='normal')
config.unbind('<Ctrl-Tab>', mode='normal')
config.unbind('<Ctrl-^>', mode='normal')
config.unbind('<Ctrl-h>', mode='normal')
config.unbind('<Ctrl-p>', mode='normal')
config.unbind('<F11>', mode='normal')
config.unbind('<Return>', mode='normal')
config.unbind('<back>', mode='normal')
config.unbind('<forward>', mode='normal')

config.unbind('B', mode='normal')
config.unbind('D', mode='normal')
config.unbind('T', mode='normal')
config.unbind('U', mode='normal')
config.unbind('ZQ', mode='normal')
config.unbind('ZZ', mode='normal')
config.unbind('ad', mode='normal')
config.unbind('d', mode='normal')
config.unbind('b', mode='normal')
config.unbind('cd', mode='normal')
config.unbind('co', mode='normal')
config.unbind('m', mode='normal')
config.unbind('o', mode='normal')
config.unbind('u', mode='normal')

config.unbind('g$', mode='normal')
config.unbind('g0', mode='normal')
config.unbind('gB', mode='normal')
config.unbind('gC', mode='normal')
config.unbind('gD', mode='normal')
config.unbind('gJ', mode='normal')
config.unbind('gK', mode='normal')
config.unbind('gO', mode='normal')
config.unbind('gU', mode='normal')
config.unbind('g^', mode='normal')
config.unbind('ga', mode='normal')
config.unbind('gb', mode='normal')
config.unbind('gd', mode='normal')
config.unbind('gf', mode='normal')
config.unbind('gm', mode='normal')
config.unbind('go', mode='normal')
config.unbind('gu', mode='normal')

config.unbind('sf', mode='normal')
config.unbind('sk', mode='normal')
config.unbind('sl', mode='normal')
config.unbind('ss', mode='normal')

config.unbind('th', mode='normal')
config.unbind('tl', mode='normal')

config.unbind('wB', mode='normal')
config.unbind('wIf', mode='normal')
config.unbind('wIh', mode='normal')
config.unbind('wIj', mode='normal')
config.unbind('wIk', mode='normal')
config.unbind('wIl', mode='normal')
config.unbind('wIw', mode='normal')
config.unbind('wO', mode='normal')
config.unbind('wP', mode='normal')
config.unbind('wb', mode='normal')
config.unbind('wf', mode='normal')
config.unbind('wh', mode='normal')
config.unbind('wi', mode='normal')
config.unbind('wl', mode='normal')
config.unbind('wo', mode='normal')
config.unbind('wp', mode='normal')

config.unbind('yD', mode='normal')
config.unbind('yM', mode='normal')
config.unbind('yT', mode='normal')
config.unbind('yP', mode='normal')
config.unbind('yY', mode='normal')
config.unbind('yp', mode='normal')

config.load_autoconfig()
