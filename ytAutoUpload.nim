import std/os
import std/strformat
import std/osproc
import std/strutils


proc check(vid: string): bool =
    if vid[^4 .. ^1] == "webm":
        return true
    else:
        return false



proc format(vid: string): string =
    var ret = vid.replace("./", "")
    ret = fmt"'{ret}'"
    return ret


proc convertUpload(video: string) =
    echo "video processing > ", video
    let newVid = video.replace("webm", "mp4")
    echo execProcess(fmt"ffmpeg -i {video} {newVid}")
    echo execProcess(fmt"rm {video}")
    echo "Uploading > ", newVid
    echo execProcess(fmt"./youtubeuploader -filename {newVid}")


proc getVidoes(): seq[string] =
    var list: seq[string]
    for x in walkdirRec("."):
        if check(x) == true:
            list.add(format(x))
        else:
            discard
    return list





proc main() =

    var list = getVidoes()
    for vid in list:
        convertUpload(vid)




when isMainModule:
    main()