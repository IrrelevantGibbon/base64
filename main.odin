package base

import "core:mem"
import "core:strings"


EncodingTable64 :: distinct [64]byte
EncodedBase64String :: string

EncodingTable32 :: distinct [32]byte
EncodedBase32String :: string

EncodingTable16 :: distinct [16]byte
EncodedBase16String :: string

PADDING_CHAR :: '='

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

basic_encoding_table_32 := EncodingTable32{
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
    'Y', 'Z', '2', '3', '4', '5', '6', '7', 
}

extended_hex_encoding_table_32 := EncodingTable32{
	'0', '1', '2', '3', '4', '5', '6', '7', 
	'8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 
	'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
	'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 
}

basic_encoding_table_16 := EncodingTable16{
	'0', '1', '2', '3', '4', '5', '6', '7', 
	'8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
}

EncodeBase64 :: proc(content: []byte, table: EncodingTable64 = basic_encoding_table_64, allocator: mem.Allocator = context.allocator) -> (EncodedBase64String, mem.Allocator_Error) {
	strings.builder_make(0,)
}


EncodeBase32 :: proc(content: []byte, table: EncodingTable32 = basic_encoding_table_32, allocator: mem.Allocator = context.allocator) -> (EncodedBase32String, mem.Allocator_Error) {

}

EncodeBase16 :: proc(content: []byte, table: EncodingTable16 = basic_encoding_table_16, allocator: mem.Allocator = context.allocator) -> (EncodedBase16String, mem.Allocator_Error) {

}