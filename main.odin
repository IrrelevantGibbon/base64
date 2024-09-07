package base

import "core:mem"
import "core:strings"
import "core:os"
import "core:math"

EncodingTable64 :: distinct [64]byte
EncodedBase64String :: string

PADDING_BYTE :: '='

EncodedLength :: struct {
    total: int,
    length: int,
    padding: int
}

basic_encoding_table_64 := EncodingTable64{
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
    'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3',
    '4', '5', '6', '7', '8', '9', '+', '/', 
}

url_encoding_table_64 := EncodingTable64{
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
    'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3',
    '4', '5', '6', '7', '8', '9', '-', '_', 
}

EncodeBase64 :: proc(content: []byte, table: EncodingTable64 = basic_encoding_table_64, allocator: mem.Allocator = context.allocator) -> (EncodedBase64String, mem.Allocator_Error) {
    encoded_length := GetEncodedLength(content)

    if encoded_length.total == 0 {
        return EncodedBase64String{}, nil
    } 

	builder, err := strings.builder_make(0, encoded_length.total, allocator)
    defer strings.builder_destroy(&builder)

    if err != os.ERROR_NONE {
        return EncodedBase64String{}, err
    }

    i := 0
    for ; i + 4 <= len(content); i += 3 {
        #no_bounds_check {
            strings.write_byte(&builder, table[content[i] >> 2])
            strings.write_byte(&builder, table[content[i] & 0b11 << 4 | content[i + 1] >> 4])
            strings.write_byte(&builder, table[content[i + 1] & 0b1111 << 2 | content[i + 2] >> 6])
            strings.write_byte(&builder, table[content[i + 2] & 0b111111])
        }
    }

    rest := len(content) - i
    if rest > 0 {
        switch rest {
            case 1:
                strings.write_byte(&builder, table[content[i] >> 2])
                strings.write_byte(&builder, table[content[i] & 0b11])
            case 2:
                strings.write_byte(&builder, table[content[i] >> 2])
                strings.write_byte(&builder, table[content[i] & 0b11 << 4 | content[i + 1] >> 4])
                strings.write_byte(&builder, table[content[i + 1] & 0b1111 << 2])
        }
    }

    for i in 0 ..< encoded_length.padding {
        strings.write_byte(&builder, PADDING_BYTE)
    }

    return transmute(EncodedBase64String)strings.to_string(builder), nil
}

GetEncodedLength :: proc(content: []byte) -> EncodedLength {
    content_length := len(content)
    total_length := ((4 * content_length / 3) + 3) &~ 3
    length := 4 * content_length / 3 + (4 * content_length % 3)
    return EncodedLength{
        total_length,
        length,
        total_length - length
    }
}