BEGIN{
	out =  "[\n"
}
!/^$/{
	out = out "\t\\'" $1 "',\n"
}
END{
	out = substr(out, 1, length(out) - 2)
	out = out "]"
	print out
}
