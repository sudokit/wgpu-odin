package application

Keyboard_Modifier_Key :: struct {
	left_shift:  bool,
	right_shift: bool,
	left_ctrl:   bool,
	right_ctrl:  bool,
	left_alt:    bool,
	right_alt:   bool,
	left_super:  bool,
	right_super: bool,
	num:         bool,
	caps:        bool,
	mode:        bool,
}

Keyboard_Scancode :: enum i32 {
	Unknown,
	A,
	B,
	C,
	D,
	E,
	F,
	G,
	H,
	I,
	J,
	K,
	L,
	M,
	N,
	O,
	P,
	Q,
	R,
	S,
	T,
	U,
	V,
	W,
	X,
	Y,
	Z,
	Num_1,
	Num_2,
	Num_3,
	Num_4,
	Num_5,
	Num_6,
	Num_7,
	Num_8,
	Num_9,
	Num_0,
	Return,
	Escape,
	Backspace,
	Tab,
	Space,
	Minus,
	Equals,
	Left_Bracket,
	Right_Bracket,
	Backslash,
	Non_Us_Hash,
	Semicolon,
	Apostrophe,
	Grave,
	Comma,
	Period,
	Slash,
	Caps_Lock,
	F1,
	F2,
	F3,
	F4,
	F5,
	F6,
	F7,
	F8,
	F9,
	F10,
	F11,
	F12,
	Print_Screen,
	Scroll_Lock,
	Pause,
	Insert,
	Home,
	Page_Up,
	Delete,
	End,
	Page_Down,
	Right,
	Left,
	Down,
	Up,
	Num_Lock_Clear,
	Kp_Divide,
	Kp_Multiply,
	Kp_Minus,
	Kp_Plus,
	Kp_Enter,
	Kp_1,
	Kp_2,
	Kp_3,
	Kp_4,
	Kp_5,
	Kp_6,
	Kp_7,
	Kp_8,
	Kp_9,
	Kp_0,
	Kp_Period,
	Non_Us_Backslash,
	Application,
	Power,
	Kp_Equals,
	F13,
	F14,
	F15,
	F16,
	F17,
	F18,
	F19,
	F20,
	F21,
	F22,
	F23,
	F24,
	Execute,
	Help,
	Menu,
	Select,
	Stop,
	Again,
	Undo,
	Cut,
	Copy,
	Paste,
	Find,
	Mute,
	Volume_Up,
	Volume_Down,
	Kp_Comma,
	Kp_Equals_As_400,
	International_1,
	International_2,
	International_3,
	International_4,
	International_5,
	International_6,
	International_7,
	International_8,
	International_9,
	Lang_1,
	Lang_2,
	Lang_3,
	Lang_4,
	Lang_5,
	Lang_6,
	Lang_7,
	Lang_8,
	Lang_9,
	Alt_Erase,
	Sys_Req,
	Cancel,
	Clear,
	Prior,
	Return_2,
	Separator,
	Out,
	Oper,
	Clear_Again,
	Cr_Sel,
	Ex_Sel,
	Kp_00,
	Kp_000,
	Thousands_Separator,
	Decimal_Separator,
	Currency_Unit,
	Currency_Subunit,
	Kp_Left_Paren,
	Kp_Right_Paren,
	Kp_Left_Brace,
	Kp_Right_Brace,
	Kp_Tab,
	Kp_Backspace,
	Kp_A,
	Kp_B,
	Kp_C,
	Kp_D,
	Kp_E,
	Kp_F,
	Kp_Xor,
	Kp_Power,
	Kp_Percent,
	Kp_Less,
	Kp_Greater,
	Kp_Ampersand,
	Kp_Dbl_Ampersand,
	Kp_Vertical_Bar,
	Kp_Dbl_Vertical_Bar,
	Kp_Colon,
	Kp_Hash,
	Kp_Space,
	Kp_At,
	Kp_Exclam,
	Kp_Mem_Store,
	Kp_Mem_Recall,
	Kp_Mem_Clear,
	Kp_Mem_Add,
	Kp_Mem_Subtract,
	Kp_Mem_Multiply,
	Kp_Mem_Divide,
	Kp_Plus_Minus,
	Kp_Clear,
	Kp_Clear_Entry,
	Kp_Binary,
	Kp_Octal,
	Kp_Decimal,
	Kp_Hexadecimal,
	Left_Ctrl,
	Left_Shift,
	Left_Alt,
	Left_Gui,
	Right_Ctrl,
	Right_Shift,
	Right_Alt,
	Right_Gui,
	Mode,
	Audio_Next,
	Audio_Prev,
	Audio_Stop,
	Audio_Play,
	Audio_Mute,
	Media_Select,
	WWW,
	Mail,
	Calculator,
	Computer,
	Ac_Search,
	Ac_Home,
	Ac_Back,
	Ac_Forward,
	Ac_Stop,
	Ac_Refresh,
	Ac_Bookmarks,
	Brightness_Down,
	Brightness_Up,
	Display_Switch,
	Kbd_Illum_Toggle,
	Kbd_Illum_Down,
	Kbd_Illum_Up,
	Eject,
	Sleep,
	App_1,
	App_2,
	Audio_Rewind,
	Audio_Fastforward,
}

KEY_SCANCODE_MASK :: 1 << 30

Keyboard_Key :: enum i32 {
	Unknown             = 0,
	Return              = '\r',
	Escape              = '\x1B',
	Backspace           = '\b',
	Tab                 = '\t',
	Space               = ' ',
	Exclaim             = '!',
	Quotedbl            = '"',
	Hash                = '#',
	Percent             = '%',
	Dollar              = '$',
	Ampersand           = '&',
	Quote               = '\'',
	Left_Paren          = '(',
	Right_Paren         = ')',
	Asterisk            = '*',
	Plus                = '+',
	Comma               = ',',
	Minus               = '-',
	Period              = '.',
	Slash               = '/',
	Num_0               = '0',
	Num_1               = '1',
	Num_2               = '2',
	Num_3               = '3',
	Num_4               = '4',
	Num_5               = '5',
	Num_6               = '6',
	Num_7               = '7',
	Num_8               = '8',
	Num_9               = '9',
	Colon               = ':',
	Semicolon           = ';',
	Less                = '<',
	Equals              = '=',
	Greater             = '>',
	Question            = '?',
	At                  = '@',
	Left_Bracket        = '[',
	Backslash           = '\\',
	Right_Bracket       = ']',
	Caret               = '^',
	Underscore          = '_',
	Backquote           = '`',
	a                   = 'a',
	b                   = 'b',
	c                   = 'c',
	d                   = 'd',
	e                   = 'e',
	f                   = 'f',
	g                   = 'g',
	h                   = 'h',
	i                   = 'i',
	j                   = 'j',
	k                   = 'k',
	l                   = 'l',
	m                   = 'm',
	n                   = 'n',
	o                   = 'o',
	p                   = 'p',
	q                   = 'q',
	r                   = 'r',
	s                   = 's',
	t                   = 't',
	u                   = 'u',
	v                   = 'v',
	w                   = 'w',
	x                   = 'x',
	y                   = 'y',
	z                   = 'z',
	A                   = a,
	B                   = b,
	C                   = c,
	D                   = d,
	E                   = e,
	F                   = f,
	G                   = g,
	H                   = h,
	I                   = i,
	J                   = j,
	K                   = k,
	L                   = l,
	M                   = m,
	N                   = n,
	O                   = o,
	P                   = p,
	Q                   = q,
	R                   = r,
	S                   = s,
	T                   = t,
	U                   = u,
	V                   = v,
	W                   = w,
	X                   = x,
	Y                   = y,
	Z                   = z,
	Caps_Lock           = auto_cast (Keyboard_Scancode.Caps_Lock | KEY_SCANCODE_MASK),
	F1                  = auto_cast (Keyboard_Scancode.F1 | KEY_SCANCODE_MASK),
	F2                  = auto_cast (Keyboard_Scancode.F2 | KEY_SCANCODE_MASK),
	F3                  = auto_cast (Keyboard_Scancode.F3 | KEY_SCANCODE_MASK),
	F4                  = auto_cast (Keyboard_Scancode.F4 | KEY_SCANCODE_MASK),
	F5                  = auto_cast (Keyboard_Scancode.F5 | KEY_SCANCODE_MASK),
	F6                  = auto_cast (Keyboard_Scancode.F6 | KEY_SCANCODE_MASK),
	F7                  = auto_cast (Keyboard_Scancode.F7 | KEY_SCANCODE_MASK),
	F8                  = auto_cast (Keyboard_Scancode.F8 | KEY_SCANCODE_MASK),
	F9                  = auto_cast (Keyboard_Scancode.F9 | KEY_SCANCODE_MASK),
	F10                 = auto_cast (Keyboard_Scancode.F10 | KEY_SCANCODE_MASK),
	F11                 = auto_cast (Keyboard_Scancode.F11 | KEY_SCANCODE_MASK),
	F12                 = auto_cast (Keyboard_Scancode.F12 | KEY_SCANCODE_MASK),
	Print_Screen        = auto_cast (Keyboard_Scancode.Print_Screen | KEY_SCANCODE_MASK),
	Scroll_Lock         = auto_cast (Keyboard_Scancode.Scroll_Lock | KEY_SCANCODE_MASK),
	Pause               = auto_cast (Keyboard_Scancode.Pause | KEY_SCANCODE_MASK),
	Insert              = auto_cast (Keyboard_Scancode.Insert | KEY_SCANCODE_MASK),
	Home                = auto_cast (Keyboard_Scancode.Home | KEY_SCANCODE_MASK),
	Page_Up             = auto_cast (Keyboard_Scancode.Page_Up | KEY_SCANCODE_MASK),
	Delete              = '\x7F',
	End                 = auto_cast (Keyboard_Scancode.End | KEY_SCANCODE_MASK),
	Page_Down           = auto_cast (Keyboard_Scancode.Page_Down | KEY_SCANCODE_MASK),
	Right               = auto_cast (Keyboard_Scancode.Right | KEY_SCANCODE_MASK),
	Left                = auto_cast (Keyboard_Scancode.Left | KEY_SCANCODE_MASK),
	Down                = auto_cast (Keyboard_Scancode.Down | KEY_SCANCODE_MASK),
	Up                  = auto_cast (Keyboard_Scancode.Up | KEY_SCANCODE_MASK),
	Num_Lock_Clear      = auto_cast (Keyboard_Scancode.Num_Lock_Clear | KEY_SCANCODE_MASK),
	Kp_Divide           = auto_cast (Keyboard_Scancode.Kp_Divide | KEY_SCANCODE_MASK),
	Kp_Multiply         = auto_cast (Keyboard_Scancode.Kp_Multiply | KEY_SCANCODE_MASK),
	Kp_Minus            = auto_cast (Keyboard_Scancode.Kp_Minus | KEY_SCANCODE_MASK),
	Kp_Plus             = auto_cast (Keyboard_Scancode.Kp_Plus | KEY_SCANCODE_MASK),
	Kp_Enter            = auto_cast (Keyboard_Scancode.Kp_Enter | KEY_SCANCODE_MASK),
	Kp_1                = auto_cast (Keyboard_Scancode.Kp_1 | KEY_SCANCODE_MASK),
	Kp_2                = auto_cast (Keyboard_Scancode.Kp_2 | KEY_SCANCODE_MASK),
	Kp_3                = auto_cast (Keyboard_Scancode.Kp_3 | KEY_SCANCODE_MASK),
	Kp_4                = auto_cast (Keyboard_Scancode.Kp_4 | KEY_SCANCODE_MASK),
	Kp_5                = auto_cast (Keyboard_Scancode.Kp_5 | KEY_SCANCODE_MASK),
	Kp_6                = auto_cast (Keyboard_Scancode.Kp_6 | KEY_SCANCODE_MASK),
	Kp_7                = auto_cast (Keyboard_Scancode.Kp_7 | KEY_SCANCODE_MASK),
	Kp_8                = auto_cast (Keyboard_Scancode.Kp_8 | KEY_SCANCODE_MASK),
	Kp_9                = auto_cast (Keyboard_Scancode.Kp_9 | KEY_SCANCODE_MASK),
	Kp_0                = auto_cast (Keyboard_Scancode.Kp_0 | KEY_SCANCODE_MASK),
	Kp_Period           = auto_cast (Keyboard_Scancode.Kp_Period | KEY_SCANCODE_MASK),
	Application         = auto_cast (Keyboard_Scancode.Application | KEY_SCANCODE_MASK),
	Power               = auto_cast (Keyboard_Scancode.Power | KEY_SCANCODE_MASK),
	Kp_Equals           = auto_cast (Keyboard_Scancode.Kp_Equals | KEY_SCANCODE_MASK),
	F13                 = auto_cast (Keyboard_Scancode.F13 | KEY_SCANCODE_MASK),
	F14                 = auto_cast (Keyboard_Scancode.F14 | KEY_SCANCODE_MASK),
	F15                 = auto_cast (Keyboard_Scancode.F15 | KEY_SCANCODE_MASK),
	F16                 = auto_cast (Keyboard_Scancode.F16 | KEY_SCANCODE_MASK),
	F17                 = auto_cast (Keyboard_Scancode.F17 | KEY_SCANCODE_MASK),
	F18                 = auto_cast (Keyboard_Scancode.F18 | KEY_SCANCODE_MASK),
	F19                 = auto_cast (Keyboard_Scancode.F19 | KEY_SCANCODE_MASK),
	F20                 = auto_cast (Keyboard_Scancode.F20 | KEY_SCANCODE_MASK),
	F21                 = auto_cast (Keyboard_Scancode.F21 | KEY_SCANCODE_MASK),
	F22                 = auto_cast (Keyboard_Scancode.F22 | KEY_SCANCODE_MASK),
	F23                 = auto_cast (Keyboard_Scancode.F23 | KEY_SCANCODE_MASK),
	F24                 = auto_cast (Keyboard_Scancode.F24 | KEY_SCANCODE_MASK),
	Execute             = auto_cast (Keyboard_Scancode.Execute | KEY_SCANCODE_MASK),
	Help                = auto_cast (Keyboard_Scancode.Help | KEY_SCANCODE_MASK),
	Menu                = auto_cast (Keyboard_Scancode.Menu | KEY_SCANCODE_MASK),
	Select              = auto_cast (Keyboard_Scancode.Select | KEY_SCANCODE_MASK),
	Stop                = auto_cast (Keyboard_Scancode.Stop | KEY_SCANCODE_MASK),
	Again               = auto_cast (Keyboard_Scancode.Again | KEY_SCANCODE_MASK),
	Undo                = auto_cast (Keyboard_Scancode.Undo | KEY_SCANCODE_MASK),
	Cut                 = auto_cast (Keyboard_Scancode.Cut | KEY_SCANCODE_MASK),
	Copy                = auto_cast (Keyboard_Scancode.Copy | KEY_SCANCODE_MASK),
	Paste               = auto_cast (Keyboard_Scancode.Paste | KEY_SCANCODE_MASK),
	Find                = auto_cast (Keyboard_Scancode.Find | KEY_SCANCODE_MASK),
	Mute                = auto_cast (Keyboard_Scancode.Mute | KEY_SCANCODE_MASK),
	Volume_Up           = auto_cast (Keyboard_Scancode.Volume_Up | KEY_SCANCODE_MASK),
	Volume_Down         = auto_cast (Keyboard_Scancode.Volume_Down | KEY_SCANCODE_MASK),
	Kp_Comma            = auto_cast (Keyboard_Scancode.Kp_Comma | KEY_SCANCODE_MASK),
	Kp_Equals_As_400    = auto_cast (Keyboard_Scancode.Kp_Equals_As_400 | KEY_SCANCODE_MASK),
	Alt_Erase           = auto_cast (Keyboard_Scancode.Alt_Erase | KEY_SCANCODE_MASK),
	Sys_Req             = auto_cast (Keyboard_Scancode.Sys_Req | KEY_SCANCODE_MASK),
	Cancel              = auto_cast (Keyboard_Scancode.Cancel | KEY_SCANCODE_MASK),
	Clear               = auto_cast (Keyboard_Scancode.Clear | KEY_SCANCODE_MASK),
	Prior               = auto_cast (Keyboard_Scancode.Prior | KEY_SCANCODE_MASK),
	Return2             = auto_cast (Keyboard_Scancode.Return_2 | KEY_SCANCODE_MASK),
	Separator           = auto_cast (Keyboard_Scancode.Separator | KEY_SCANCODE_MASK),
	Out                 = auto_cast (Keyboard_Scancode.Out | KEY_SCANCODE_MASK),
	Oper                = auto_cast (Keyboard_Scancode.Oper | KEY_SCANCODE_MASK),
	Clear_Again         = auto_cast (Keyboard_Scancode.Clear_Again | KEY_SCANCODE_MASK),
	Cr_Sel              = auto_cast (Keyboard_Scancode.Cr_Sel | KEY_SCANCODE_MASK),
	Ex_Sel              = auto_cast (Keyboard_Scancode.Ex_Sel | KEY_SCANCODE_MASK),
	Kp_00               = auto_cast (Keyboard_Scancode.Kp_00 | KEY_SCANCODE_MASK),
	Kp_000              = auto_cast (Keyboard_Scancode.Kp_000 | KEY_SCANCODE_MASK),
	Thousands_Separator = auto_cast (Keyboard_Scancode.Thousands_Separator | KEY_SCANCODE_MASK),
	Decimal_Separator   = auto_cast (Keyboard_Scancode.Decimal_Separator | KEY_SCANCODE_MASK),
	Currency_Unit       = auto_cast (Keyboard_Scancode.Currency_Unit | KEY_SCANCODE_MASK),
	Currency_Subunit    = auto_cast (Keyboard_Scancode.Currency_Subunit | KEY_SCANCODE_MASK),
	Kp_Left_Paren       = auto_cast (Keyboard_Scancode.Kp_Left_Paren | KEY_SCANCODE_MASK),
	Kp_Right_Paren      = auto_cast (Keyboard_Scancode.Kp_Right_Paren | KEY_SCANCODE_MASK),
	Kp_Left_Brace       = auto_cast (Keyboard_Scancode.Kp_Left_Brace | KEY_SCANCODE_MASK),
	Kp_Right_Brace      = auto_cast (Keyboard_Scancode.Kp_Right_Brace | KEY_SCANCODE_MASK),
	Kp_Tab              = auto_cast (Keyboard_Scancode.Kp_Tab | KEY_SCANCODE_MASK),
	Kp_Backspace        = auto_cast (Keyboard_Scancode.Kp_Backspace | KEY_SCANCODE_MASK),
	Kp_A                = auto_cast (Keyboard_Scancode.Kp_A | KEY_SCANCODE_MASK),
	Kp_B                = auto_cast (Keyboard_Scancode.Kp_B | KEY_SCANCODE_MASK),
	Kp_C                = auto_cast (Keyboard_Scancode.Kp_C | KEY_SCANCODE_MASK),
	Kp_D                = auto_cast (Keyboard_Scancode.Kp_D | KEY_SCANCODE_MASK),
	Kp_E                = auto_cast (Keyboard_Scancode.Kp_E | KEY_SCANCODE_MASK),
	Kp_F                = auto_cast (Keyboard_Scancode.Kp_F | KEY_SCANCODE_MASK),
	Kp_Xor              = auto_cast (Keyboard_Scancode.Kp_Xor | KEY_SCANCODE_MASK),
	Kp_Power            = auto_cast (Keyboard_Scancode.Kp_Power | KEY_SCANCODE_MASK),
	Kp_Percent          = auto_cast (Keyboard_Scancode.Kp_Percent | KEY_SCANCODE_MASK),
	Kp_Less             = auto_cast (Keyboard_Scancode.Kp_Less | KEY_SCANCODE_MASK),
	Kp_Greater          = auto_cast (Keyboard_Scancode.Kp_Greater | KEY_SCANCODE_MASK),
	Kp_Ampersand        = auto_cast (Keyboard_Scancode.Kp_Ampersand | KEY_SCANCODE_MASK),
	Kp_Dbl_Ampersand    = auto_cast (Keyboard_Scancode.Kp_Dbl_Ampersand | KEY_SCANCODE_MASK),
	Kp_Vertical_Bar     = auto_cast (Keyboard_Scancode.Kp_Vertical_Bar | KEY_SCANCODE_MASK),
	Kp_Dbl_Vertical_Bar = auto_cast (Keyboard_Scancode.Kp_Dbl_Vertical_Bar | KEY_SCANCODE_MASK),
	Kp_Colon            = auto_cast (Keyboard_Scancode.Kp_Colon | KEY_SCANCODE_MASK),
	Kp_Hash             = auto_cast (Keyboard_Scancode.Kp_Hash | KEY_SCANCODE_MASK),
	Kp_Space            = auto_cast (Keyboard_Scancode.Kp_Space | KEY_SCANCODE_MASK),
	Kp_At               = auto_cast (Keyboard_Scancode.Kp_At | KEY_SCANCODE_MASK),
	Kp_Exclam           = auto_cast (Keyboard_Scancode.Kp_Exclam | KEY_SCANCODE_MASK),
	Kp_Mem_Store        = auto_cast (Keyboard_Scancode.Kp_Mem_Store | KEY_SCANCODE_MASK),
	Kp_Mem_Recall       = auto_cast (Keyboard_Scancode.Kp_Mem_Recall | KEY_SCANCODE_MASK),
	Kp_Mem_Clear        = auto_cast (Keyboard_Scancode.Kp_Mem_Clear | KEY_SCANCODE_MASK),
	Kp_Mem_Add          = auto_cast (Keyboard_Scancode.Kp_Mem_Add | KEY_SCANCODE_MASK),
	Kp_Mem_Subtract     = auto_cast (Keyboard_Scancode.Kp_Mem_Subtract | KEY_SCANCODE_MASK),
	Kp_Mem_Multiply     = auto_cast (Keyboard_Scancode.Kp_Mem_Multiply | KEY_SCANCODE_MASK),
	Kp_Mem_Divide       = auto_cast (Keyboard_Scancode.Kp_Mem_Divide | KEY_SCANCODE_MASK),
	Kp_Plus_Minus       = auto_cast (Keyboard_Scancode.Kp_Plus_Minus | KEY_SCANCODE_MASK),
	Kp_Clear            = auto_cast (Keyboard_Scancode.Kp_Clear | KEY_SCANCODE_MASK),
	Kp_Clear_Entry      = auto_cast (Keyboard_Scancode.Kp_Clear_Entry | KEY_SCANCODE_MASK),
	Kp_Binary           = auto_cast (Keyboard_Scancode.Kp_Binary | KEY_SCANCODE_MASK),
	Kp_Octal            = auto_cast (Keyboard_Scancode.Kp_Octal | KEY_SCANCODE_MASK),
	Kp_Decimal          = auto_cast (Keyboard_Scancode.Kp_Decimal | KEY_SCANCODE_MASK),
	Kp_Hexadecimal      = auto_cast (Keyboard_Scancode.Kp_Hexadecimal | KEY_SCANCODE_MASK),
	Left_Ctrl           = auto_cast (Keyboard_Scancode.Left_Ctrl | KEY_SCANCODE_MASK),
	Left_Shift          = auto_cast (Keyboard_Scancode.Left_Shift | KEY_SCANCODE_MASK),
	Left_Alt            = auto_cast (Keyboard_Scancode.Left_Alt | KEY_SCANCODE_MASK),
	Left_Gui            = auto_cast (Keyboard_Scancode.Left_Gui | KEY_SCANCODE_MASK),
	Right_Ctrl          = auto_cast (Keyboard_Scancode.Right_Ctrl | KEY_SCANCODE_MASK),
	Right_Shift         = auto_cast (Keyboard_Scancode.Right_Shift | KEY_SCANCODE_MASK),
	Right_Alt           = auto_cast (Keyboard_Scancode.Right_Alt | KEY_SCANCODE_MASK),
	Right_Gui           = auto_cast (Keyboard_Scancode.Right_Gui | KEY_SCANCODE_MASK),
	Mode                = auto_cast (Keyboard_Scancode.Mode | KEY_SCANCODE_MASK),
	Audio_Next          = auto_cast (Keyboard_Scancode.Audio_Next | KEY_SCANCODE_MASK),
	Audio_Prev          = auto_cast (Keyboard_Scancode.Audio_Prev | KEY_SCANCODE_MASK),
	Audio_Stop          = auto_cast (Keyboard_Scancode.Audio_Stop | KEY_SCANCODE_MASK),
	Audio_Play          = auto_cast (Keyboard_Scancode.Audio_Play | KEY_SCANCODE_MASK),
	Audio_Mute          = auto_cast (Keyboard_Scancode.Audio_Mute | KEY_SCANCODE_MASK),
	Media_Select        = auto_cast (Keyboard_Scancode.Media_Select | KEY_SCANCODE_MASK),
	WWW                 = auto_cast (Keyboard_Scancode.WWW | KEY_SCANCODE_MASK),
	Mail                = auto_cast (Keyboard_Scancode.Mail | KEY_SCANCODE_MASK),
	Calculator          = auto_cast (Keyboard_Scancode.Calculator | KEY_SCANCODE_MASK),
	Computer            = auto_cast (Keyboard_Scancode.Computer | KEY_SCANCODE_MASK),
	Ac_Search           = auto_cast (Keyboard_Scancode.Ac_Search | KEY_SCANCODE_MASK),
	Ac_Home             = auto_cast (Keyboard_Scancode.Ac_Home | KEY_SCANCODE_MASK),
	Ac_Back             = auto_cast (Keyboard_Scancode.Ac_Back | KEY_SCANCODE_MASK),
	Ac_Forward          = auto_cast (Keyboard_Scancode.Ac_Forward | KEY_SCANCODE_MASK),
	Ac_Stop             = auto_cast (Keyboard_Scancode.Ac_Stop | KEY_SCANCODE_MASK),
	Ac_Refresh          = auto_cast (Keyboard_Scancode.Ac_Refresh | KEY_SCANCODE_MASK),
	Ac_Bookmarks        = auto_cast (Keyboard_Scancode.Ac_Bookmarks | KEY_SCANCODE_MASK),
	Brightness_Down     = auto_cast (Keyboard_Scancode.Brightness_Down | KEY_SCANCODE_MASK),
	Brightness_Up       = auto_cast (Keyboard_Scancode.Brightness_Up | KEY_SCANCODE_MASK),
	Display_Switch      = auto_cast (Keyboard_Scancode.Display_Switch | KEY_SCANCODE_MASK),
	Kbd_Illum_Toggle    = auto_cast (Keyboard_Scancode.Kbd_Illum_Toggle | KEY_SCANCODE_MASK),
	Kbd_Illum_Down      = auto_cast (Keyboard_Scancode.Kbd_Illum_Down | KEY_SCANCODE_MASK),
	Kbd_Illum_Up        = auto_cast (Keyboard_Scancode.Kbd_Illum_Up | KEY_SCANCODE_MASK),
	Eject               = auto_cast (Keyboard_Scancode.Eject | KEY_SCANCODE_MASK),
	Sleep               = auto_cast (Keyboard_Scancode.Sleep | KEY_SCANCODE_MASK),
	App_1               = auto_cast (Keyboard_Scancode.App_1 | KEY_SCANCODE_MASK),
	App_2               = auto_cast (Keyboard_Scancode.App_2 | KEY_SCANCODE_MASK),
	Audio_Rewind        = auto_cast (Keyboard_Scancode.Audio_Rewind | KEY_SCANCODE_MASK),
	Audio_Fastforward   = auto_cast (Keyboard_Scancode.Audio_Fastforward | KEY_SCANCODE_MASK),
}