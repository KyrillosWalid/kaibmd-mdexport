import strutils
import os

proc deletesign(s: string, sn: int): string = 
    var fstr: string
    var slen = s.len()
    for i in sn..slen-1:
        fstr = fstr & s[i]
    return fstr

var f: File
var filename: string = "file.md"
var outputfilename = "$1.html" % [filename]
if existsFile(outputfilename) == true:
    removeFile(outputfilename)

let hf = open(outputfilename, fmAppend)
hf.write("""
<html>
<head>
<meta charset = "UTF-8">
<title>$1</title>
</head>
<body>
""" % [filename])
if open(f, filename): 
    try:
        while true:
            var line = f.readLine()
            var aline = line.split(' ')
            case aline[0]:
                of "#":
                    hf.write("<h1>")
                    var ffline = deletesign(line,1)
                    hf.write("$1 </h1>\n" % [ffline])
                of "##":
                    hf.write("<h2>")
                    var ffline = deletesign(line,2)
                    hf.write("$1 </h2>\n" % [ffline])
                of "###":
                    hf.write("<h3>")
                    var ffline = deletesign(line,3)
                    hf.write("$1 </h3>\n" % [ffline])
                of "####":
                    hf.write("<h4>")
                    var ffline = deletesign(line,4)
                    hf.write("$1 </h4>\n" % [ffline])
                of "#####":
                    hf.write("<h5>")
                    var ffline = deletesign(line,5)
                    hf.write("$1 </h5>\n" % [ffline])
                of "######":
                    hf.write("<h6>")
                    var ffline = deletesign(line,6)
                    hf.write("$1 </h6>\n" % [ffline])
                of "![]":
                    hf.write("""<img src="""")
                    case aline[1]:
                        of "(":
                            hf.write(aline[2],"""  ">  """)

                of "-":
                    hf.write("<ul>")
                    hf.write("<li>")
                    var ulline = line
                    var ffline = deletesign(ulline,1)
                    case aline[1]:
                        of "#":
                            hf.write("<h1>")
                            var ffline = deletesign(ffline,1+1)
                            hf.write("$1 </h1>\n" % [ffline])
                            hf.write("</li>\n")
                            hf.write("</ul>")
                        of "##":
                            hf.write("<h2>")
                            var ffline = deletesign(ffline,2+1)
                            hf.write("$1 </h2>\n" % [ffline])
                            hf.write("</li>\n")
                            hf.write("</ul>")
                        of "###":
                            hf.write("<h3>")
                            var ffline = deletesign(ffline,3+1)
                            hf.write("$1 </h3>\n" % [ffline])
                            hf.write("</li>\n")
                            hf.write("</ul>")
                        of "####":
                            hf.write("<h4>")
                            var ffline = deletesign(ffline,4+1)
                            hf.write("$1 </h4>\n" % [ffline])
                            hf.write("</li>\n")
                            hf.write("</ul>")
                        of "#####":
                            hf.write("<h5>")
                            var ffline = deletesign(ffline,5+1)
                            hf.write("$1 </h5>\n" % [ffline])
                            hf.write("</li>\n")
                            hf.write("</ul>")
                        of "######":
                            hf.write("<h6>")
                            var ffline = deletesign(ffline,6+1)
                            hf.write("$1 </h6>\n" % [ffline])
                            hf.write("</li>\n")
                            hf.write("</ul>")
                        of "":
                            hf.write("$1 </li>\n" % [ffline])
                            hf.write("</ul>")
    except EOFError:
        echo "Done!"

hf.write("""
</body>
</html>
""")    
    