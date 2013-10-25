require "ffi"

module Mydll
	extend FFI::Library
	ffi_lib './mydll.dll'
	#ffi_convention :stdcall

	attach_function :t, [], :void
	attach_function :nt, [], :int
	attach_function :st, [], :string
	attach_function :ti, [:int], :void
	attach_function :ts, [:string], :string
	attach_function :encode, [:string, :long], :string
end


p Mydll.t
p '----------------'

p Mydll.nt
p '----------------'

p Mydll.st
p '----------------'

p Mydll.ti 99
p '----------------'

p Mydll.ts "asdf-22"
p '----------------'

p Mydll.encode 'asfd,', 12
p '----------------'
