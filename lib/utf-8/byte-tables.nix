let
  inherit (builtins) elemAt genList listToAttrs;
  # NUL (0, 0x00) not allowed in Nix strings
  # CR (13, 0x0d) reads as already defined attribute '"\n"'
  byteGenAttrs = gen:
    listToAttrs (genList (i: gen (if i > 11 then i + 2 else i + 1)) 254);
in rec {
from = [
  null #   0 (0x00)
  "" #   1 (0x01)
  "" #   2 (0x02)
  "" #   3 (0x03)
  "" #   4 (0x04)
  "" #   5 (0x05)
  "" #   6 (0x06)
  "" #   7 (0x07)
  "" #   8 (0x08)
  "	" #   9 (0x09)
  "
" #  10 (0x0a)
  "" #  11 (0x0b)
  "" #  12 (0x0c)
  "" #  13 (0x0d)
  "" #  14 (0x0e)
  "" #  15 (0x0f)
  "" #  16 (0x10)
  "" #  17 (0x11)
  "" #  18 (0x12)
  "" #  19 (0x13)
  "" #  20 (0x14)
  "" #  21 (0x15)
  "" #  22 (0x16)
  "" #  23 (0x17)
  "" #  24 (0x18)
  "" #  25 (0x19)
  "" #  26 (0x1a)
  "" #  27 (0x1b)
  "" #  28 (0x1c)
  "" #  29 (0x1d)
  "" #  30 (0x1e)
  "" #  31 (0x1f)
  " " #  32 (0x20)
  "!" #  33 (0x21)
  "\"" #  34 (0x22)
  "#" #  35 (0x23)
  "$" #  36 (0x24)
  "%" #  37 (0x25)
  "&" #  38 (0x26)
  "'" #  39 (0x27)
  "(" #  40 (0x28)
  ")" #  41 (0x29)
  "*" #  42 (0x2a)
  "+" #  43 (0x2b)
  "," #  44 (0x2c)
  "-" #  45 (0x2d)
  "." #  46 (0x2e)
  "/" #  47 (0x2f)
  "0" #  48 (0x30)
  "1" #  49 (0x31)
  "2" #  50 (0x32)
  "3" #  51 (0x33)
  "4" #  52 (0x34)
  "5" #  53 (0x35)
  "6" #  54 (0x36)
  "7" #  55 (0x37)
  "8" #  56 (0x38)
  "9" #  57 (0x39)
  ":" #  58 (0x3a)
  ";" #  59 (0x3b)
  "<" #  60 (0x3c)
  "=" #  61 (0x3d)
  ">" #  62 (0x3e)
  "?" #  63 (0x3f)
  "@" #  64 (0x40)
  "A" #  65 (0x41)
  "B" #  66 (0x42)
  "C" #  67 (0x43)
  "D" #  68 (0x44)
  "E" #  69 (0x45)
  "F" #  70 (0x46)
  "G" #  71 (0x47)
  "H" #  72 (0x48)
  "I" #  73 (0x49)
  "J" #  74 (0x4a)
  "K" #  75 (0x4b)
  "L" #  76 (0x4c)
  "M" #  77 (0x4d)
  "N" #  78 (0x4e)
  "O" #  79 (0x4f)
  "P" #  80 (0x50)
  "Q" #  81 (0x51)
  "R" #  82 (0x52)
  "S" #  83 (0x53)
  "T" #  84 (0x54)
  "U" #  85 (0x55)
  "V" #  86 (0x56)
  "W" #  87 (0x57)
  "X" #  88 (0x58)
  "Y" #  89 (0x59)
  "Z" #  90 (0x5a)
  "[" #  91 (0x5b)
  "\\" #  92 (0x5c)
  "]" #  93 (0x5d)
  "^" #  94 (0x5e)
  "_" #  95 (0x5f)
  "`" #  96 (0x60)
  "a" #  97 (0x61)
  "b" #  98 (0x62)
  "c" #  99 (0x63)
  "d" # 100 (0x64)
  "e" # 101 (0x65)
  "f" # 102 (0x66)
  "g" # 103 (0x67)
  "h" # 104 (0x68)
  "i" # 105 (0x69)
  "j" # 106 (0x6a)
  "k" # 107 (0x6b)
  "l" # 108 (0x6c)
  "m" # 109 (0x6d)
  "n" # 110 (0x6e)
  "o" # 111 (0x6f)
  "p" # 112 (0x70)
  "q" # 113 (0x71)
  "r" # 114 (0x72)
  "s" # 115 (0x73)
  "t" # 116 (0x74)
  "u" # 117 (0x75)
  "v" # 118 (0x76)
  "w" # 119 (0x77)
  "x" # 120 (0x78)
  "y" # 121 (0x79)
  "z" # 122 (0x7a)
  "{" # 123 (0x7b)
  "|" # 124 (0x7c)
  "}" # 125 (0x7d)
  "~" # 126 (0x7e)
  "" # 127 (0x7f)
  "�" # 128 (0x80)
  "�" # 129 (0x81)
  "�" # 130 (0x82)
  "�" # 131 (0x83)
  "�" # 132 (0x84)
  "�" # 133 (0x85)
  "�" # 134 (0x86)
  "�" # 135 (0x87)
  "�" # 136 (0x88)
  "�" # 137 (0x89)
  "�" # 138 (0x8a)
  "�" # 139 (0x8b)
  "�" # 140 (0x8c)
  "�" # 141 (0x8d)
  "�" # 142 (0x8e)
  "�" # 143 (0x8f)
  "�" # 144 (0x90)
  "�" # 145 (0x91)
  "�" # 146 (0x92)
  "�" # 147 (0x93)
  "�" # 148 (0x94)
  "�" # 149 (0x95)
  "�" # 150 (0x96)
  "�" # 151 (0x97)
  "�" # 152 (0x98)
  "�" # 153 (0x99)
  "�" # 154 (0x9a)
  "�" # 155 (0x9b)
  "�" # 156 (0x9c)
  "�" # 157 (0x9d)
  "�" # 158 (0x9e)
  "�" # 159 (0x9f)
  "�" # 160 (0xa0)
  "�" # 161 (0xa1)
  "�" # 162 (0xa2)
  "�" # 163 (0xa3)
  "�" # 164 (0xa4)
  "�" # 165 (0xa5)
  "�" # 166 (0xa6)
  "�" # 167 (0xa7)
  "�" # 168 (0xa8)
  "�" # 169 (0xa9)
  "�" # 170 (0xaa)
  "�" # 171 (0xab)
  "�" # 172 (0xac)
  "�" # 173 (0xad)
  "�" # 174 (0xae)
  "�" # 175 (0xaf)
  "�" # 176 (0xb0)
  "�" # 177 (0xb1)
  "�" # 178 (0xb2)
  "�" # 179 (0xb3)
  "�" # 180 (0xb4)
  "�" # 181 (0xb5)
  "�" # 182 (0xb6)
  "�" # 183 (0xb7)
  "�" # 184 (0xb8)
  "�" # 185 (0xb9)
  "�" # 186 (0xba)
  "�" # 187 (0xbb)
  "�" # 188 (0xbc)
  "�" # 189 (0xbd)
  "�" # 190 (0xbe)
  "�" # 191 (0xbf)
  "�" # 192 (0xc0)
  "�" # 193 (0xc1)
  "�" # 194 (0xc2)
  "�" # 195 (0xc3)
  "�" # 196 (0xc4)
  "�" # 197 (0xc5)
  "�" # 198 (0xc6)
  "�" # 199 (0xc7)
  "�" # 200 (0xc8)
  "�" # 201 (0xc9)
  "�" # 202 (0xca)
  "�" # 203 (0xcb)
  "�" # 204 (0xcc)
  "�" # 205 (0xcd)
  "�" # 206 (0xce)
  "�" # 207 (0xcf)
  "�" # 208 (0xd0)
  "�" # 209 (0xd1)
  "�" # 210 (0xd2)
  "�" # 211 (0xd3)
  "�" # 212 (0xd4)
  "�" # 213 (0xd5)
  "�" # 214 (0xd6)
  "�" # 215 (0xd7)
  "�" # 216 (0xd8)
  "�" # 217 (0xd9)
  "�" # 218 (0xda)
  "�" # 219 (0xdb)
  "�" # 220 (0xdc)
  "�" # 221 (0xdd)
  "�" # 222 (0xde)
  "�" # 223 (0xdf)
  "�" # 224 (0xe0)
  "�" # 225 (0xe1)
  "�" # 226 (0xe2)
  "�" # 227 (0xe3)
  "�" # 228 (0xe4)
  "�" # 229 (0xe5)
  "�" # 230 (0xe6)
  "�" # 231 (0xe7)
  "�" # 232 (0xe8)
  "�" # 233 (0xe9)
  "�" # 234 (0xea)
  "�" # 235 (0xeb)
  "�" # 236 (0xec)
  "�" # 237 (0xed)
  "�" # 238 (0xee)
  "�" # 239 (0xef)
  "�" # 240 (0xf0)
  "�" # 241 (0xf1)
  "�" # 242 (0xf2)
  "�" # 243 (0xf3)
  "�" # 244 (0xf4)
  "�" # 245 (0xf5)
  "�" # 246 (0xf6)
  "�" # 247 (0xf7)
  "�" # 248 (0xf8)
  "�" # 249 (0xf9)
  "�" # 250 (0xfa)
  "�" # 251 (0xfb)
  "�" # 252 (0xfc)
  "�" # 253 (0xfd)
  "�" # 254 (0xfe)
  "�" # 255 (0xff)
];
to = byteGenAttrs (b: {
  name = elemAt from b;
  value = b;
});
# based on Rust's core::str::UTF8_CHAR_WIDTH (MIT license)
# extended to return -1 on continutation
byteCharWidth = [
# 0 1 2 3 4 5 6 7 8 9 A B C D E F
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 # 0x1F
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 # 0x3F
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 # 0x5F
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 # 0x7F
  (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1)
  (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) # 0x9F
  (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1)
  (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) (-1) # 0xBF
  0 0 2 2 2 2 2 2 2 2 2 2 2 2 2 2
  2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 # 0xDF
  3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 # 0xEF
  4 4 4 4 4 0 0 0 0 0 0 0 0 0 0 0 # 0xFF
];
charWidth = byteGenAttrs (b: {
  name = elemAt from b;
  value = elemAt byteCharWidth b;
});
}

# vim: bin:fenc=latin1:isp=:display+=uhex
